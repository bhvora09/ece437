`include "caches_if.vh"
`include "datapath_cache_if.vh"
`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"

module dcache(
    input logic CLK,nRST,
    datapth_cache_if.dcache dcif,
    caches_if.dcache cdif,
);
  // type import
import cpu_types_pkg::*;

//structs
//dcache_frame - [valid,dirty,tag, data[1:0]]
dcache_frame [7:0] table1;
dcache_frame [7:0] table2;
logic LRU [7:0];

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

always_comb begin

end

always_ff @(posedge CLK or negedge nRST) begin
  if(!nRST) begin
    table1 <= 'b0;
    table2 <= 'b0;
    dcif.dhit <= 1'b0;
    dcif.dload <= 32'b0;
    state = TAG;
  end
  else begin
    state<=next_state;
    case (state) 
      TAG: begin
        if((dcif.dREN | dcif.dWEN) & (table1[daddr.idx].tag ==daddr.tag) & (table1[daddr.idx].valid)) begin
          dcif.dhit <=1'b1;
          dcif.dload <= table1.data[daddr.blkoff];
          next_state <= TAG; end
        else if((dcif.dREN | dcif.dWEN) & (table2[daddr.idx].tag==daddr.tag) & (table2[daddr.idx].valid)) begin
          dcif.dhit <=1'b1;
          dcif.dload <= table2.data[daddr.blkoff]; 
          next_state <= TAG; end
        else begin
          if((LRU[daddr.idx]) & (table1[daddr.idx].dirty | table2[daddr.idx].dirty))
            next_state<= WB1;
            
        end
        end

      end
      WB1: begin
      end
      WB2:begin
      end
      AL1:begin
      end
      AL2:begin
      end
      HALT:begin
      end
      HALTWB1: begin
      end
      HALTWB2: begin
      end
    endcase
    end

  end
endmodule