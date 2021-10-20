`include "caches_if.vh"
`include "datapath_cache_if.vh"
`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"

module dcache(
    input logic CLK,nRST,
    datapth_cache_if.dcache dcif,
    caches_if.dcache cdif,
    //cache_control_if.cc ccif
);
  // type import
import cpu_types_pkg::*;

//structs
//dcache_frame - [valid,dirty,tag, data[1:0]]
dcache_frame [7:0] table1;
dcache_frame [7:0] table2;
logic LRU [7:0];
int i=0;
typedef enum logic [2:0]{
  TAG = 3'b000,
  WB1 = 3'b001,
  WB2 = 3'b010,
  AL1 = 3'b011,
  AL2 = 3'b100,
  HALT = 3'b101,
  HALTWB1 = 3'b110,
  HALTWB2 = 3'b111
} state;
//dcache_t -  [tag-26, index-3, blkoff-1, bytoff-2]
dcachef_t daddr;
assign daddr.tag = dcif.daddr[31:6];
assign daddr.idx = dcif.daddr[5:3];
assign daddr.blkoff = dcif.daddr[2];
assign daddr.bytoff = dcif.daddr[1:0];
//assign daddr= dcif.daddr;

always_ff @(posedge CLK or negedge nRST) begin
  if(!nRST) begin
    table1 <= 'b0;
    table2 <= 'b0;
    dcif.dhit <= 1'b0;
    dcif.dload <= 32'b0;
    state <= TAG;
  end
  else 
    state<=next_state;
  end
always_comb begin
    cdif.dREN=1'b0;
    cdif.daddr=32'b0;
    cdif.dload=32'b0;
    cdif.dWEN =1'b0;

    case (state) 
      TAG: begin
        if((dcif.dREN | dcif.dWEN) & (table1[daddr.idx].tag ==daddr.tag) & (table1[daddr.idx].valid)) begin
          dcif.dhit =1'b1;
          dcif.dload = table1.data[daddr.blkoff];
          next_state = TAG; end
        else if((dcif.dREN | dcif.dWEN) & (table2[daddr.idx].tag==daddr.tag) & (table2[daddr.idx].valid)) begin
          dcif.dhit =1'b1;
          dcif.dload = table2.data[daddr.blkoff]; 
          next_state = TAG; end
        else begin
          if((LRU[daddr.idx]) & table1[daddr.idx].dirty)
            next_state= WB1;
          else if (!(LRU[daddr.idx]) & table2[daddr.idx].dirty)
            next_state=WB1;
          else if ((LRU[daddr.idx]) & !(table1[daddr.idx].dirty))
            next_state=AL1;
          else if (!(LRU[daddr.idx]) & !(table2[daddr.idx].dirty))
            next_state=AL1;
          else next_state =TAG;
        end
        end
      WB1: begin
        if((LRU[daddr.idx]) & table1[daddr.idx].dirty & (cdif.dwait==0)) begin
          cdif.dstore = table1[daddr.idx].data[0];
          cdif.daddr = 32'b{table1[daddr.idx].tag,daddr.idx,1'b0,2'b00};
          cdif.dWEN = 1'b1;
          next_state = WB2; end
        else if(!(LRU[daddr.idx]) & table2[daddr.idx].dirty & (cdif.dwait==0)) begin
          cdif.dstore = table2[daddr.idx].data[0];
          cdif.daddr = 32'b{table2[daddr.idx].tag,daddr.idx,1'b0,2'b00};
          cdif.dWEN = 1'b1;
          next_state =  WB2; end
        else if (cdif.dwait)
          next_state = WB1;
        end
      WB2:begin
        if((LRU[daddr.idx]) & table1[daddr.idx].dirty & (cdif.dwait==0)) begin
          cdif.dstore = table1[daddr.idx].data[1];
          cdif.daddr = 32'b{table1[daddr.idx].tag,daddr.idx,1'b1,2'b00};
          cdif.dWEN = 1'b1;
          table1[daddr.idx].dirty = 1'b0;
          next_state = AL1; end
        else if(!(LRU[daddr.idx]) & table2[daddr.idx].dirty & (cdif.dwait==0)) begin
          cdif.dstore = table2[daddr.idx].data[1];
          cdif.daddr = 32'b{table2[daddr.idx].tag,daddr.idx,1'b1,2'b00};
          cdif.dWEN = 1'b1;
          table2[daddr.idx].dirty = 1'b0;
          next_state = AL1; end
        else if (cdif.dwait)
          next_state = WB2;
      end
      AL1:begin
        if((LRU[daddr.idx]) & !(table1[daddr.idx].dirty) & (cdif.dwait==0))begin
          cdif.dREN = 1'b1;
          cdif.daddr = daddr;
          table1[daddr.idx].tag = daddr.tag;
          table1[daddr.idx].data[0] = cdif.dload;
          next_state = AL2;
        end
        else if(!(LRU[daddr.idx]) & !(table2[daddr.idx].dirty) & (cdif.dwait==0))begin
          cdif.dREN = 1'b1;
          cdif.daddr = daddr; //not sure
          table2[daddr.idx].tag = daddr.tag;
          table2[daddr.idx].data[0] = cdif.dload;
          next_state = AL2;
        end
        else if (cdif.dwait)
          next_state = AL1;
      end
      AL2:begin
        if((LRU[daddr.idx]) & !(table1[daddr.idx].dirty) & (cdif.dwait==0))begin
          cdif.dREN = 1'b1;
          cdif.daddr = daddr + 32'b100;
          //table1[daddr.idx].tag = daddr.tag;
          table1[daddr.idx].data[1] = cdif.dload;
          next_state = TAG;
        end
        else if(!(LRU[daddr.idx]) & !(table2[daddr.idx].dirty) & (cdif.dwait==0))begin
          cdif.dREN = 1'b1;
          cdif.daddr = daddr + 32'b100; //not sure
          //table2[daddr.idx].tag = daddr.tag;
          table2[daddr.idx].data[1] = cdif.dload;
          next_state = TAG;
        end
        else if (cdif.dwait)
          next_state = AL2;
      end
      HALT:begin
          daddr.idx= i;
          if(table1[daddr.idx].dirty == 1)
            next_state = HALTWB1;
          else if (table2[daddr.idx].dirty == 1)
            next_state = HALTWB1;
          else if(i<8) begin
            i=i+1;
            next_state = HALT;
          else begin
            table1 = 'b0;
            table2 = 'b0;
          end            
        end
      end
      HALTWB1: begin
        if (table1[daddr.idx].dirty == 1) begin
          cdif.dstore = table1[daddr.idx].data[0];
          cdif.daddr = 32'b{table1[daddr.idx].tag,daddr.idx,1'b0,2'b00};
          cdif.dWEN = 1'b1;
          next_state = HALTWB2;
        end
        else if(table2[daddr.idx].dirty == 1) begin
          cdif.dstore = table2[daddr.idx].data[0];
          cdif.daddr = 32'b{table2[daddr.idx].tag,daddr.idx,1'b0,2'b00};
          cdif.dWEN = 1'b1;
          next_state =  HALTWB2;
      end
      HALTWB2: begin
        if (table1[daddr.idx].dirty == 1) begin
          cdif.dstore = table1[daddr.idx].data[1];
          cdif.daddr = 32'b{table1[daddr.idx].tag,daddr.idx,1'b1,2'b00};
          cdif.dWEN = 1'b1;
          table1[daddr.idx].dirty = 1'b0;
          next_state = HALT;
        end
        else if (table2[daddr.idx].dirty == 1) begin
          cdif.dstore = table2[daddr.idx].data[1];
          cdif.daddr = 32'b{table2[daddr.idx].tag,daddr.idx,1'b1,2'b00};
          cdif.dWEN = 1'b1;
          table2[daddr.idx].dirty = 1'b0;
          next_state = HALT;
        end
      end
    endcase
    end

  end
endmodule