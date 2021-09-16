`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;

  //logic     CLK, nRST;
  //regbits_t, rsel1, rsel2;
  
  word_t    instr;
  aluop_t  ALUctr;
  logic [1:0] PCsrc;
  logic     PCen,RegDst,RegWr,MemWr,MemtoReg,ExtOp,ALUSrc,jal_s,dREN,dWEN,iREN,halt; //dren using pcsrc 

  // pc ports
  modport cu (
    input   instr,
    output  PCen,PCsrc,RegDst,RegWr,ALUctr,MemWr,MemtoReg,ExtOp,ALUSrc,jal_s,dREN,dWEN,iREN,halt
  );
  // pc tb
  modport tb (
    input   PCen,PCsrc,RegDst,RegWr,ALUctr,MemWr,MemtoReg,ExtOp,ALUSrc,jal_s,dREN, dWEN,iREN,halt,
    output  instr
  );
endinterface

`endif //CONTROL_UNIT_IF_VH