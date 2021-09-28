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
  //logic [1:0] PCsrc;
  logic     RegDst,RegWr,MemWr,MemtoReg,ExtOp,ALUSrc,jal_s,dREN,dWEN,halt,beq_s,bne_s,jump_s,jr_s,lui; //dren using pcsrc
  logic [15:0] imm_addr;
  logic [25:0] j_addr;
  logic [4:0]  shift_amt;
  

  

  // pc ports
  modport cu (
    input   instr,
    output  RegDst,RegWr,ALUctr,MemWr,MemtoReg,ExtOp,ALUSrc,jal_s,dREN,beq_s,bne_s,jump_s,jr_s,lui,
    output  dWEN,halt,opcode,reg_rs,reg_rt,reg_rd, imm_addr,j_addr,shift_amt,funct
  );
  // pc tb
  modport tb (
    input   dWEN,halt,opcode,reg_rs,reg_rt,reg_rd, imm_addr,j_addr,shift_amt,funct,
    input   RegDst,RegWr,ALUctr,MemWr,MemtoReg,ExtOp,ALUSrc,jal_s,dREN, beq_s,bne_s,jump_s,jr_s,lui,
    output  instr
  );
endinterface

`endif //CONTROL_UNIT_IF_VH