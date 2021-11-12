/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;
  
  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  
  // test program
  test PROG (CLK, nRST, v1,v2,v3, rfif);
  
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

program test(
  input  logic CLK,
  output logic nRST,
  input int v1,v2,v3,
  register_file_if.tb rfif
);

int testcases;
initial begin
  //initial conditions
  rfif.WEN='b0;
  rfif.wsel='b0;
  rfif.rsel1='b0;
  rfif.rsel2='b0;
  rfif.wdat='b0;

  // ignore this first reset
  @(posedge CLK)
  nRST='b0;
  
  //checking values at nreset=0 and v1 shouldn't go to r0
  @(posedge CLK)
  nRST='b0;
  rfif.wdat=v1;
  //checking values at nreset=1
  @(posedge CLK)
  
  //checking when WEN=1
  rfif.WEN='b1;

  //asynchronous reset
  @(posedge CLK)
  nRST='b1;
  
  @(posedge CLK)
  //testing writes to reg 0
  rfif.wsel='b0;


  // testing writes to reg file
  @(posedge CLK)
  //checking if wsel affects regfile
  rfif.wsel='b1;

  //testing writes to registers1 and reg2
  @(posedge CLK)
  // making rsel1 = 1 so that rdat1 = v1
  rfif.rsel1='b1;

  @(posedge CLK)
  rfif.wsel='b10;
  rfif.wdat =v2;
  rfif.rsel2='b10;

  @(posedge CLK)
  rfif.wsel='b11;
  rfif.wdat =56721;
  rfif.rsel1='b11100;
  rfif.rsel2='b11;

   @(posedge CLK)
  rfif.wsel='b11;
   rfif.wdat =78937;
  rfif.rsel1='b11111;
  rfif.rsel2='b11;


end
endprogram
