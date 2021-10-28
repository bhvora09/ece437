`include "caches_if.vh"
`include "datapath_cache_if.vh"
`include "cpu_types_pkg.vh"

module dcache(
    input logic CLK,nRST,
    datapath_cache_if.dcache dcif,
    caches_if.dcache cdif
    //cache_control_if.cc ccif
);
  // type import
import cpu_types_pkg::*;

//structs
//dcache_frame - [valid,dirty,tag, data[1:0]]
dcache_frame [7:0] table1,temptable1;
dcache_frame [7:0] table2,temptable2;
logic  [7:0] LRU = 0;
word_t dload1,dload2,dstore10,dstore11,dstore20,dstore21;
logic [26:0] tag1,tag2;
logic [2:0] index;
int a,b;
int i;
word_t hit_count,hit_count_next;

typedef enum logic [2:0]{
  TAG = 3'b000,
  WB1 = 3'b001,
  WB2 = 3'b010,
  AL1 = 3'b011,
  AL2 = 3'b100,
  HALT = 3'b101,
  HALTWB1 = 3'b110,
  HALTWB2 = 3'b111
} s;
s state;
s next_state;
//dcache_t -  [tag-26, index-3, blkoff-1, bytoff-2]
dcachef_t daddr;

assign daddr.tag = dcif.dmemaddr[31:6];
assign daddr.idx = dcif.dmemaddr[5:3];
assign daddr.blkoff = dcif.dmemaddr[2];
assign daddr.bytoff = dcif.dmemaddr[1:0];
//assign daddr= dcif.dmemaddr;
assign dload1 = table1[daddr.idx].data[daddr.blkoff];
assign dload2 = table2[daddr.idx].data[daddr.blkoff];
assign dstore10 = table1[daddr.idx].data[0];
assign dstore20 = table2[daddr.idx].data[0];
assign tag1 = table1[daddr.idx].tag;
assign tag2 = table2[daddr.idx].tag;
assign dstore11 = table1[daddr.idx].data[1];
assign dstore21 = table2[daddr.idx].data[1];
assign index = daddr.idx;

always_ff @(posedge CLK or negedge nRST) begin
  if(!nRST) begin
    table1 <= 0;
    table2 <= 0;
    state <= TAG;
    hit_count <= 0;
  end
  else begin
    table1 <= temptable1;
    table2 <= temptable2;
    state<=next_state;
    hit_count <= hit_count_next;
  end
end

always_comb begin
    cdif.dREN=1'b0;
    //cdif.daddr=32'b0;
    cdif.dWEN =1'b0;
    dcif.dhit = 1'b0;
    dcif.dmemload = 32'b0;
    temptable1 = table1;
    temptable2 = table2;
    dcif.flushed =1'b0;
    next_state = state;
    hit_count_next = hit_count;
    case (state) 
      TAG: begin
        if (dcif.halt) begin
          next_state = HALT;
          i=0;
          hit_count_next = hit_count; end
        else if(dcif.dmemREN & (table1[daddr.idx].tag ==daddr.tag) & (table1[daddr.idx].valid)) begin
          dcif.dhit =1'b1;
          dcif.dmemload = dload1;
          next_state = TAG; 
          LRU[daddr.idx]=1'b0;
          hit_count_next = hit_count +1; end
        else if(dcif.dmemREN & (table2[daddr.idx].tag==daddr.tag) & (table2[daddr.idx].valid)) begin
          dcif.dhit =1'b1;
          dcif.dmemload = dload2; 
          next_state = TAG; 
          LRU[daddr.idx] =1'b1; 
          hit_count_next = hit_count +1; end
        else if (dcif.dmemWEN & (table1[daddr.idx].tag ==daddr.tag) & !(table1[daddr.idx].dirty) & LRU[daddr.idx] ) begin
          if(daddr.blkoff==0) begin
            temptable1[daddr.idx].data[0] = dcif.dmemstore;
            temptable1[daddr.idx].dirty =1'b1;
            dcif.dhit=1'b1;
            next_state = TAG;
            hit_count_next = hit_count +1;end
          else if(daddr.blkoff==1) begin
            temptable1[daddr.idx].data[1] = dcif.dmemstore;
            temptable1[daddr.idx].dirty =1'b1;
            dcif.dhit=1'b1;
            next_state = TAG;
            hit_count_next = hit_count +1;
          end
        end
        else if(dcif.dmemWEN & (table2[daddr.idx].tag==daddr.tag) &  & (!(table2[daddr.idx].dirty))& (!LRU[daddr.idx]) ) begin
          if (daddr.blkoff==0) begin
            temptable2[daddr.idx].data[0] = dcif.dmemstore;
            temptable2[daddr.idx].dirty =1'b1;
            dcif.dhit=1'b1;
            next_state = TAG;
            hit_count_next = hit_count +1;
          end
          else if (daddr.blkoff==1) begin
            temptable2[daddr.idx].data[1] = dcif.dmemstore;
            temptable2[daddr.idx].dirty =1'b1;
            dcif.dhit=1'b1;
            next_state = TAG;
            hit_count_next = hit_count +1;
          end
        end
        else if((dcif.dmemWEN | dcif.dmemREN) & (LRU[daddr.idx]) & table1[daddr.idx].dirty)
          next_state= WB1;
        else if ((dcif.dmemWEN | dcif.dmemREN) & !(LRU[daddr.idx]) & table2[daddr.idx].dirty)
          next_state=WB1;
        else if ((dcif.dmemWEN | dcif.dmemREN) & (LRU[daddr.idx]) & !(table1[daddr.idx].dirty))
          next_state=AL1;
        else if ((dcif.dmemWEN | dcif.dmemREN) & !(LRU[daddr.idx]) & !(table2[daddr.idx].dirty))
          next_state=AL1;
        else begin 
          next_state =TAG;
          hit_count_next = hit_count -1; end
      end
      WB1: begin
        if((LRU[daddr.idx]) & table1[daddr.idx].dirty & (cdif.dwait==0)) begin
          cdif.dstore = dstore10;
          cdif.daddr = {tag1,index,1'b0,2'b00};
          cdif.dWEN = 1'b1;
          next_state = WB2; end
        else if(!(LRU[daddr.idx]) & table2[daddr.idx].dirty & (cdif.dwait==0)) begin
          cdif.dstore = dstore20;
          cdif.daddr = {tag2,index,1'b0,2'b00};
          cdif.dWEN = 1'b1;
          next_state =  WB2; end
        else if (cdif.dwait) begin
          next_state = WB1;
          cdif.dWEN = 1'b1; end
      end
      WB2:begin
        if((LRU[daddr.idx]) & table1[daddr.idx].dirty & (cdif.dwait==0)) begin
          cdif.dstore = dstore11;
          cdif.daddr = {tag1,index,1'b1,2'b00};
          cdif.dWEN = 1'b1;
          temptable1[daddr.idx].dirty = 1'b0;
          next_state = AL1; end
        else if(!(LRU[daddr.idx]) & table2[daddr.idx].dirty & (cdif.dwait==0)) begin
          cdif.dstore = dstore21;
          cdif.daddr = {tag2,index,1'b1,2'b00};
          cdif.dWEN = 1'b1;
          temptable2[daddr.idx].dirty = 1'b0;
          next_state = AL1; end
        else if (cdif.dwait) begin
          next_state = WB2;
          cdif.dWEN = 1'b1; end
      end
      AL1:begin
        if((LRU[daddr.idx]) & !(table1[daddr.idx].dirty) & (cdif.dwait==0))begin
          cdif.dREN = 1'b1;
          temptable1[daddr.idx].tag = daddr.tag;
          temptable1[daddr.idx].data[0] = cdif.dload;
          next_state = AL2;
          if(daddr.blkoff == 0)
            cdif.daddr = daddr;
          else
            cdif.daddr = daddr - 3'b100;
        end
        else if(!(LRU[daddr.idx]) & !(table2[daddr.idx].dirty) & (cdif.dwait==0))begin
          cdif.dREN = 1'b1;
          temptable2[daddr.idx].tag = daddr.tag;
          temptable2[daddr.idx].data[0] = cdif.dload;
          next_state = AL2;
          if(daddr.blkoff == 0)
            cdif.daddr = daddr;
          else
            cdif.daddr = daddr - 3'b100;
          end
        else if (cdif.dwait) begin
          next_state = AL1;
          cdif.dREN =1'b1; end
      end
      AL2:begin
        if((LRU[daddr.idx]) & !(table1[daddr.idx].dirty) & (cdif.dwait==0))begin
          cdif.dREN = 1'b1;
          temptable1[daddr.idx].tag = daddr.tag;
          temptable1[daddr.idx].data[1] = cdif.dload;
          temptable1[daddr.idx].valid = 1'b1;
          next_state = TAG;
          if(daddr.blkoff == 0)
            cdif.daddr = daddr+ 3'b100;
          else
            cdif.daddr = daddr ;
        end
        else if(!(LRU[daddr.idx]) & !(table2[daddr.idx].dirty) & (cdif.dwait==0))begin
          cdif.dREN = 1'b1;
          temptable2[daddr.idx].tag = daddr.tag;
          temptable2[daddr.idx].data[1] = cdif.dload;
          temptable2[daddr.idx].valid = 1'b1;
          next_state = TAG;
          if(daddr.blkoff == 0)
            cdif.daddr = daddr + 3'b100;
          else
            cdif.daddr = daddr ;
        end
        else if (cdif.dwait) begin
          next_state = AL2;
          cdif.dREN =1'b1; end
      end
      HALT:begin
        if(dcif.halt)begin
          if(((table1[i].dirty == 1) & (cdif.dwait==0)) | ((table2[i].dirty == 1) & (cdif.dwait==0)))
            next_state = HALTWB1;
          else if(cdif.dwait)
            next_state = HALT;
          else if(i<8) begin
            while(i<8) begin
              if((table1[i].dirty == 0) & (table2[i].dirty == 0) & (cdif.dwait==0)) begin
                temptable1[i] = 'b0;
                temptable2[i] = 'b0;
                i=i+1;
              end
              else if(i<8) begin
                next_state = HALTWB1;
                break; end
              else if(i==8) begin
                cdif.dWEN = 1'b1;
                cdif.daddr= 32'h3100;
                cdif.dstore = hit_count;
                temptable1 = 'b0;
                temptable2 = 'b0;
                dcif.flushed = 1'b1;
                break;
              end       
          end
          end
          else if(i==8) begin
            cdif.dWEN = 1'b1;
            cdif.daddr= 32'h3100;
            cdif.dstore = hit_count;
            temptable1 = 'b0;
            temptable2 = 'b0;
            dcif.flushed = 1'b1;
          end            
        end
      end
      HALTWB1: begin
        if ((table1[i].dirty == 1) & (cdif.dwait==0)) begin
          cdif.dstore = table1[i].data[0];
          cdif.daddr = {table1[i].tag,3'(i),1'b0,2'b00};
          cdif.dWEN = 1'b1;
          next_state = HALTWB2;
        end
        else if((table2[i].dirty == 1) & (cdif.dwait==0)) begin
          cdif.dstore = table2[i].data[0];
          cdif.daddr = {table2[i].tag,3'(i),1'b0,2'b00};
          cdif.dWEN = 1'b1;
          next_state = HALTWB2;
        end
        else if (cdif.dwait)
          next_state = HALTWB1;
          cdif.dWEN = 1'b1;
      end
      HALTWB2: begin
        if ((table1[i].dirty == 1) & (cdif.dwait==0)) begin
          cdif.dstore = table1[i].data[1];
          cdif.daddr = {table1[i].tag,3'(i),1'b1,2'b00};
          cdif.dWEN = 1'b1;
          temptable1[i].dirty = 1'b0;
          next_state = HALT;
        end
        else if ((table2[i].dirty == 1 )& (cdif.dwait==0)) begin
          cdif.dstore = table2[i].data[1];
          cdif.daddr = {table2[i].tag,3'(i),1'b1,2'b00};
          cdif.dWEN = 1'b1;
          temptable2[i].dirty = 1'b0;
          next_state = HALT;
        end
        else if (cdif.dwait)
          next_state = HALTWB1;
          cdif.dWEN = 1'b1;
      end
    endcase
    end

endmodule