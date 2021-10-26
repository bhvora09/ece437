`include "caches_if.vh"
`include "datapath_cache_if.vh"
`include "cache_control_if.vh"
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
logic dirty1=0, dirty2=0;
logic hit1=0,hit2=0;
int i;
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
  end
  else begin
    table1 <= temptable1;
    table2 <= temptable2;
    state<=next_state;
  end
end

always_comb begin
    cdif.dREN=1'b0;
    cdif.daddr=32'b0;
    cdif.dWEN =1'b0;
    dcif.dhit = 1'b0;
    dcif.dmemload = 32'b0;
    temptable1 = table1;
    temptable2 = table2;
    dcif.flushed =1'b0;
    cdif.dstore = 32'b0;
    next_state = state;
    case (state) 
      TAG: begin
        if(dcif.dmemREN & (temptable1[daddr.idx].tag ==daddr.tag) & (temptable1[daddr.idx].valid)) begin
          dcif.dhit =1'b1;
          dcif.dmemload = dload1;
          next_state = TAG; 
          LRU[daddr.idx]=1'b0;end
        else if(dcif.dmemREN & (temptable2[daddr.idx].tag==daddr.tag) & (temptable2[daddr.idx].valid)) begin
          dcif.dhit =1'b1;
          dcif.dmemload = dload2; 
          next_state = TAG; 
          LRU[daddr.idx] =1'b1; end
        else if (dcif.dmemWEN & (temptable1[daddr.idx].tag ==daddr.tag) & !(temptable1[daddr.idx].dirty)) begin
          if (LRU[daddr.idx] & (daddr.blkoff==0)) begin
            temptable1[daddr.idx].tag = daddr.tag;
            temptable1[daddr.idx].data[0] = dcif.dmemstore;
            temptable1[daddr.idx].dirty =1'b1;
            dcif.dhit=1'b1;
            LRU[daddr.idx]=1'b0;
            next_state = TAG;end
          else if((LRU[daddr.idx] & (daddr.blkoff==1))) begin
            temptable1[daddr.idx].tag = daddr.tag;
            temptable1[daddr.idx].data[1] = dcif.dmemstore;
            temptable1[daddr.idx].dirty =1'b1;
            dcif.dhit=1'b1;
            LRU[daddr.idx]=1'b0;
            next_state = TAG;
          end
        end
        else if(dcif.dmemWEN & (temptable2[daddr.idx].tag==daddr.tag) &  & (!(temptable2[daddr.idx].dirty))) begin
          if (!LRU[daddr.idx] & (daddr.blkoff==0)) begin
            temptable2[daddr.idx].tag = daddr.tag;
            temptable2[daddr.idx].data[0] = dcif.dmemstore;
            temptable2[daddr.idx].dirty =1'b1;
            dcif.dhit=1'b1;
            LRU[daddr.idx]=1'b1;
            next_state = TAG;
          end
          else if (!LRU[daddr.idx] & (daddr.blkoff==1)) begin
            temptable2[daddr.idx].tag = daddr.tag;
            temptable2[daddr.idx].data[1] = dcif.dmemstore;
            temptable2[daddr.idx].dirty =1'b1;
            dcif.dhit=1'b1;
            LRU[daddr.idx]=1'b1;
            next_state = TAG;
          end
        end
        else if((dcif.dmemWEN | dcif.dmemREN) & (LRU[daddr.idx]) & temptable1[daddr.idx].dirty)
          next_state= WB1;
        else if ((dcif.dmemWEN | dcif.dmemREN) & !(LRU[daddr.idx]) & temptable2[daddr.idx].dirty)
          next_state=WB1;
        else if ((dcif.dmemWEN | dcif.dmemREN) & (LRU[daddr.idx]) & !(temptable1[daddr.idx].dirty))
          next_state=AL1;
        else if ((dcif.dmemWEN | dcif.dmemREN) & !(LRU[daddr.idx]) & !(temptable2[daddr.idx].dirty))
          next_state=AL1;
        else if (dcif.halt) begin
          next_state = HALT;
          i=0;end
        else next_state =TAG;
      end
      WB1: begin
        if((LRU[daddr.idx]) & temptable1[daddr.idx].dirty & (cdif.dwait==0)) begin
          cdif.dstore = dstore10;
          cdif.daddr = {tag1,index,1'b0,2'b00};
          cdif.dWEN = 1'b1;
          next_state = WB2; end
        else if(!(LRU[daddr.idx]) & temptable2[daddr.idx].dirty & (cdif.dwait==0)) begin
          cdif.dstore = dstore20;
          cdif.daddr = {tag2,index,1'b0,2'b00};
          cdif.dWEN = 1'b1;
          next_state =  WB2; end
        else if (cdif.dwait)
          next_state = WB1;
        end
      WB2:begin
        if((LRU[daddr.idx]) & temptable1[daddr.idx].dirty & (cdif.dwait==0)) begin
          cdif.dstore = dstore11;
          cdif.daddr = {tag1,index,1'b1,2'b00};
          cdif.dWEN = 1'b1;
          temptable1[daddr.idx].dirty = 1'b0;
          next_state = AL1; end
        else if(!(LRU[daddr.idx]) & temptable2[daddr.idx].dirty & (cdif.dwait==0)) begin
          cdif.dstore = dstore21;
          cdif.daddr = {tag2,index,1'b1,2'b00};
          cdif.dWEN = 1'b1;
          temptable2[daddr.idx].dirty = 1'b0;
          next_state = AL1; end
        else if (cdif.dwait)
          next_state = WB2;
      end
      AL1:begin
        if((LRU[daddr.idx]) & !(temptable1[daddr.idx].dirty) & (cdif.dwait==0))begin
          cdif.dREN = 1'b1;
          cdif.daddr = daddr;
          temptable1[daddr.idx].tag = daddr.tag;
          temptable1[daddr.idx].data[0] = cdif.dload;
          next_state = AL2;
        end
        else if(!(LRU[daddr.idx]) & !(temptable2[daddr.idx].dirty) & (cdif.dwait==0))begin
          cdif.dREN = 1'b1;
          cdif.daddr = daddr; //not sure
          temptable2[daddr.idx].tag = daddr.tag;
          temptable2[daddr.idx].data[0] = cdif.dload;
          next_state = AL2;end
        else if (cdif.dwait)
          next_state = AL1;
      end
      AL2:begin
        if((LRU[daddr.idx]) & !(temptable1[daddr.idx].dirty) & (cdif.dwait==0))begin
          cdif.dREN = 1'b1;
          cdif.daddr = daddr + 32'b100;
          temptable1[daddr.idx].tag = daddr.tag;
          temptable1[daddr.idx].data[1] = cdif.dload;
          temptable1[daddr.idx].valid = 1'b1;
          next_state = TAG;
        end
        else if(!(LRU[daddr.idx]) & !(temptable2[daddr.idx].dirty) & (cdif.dwait==0))begin
          cdif.dREN = 1'b1;
          cdif.daddr = daddr + 32'b100; //not sure
          temptable2[daddr.idx].tag = daddr.tag;
          temptable2[daddr.idx].data[1] = cdif.dload;
          temptable2[daddr.idx].valid = 1'b1;
          next_state = TAG;
        end
        else if (cdif.dwait)
          next_state = AL2;
      end
      HALT:begin
        if(dcif.halt)begin
          if((temptable1[i].dirty == 1) & (cdif.dwait==0))
            next_state = HALTWB1;
          else if ((temptable2[i].dirty == 1 )& (cdif.dwait==0))
            next_state = HALTWB1;
          else if(i<8) begin
            while(!(temptable1[i].dirty == 1) & (cdif.dwait==0) & (!(temptable2[i].dirty == 1 )& (cdif.dwait==0)) & (i<8)) begin
              temptable1[i] = 'b0;
              temptable2[i] = 'b0;
              i=i+1;
            end
            next_state = HALT;
          end
          else begin
            temptable1 = 'b0;
            temptable2 = 'b0;
            dcif.flushed = 1'b1;
          end            
        end
      end
      HALTWB1: begin
        if ((temptable1[i].dirty == 1) & (cdif.dwait==0)) begin
          cdif.dstore = temptable1[i].data[0];
          cdif.daddr = {tag1,index,1'b0,2'b00};
          cdif.dWEN = 1'b1;
          next_state = HALTWB2;
        end
        else if((temptable2[i].dirty == 1) & (cdif.dwait==0)) begin
          cdif.dstore = temptable2[i].data[0];
          cdif.daddr = {tag2,index,1'b0,2'b00};
          cdif.dWEN = 1'b1;
          next_state = HALTWB2;
        end
        else if (cdif.dwait)
          next_state = HALTWB1;
      end
      HALTWB2: begin
        if ((temptable1[i].dirty == 1) & (cdif.dwait==0)) begin
          cdif.dstore = temptable1[i].data[1];
          cdif.daddr = {tag1,index,1'b1,2'b00};
          cdif.dWEN = 1'b1;
          temptable1[i].dirty = 1'b0;
          next_state = HALT;
        end
        else if ((temptable2[i].dirty == 1 )& (cdif.dwait==0)) begin
          cdif.dstore = temptable2[i].data[1];
          cdif.daddr = {tag2,index,1'b1,2'b00};
          cdif.dWEN = 1'b1;
          temptable2[i].dirty = 1'b0;
          next_state = HALT;
        end
        else if (cdif.dwait)
          next_state = HALTWB1;
      end
    endcase
    end

endmodule