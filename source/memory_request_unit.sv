`include "memory_request_unit_if.vh"
`include "cpu_types_pkg.vh"

module memory_request_unit(
    input CLK,
    input nRST,
    memory_request_unit_if.mru mruif
);
  // type import
  import cpu_types_pkg::*;
 //logic CLK, nRST;
 assign mruif.imemREN=1;

  always_ff@(posedge CLK or negedge nRST) begin
    // mruif.imemREN<=1'b1;
    if (!nRST) begin
      //$display("nRST=0");
      mruif.dmemREN<=1'b0;
      mruif.dmemWEN<=1'b0;
    end
    else begin
      if (mruif.dhit) begin
        //$display("dhit");
        mruif.dmemREN<=1'b0;
        mruif.dmemWEN<=1'b0;
      end
      else if (mruif.ihit) begin
      mruif.dmemREN<=mruif.dren;
      mruif.dmemWEN<=mruif.dwen;
      end
    end
  end
endmodule