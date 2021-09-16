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
  //word_t instrO;
  aluop_t  ALUctr;
  funct_t funct;
  opcode_t opcode;
  regbits_t reg_rs,reg_rt, reg_rd;
  logic [1:0] PCsrc;
  logic     PCen,RegDst,RegWr,MemWr,MemtoReg,ExtOp,ALUSrc,jal_s,dREN,dWEN,iREN,halt; //dren using pcsrc
  logic [15:0] imm_addr;
  logic [25:0] j_addr;
  logic [4:0]  shift_amt;
  

  

  // pc ports
  modport cu (
    input   instr,
    output  PCen,PCsrc,RegDst,RegWr,ALUctr,MemWr,MemtoReg,ExtOp,ALUSrc,jal_s,dREN,
    output  dWEN,iREN,halt,opcode,reg_rs,reg_rt,reg_rd, imm_addr,j_addr,shift_amt,funct
  );
  // pc tb
  modport tb (
    input   dWEN,iREN,halt,opcode,reg_rs,reg_rt,reg_rd, imm_addr,j_addr,shift_amt,funct,
    input   PCen,PCsrc,RegDst,RegWr,ALUctr,MemWr,MemtoReg,ExtOp,ALUSrc,jal_s,dREN, 
    output  instr
  );
endinterface

`endif //CONTROL_UNIT_IF_VH