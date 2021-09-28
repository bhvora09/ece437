`ifndef MEM_WRB_IF_VH
`define MEM_WRB_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface  mem_wrb_if;
  // import types
  import cpu_types_pkg::*;

    //from exec mem stage
    logic jal_s_in,lui_in,MemtoReg_in,RegWr_in,halt_in;
    logic jal_s_out,lui_out,MemtoReg_out,RegWr_out,halt_out;

    word_t pcplusfour_in, alu_portOut_in,instr_in,wdat_in;
    word_t pcplusfour_out,instr_out,wdat_out,alu_portOut_out;

    logic [15:0] imm_addr_in;
    logic [15:0] imm_addr_out;
    logic [4:0] wsel_in,shift_amt_in;
    logic [4:0] wsel_out,shift_amt_out;
    logic  [5:0] funct_in;
    logic [5:0] funct_out;
    //removed dren,dwen, bne,beq,flagzero,rdat2_from_reg, branch_addr
    //newly added
    //word_t data_from_mem_in,data_from_mem_out;
  
    
  
  modport mw_if (
    input jal_s_in,lui_in,MemtoReg_in,RegWr_in,halt_in,
          pcplusfour_in,instr_in,wdat_in,alu_portOut_in,
          imm_addr_in,
          wsel_in,shift_amt_in,
          funct_in,
    output jal_s_out,lui_out,MemtoReg_out,RegWr_out,halt_out,
           pcplusfour_out,instr_out,wdat_out,alu_portOut_out,
          imm_addr_out,
          wsel_out,shift_amt_out,
          funct_out
  );
  
  modport tb (
    input jal_s_out,lui_out,MemtoReg_out,RegWr_out,halt_out,
           pcplusfour_out,instr_out,wdat_out,alu_portOut_out,
          imm_addr_out,
          wsel_out,shift_amt_out,
          funct_out,
     output jal_s_in,lui_in,MemtoReg_in,RegWr_in,halt_in,
          pcplusfour_in,instr_in,wdat_in,alu_portOut_in,
          imm_addr_in,
          wsel_in,shift_amt_in,
          funct_in
  );
endinterface

`endif //ALU_IF_VH