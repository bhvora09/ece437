`include "memory_request_unit_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module memory_request_unit_tb;
  
  parameter PERIOD = 10;

  logic CLK = 0;
  logic nRST;
  // clock
  always #(PERIOD/2) CLK++;

  // interface
    memory_request_unit_if mruif();
  //test program
    test PROG (CLK,nRST,mruif);

  // DUT
  memory_request_unit MRUDUT(CLK,nRST,mruif);

endmodule

program test(
    input logic CLK,
    output logic nRST,
    memory_request_unit_if.tb mruif
);
parameter PERIOD =10;

initial begin
    nRST='b0;
    mruif.ihit='b0;
    mruif.dhit='b0;
    mruif.dren='b1;
    mruif.dwen='b1;
    mruif.iren='b1;

    @(posedge CLK)
    nRST='b1;
    mruif.ihit='b1;
    mruif.dhit='b0;
    mruif.dren='b1;
    mruif.dwen='b1;
    mruif.iren='b1;

    @(posedge CLK)
    mruif.ihit='b0;
    mruif.dhit='b1;
    mruif.dren='b1;
    mruif.dwen='b1;
    mruif.iren='b1;

    @(posedge CLK)
    mruif.ihit='b0;
    mruif.dhit='b1;
    mruif.dren='b1;
    mruif.dwen='b1;
    mruif.iren='b1;
end
endprogram



