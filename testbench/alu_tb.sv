/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
//`include "register_file_if.vh"
`include "alu_if.vh"
`include "cpu_types_pkg.vh"
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns
import cpu_types_pkg::*;

module alu_tb;

  parameter PERIOD = 10;

  logic CLK = 0;
  // clock
  always #(PERIOD/2) CLK++;

  // interface
    alu_if aluif ();
  //test program
    test PROG (CLK,aluif);

  // DUT
`ifndef MAPPED
  alu DUT(aluif);
`else
  alu DUT(
    .\aluif.portA (aluif.portA),
    .\aluif.portB (aluif.portB),
    .\aluif.portOut (aluif.portOut),
    .\aluif.op (aluif.op),
    .\aluif.flagNeg (aluif.flagNeg),
    .\aluif.flagOvf (aluif.flagOvf),
    .\aluif.flagZero (aluif.flagZero)
    //.\nRST (nRST),
    //.\CLK (CLK)
  );
`endif
endmodule

program test(
    input logic CLK,
    alu_if.tb aluif
);

initial begin
    aluif.portA='b0;
    aluif.portB='b0;
    aluif.op='b1111;

    @(posedge CLK)
    aluif.portA='b0;
    aluif.portB='b0;
    //check zero flag
    aluif.op='b10;

    @(posedge CLK)
    aluif.portA='b10101;
    aluif.portB='b1010;
    //op=Shift left by 10 bits
    aluif.op='b0;

    @(posedge CLK)
    aluif.portA='b101010;
    //>32 bits
    aluif.portB= 'b111111;
    //op=Shift left by >32 bits
    aluif.op='b0;

    @(posedge CLK)
    aluif.portA='b101010;
    aluif.portB='b1;
    //op=Shift right by 1 bit 
    aluif.op='b1;

    @(posedge CLK)
    aluif.portA='b101010;
    aluif.portB='b1100;
    //op=Shift right > 12 bits
    aluif.op='b1;

    @(posedge CLK)
    aluif.portA='b101010;
    aluif.portB='b1100;
    //op=add 
    aluif.op='b10;

    @(posedge CLK)
    aluif.portA='hFFFFFF04;
    aluif.portB=$signed('hFFFFFFF0);
    //op=add signed
    aluif.op='b10;

    @(posedge CLK)
    aluif.portA=$signed('hFFFFFFF4);
    aluif.portB=$signed('hFFFFFFF6);
    //op=check carry and neg flag
    aluif.op='b10;

    @(posedge CLK)
    aluif.portA=$signed('hFFFFFFF4);
    aluif.portB=$signed('hFFFFFFF6);
    //op=subtract 
    aluif.op='b11;

    @(posedge CLK)
    aluif.portA=$signed('hAAAA0B04);
    aluif.portB=$signed('hFFFFFFF6);
    //op=check and
    aluif.op='b100;

    @(posedge CLK)
    aluif.portA=$signed('hAAAA0B04);
    aluif.portB=$signed('hFFFFFFF6);
    //op=check OR
    aluif.op='b101;

    @(posedge CLK)
    aluif.portA=$signed('hAAAA0B04);
    aluif.portB=$signed('hFFFFFFF6);
    //op=check xor
    aluif.op='b110;

    @(posedge CLK)
    aluif.portA=$signed('hAAAA0B04);
    aluif.portB=$signed('hFFFFFFF6);
    //op=check nor
    aluif.op='b111;

    @(posedge CLK)
    aluif.portA='d32;
    aluif.portB='d34;
    //op=check less than
    aluif.op='b1010;

    @(posedge CLK)
    aluif.portA='d32;
    aluif.portB='d30;
    //op=check less than
    aluif.op='b1010;

    @(posedge CLK)
    aluif.portA=$signed('hAAAA0B04);
    aluif.portB=$signed('hFFFFFFF6);
    //op=check less than
    aluif.op='b1010;

    @(posedge CLK)
    aluif.portA='d32;
    aluif.portB='d34;
    //op=check less than
    aluif.op='b1011;

    @(posedge CLK)
    aluif.portA='d32;
    aluif.portB='d30;
    //op=check less than
    aluif.op='b1011;

    @(posedge CLK)
    aluif.portA=$signed('hAAAA0B04);
    aluif.portB=$signed('hFFFFFFF6);
    //op=check less than
    aluif.op='b1011;






end

endprogram
