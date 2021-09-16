`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"
`include "system_if.vh"
import cpu_types_pkg::*;
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module control_unit_tb;
  
  parameter PERIOD = 10;

  logic CLK = 0;
  // clock
  always #(PERIOD/2) CLK++;

  // interface
    control_unit_if cuif ();
    system_if sysif();
  //test program
    test PROG (CLK,cuif);

  // DUT
  control_unit CUDUT(cuif);
  //system sys(sysif);

endmodule

program test(
    input logic CLK,
    control_unit_if.tb cuif
);
parameter PERIOD =10;
initial begin
    cuif.instr='b0;
    //rtype
    @(posedge CLK)
    cuif.instr[31:26]=RTYPE;
    cuif.instr[25:21]=5'b10101;
    cuif.instr[20:16]=5'b01010;
    cuif.instr[15:11]=5'b10000;
    cuif.instr[10:6]=5'b0;
    cuif.instr[5:0]=ALU_ADD;
    
    #(PERIOD);

    //j 
    @(posedge CLK)
    cuif.instr[31:26]=J;
    //cuif.instr[25:0]= {2'b10,5'hABCDEF};

    #(PERIOD);
    //jal 
    @(posedge CLK)
    cuif.instr[31:26]=JAL;
    //cuif.instr[25:0]= {2'b10,5'hBACDEF};

    #(PERIOD);
    
    //jr
    @(posedge CLK)
    cuif.instr[31:26]=RTYPE;
    cuif.instr[5:0]= JR;
    //cuif.instr[25:0]= {2'b11,5'hFFFFFF};

    #(PERIOD);
   
   //beq
    @(posedge CLK)
    cuif.instr[31:26]=BEQ;
    cuif.instr[25:21]=5'b10101;
    cuif.instr[20:16]=5'b01010;
    cuif.instr[15:0]= 16'hABCD;
    //cuif.instr[25:0]= {2'b11,5'hFFFFFF};

    #(PERIOD);

    //bne
    @(posedge CLK)
    cuif.instr[31:26]=BNE;
    cuif.instr[25:21]=5'b10101;
    cuif.instr[20:16]=5'b01010;
    cuif.instr[15:0]= 16'hABCD;
    //cuif.instr[25:0]= {2'b11,5'hFFFFFF};

    #(PERIOD);

    //addi
    @(posedge CLK)
    cuif.instr[31:26]=ADDI;
    cuif.instr[25:21]=5'b10101;
    cuif.instr[20:16]=5'b01010;
    cuif.instr[15:0]= 16'hABCD;
    //cuif.instr[25:0]= {2'b11,5'hFFFFFF};


    #(PERIOD);

    //lw
    @(posedge CLK)
    cuif.instr[31:26]=LW;
    cuif.instr[25:21]=5'b10101;
    cuif.instr[20:16]=5'b01010;
    cuif.instr[15:0]= 16'h0008;
    //cuif.instr[25:0]= {2'b11,5'hFFFFFF};

    #(PERIOD);

    //addi
    @(posedge CLK)
    cuif.instr[31:26]=SW;
    cuif.instr[25:21]=5'b10101;
    cuif.instr[20:16]=5'b01010;
    cuif.instr[15:0]= 16'h0004;
    //cuif.instr[25:0]= {2'b11,5'hFFFFFF};


    #(PERIOD);

    //addi
    @(posedge CLK)
    cuif.instr[31:26]=HALT;

end
endprogram