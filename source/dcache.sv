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

//dcache_t -  [tag-26, index-3, blkoff-1, bytoff-2]
dcachef_t daddr;
assign daddr.tag = dcif.daddr[31:6];
assign daddr.idx = dcif.daddr[5:3];
assign daddr.blkoff = dcif.daddr[2];
assign daddr.bytoff = dcif.daddr[1:0];

always_ff @(posedge CLK or negedge nRST) begin
  if(!nRST) begin
    table1 = 'b0;
    table2 = 'b0;
  end
  else begin
    case (state) 
      TAG: begin
        if(dcif.)
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