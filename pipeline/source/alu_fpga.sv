/**
 *  alu_fpga.sv
 * 
 *  Author  : Abhishek Bhaumick
 * 
 */

// interface
`include "alu_if.vh"
`include "cpu_types_pkg.vh"
module alu_fpga (
  input logic CLOCK_50,
  input logic [3:0] KEY,
  input logic [17:0] SW,
  output logic [17:0] LEDR,
  output logic [7:0] LEDG
);
  import cpu_types_pkg::*;
 
  word_t regB = 32'b0;
  logic [17:0] ledDisp;

  always_latch begin : setPortB
    if (SW[17] == 1'b1) begin
      regB = {16'b0, SW[16:0]};
    end else begin
      regB = regB;
    end
  end

  // interface
  alu_if aluif();

  // rf
  alu ALU(aluif);

  assign aluif.portA = {15'h0, SW[16:0]};
  assign aluif.portB = {15'h0, regB[16:0]};
  assign aluif.op = aluop_t'(KEY[3:0]);

  assign LEDR[17:0] = aluif.portOut;

  assign LEDG[0] = aluif.flagZero;
  assign LEDG[1] = aluif.flagNeg;
  assign LEDG[2] = aluif.flagOvf;

  assign LEDG[7:4] = aluif.op;

endmodule
