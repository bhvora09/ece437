`ifndef EXEC_MEM_IF_VH
`define EXEC_MEM_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface  exec_mem_if;
  // import types
  import cpu_types_pkg::*;

  
    logic dREN_in,dWEN_in,bne_s_in,beq_s_in,jal_s_in,flagZero_in,lui_in,MemtoReg_in,RegWr_in,jump_s_in,jr_s_in,ihit,dhit,MemWr_in,halt_in;
    logic dREN_out,dWEN_out,bne_s_out,beq_s_out,jal_s_out,flagZero_out,lui_out,MemtoReg_out,RegWr_out,jump_s_out,jr_s_out,MemWr_out,halt_out;
    
    word_t pcplusfour_in,rdat2_in, alu_portOut_in,instr_in,Ext_addr_in,rdat1_in;
    word_t pcplusfour_out,rdat2_out, alu_portOut_out,instr_out,Ext_addr_out,rdat1_out;
    
    logic [15:0] imm_addr_in;
    logic [15:0] imm_addr_out;
    logic [25:0] j_addr_in;
    logic [25:0] j_addr_out;
    logic [4:0] wsel_in, shift_amt_in ;
    logic [4:0] wsel_out,shift_amt_out;
    logic [5:0] funct_in;
    logic [5:0] funct_out;
    
  // alu  ports
  modport em_if (
    input dREN_in,dWEN_in,bne_s_in,beq_s_in,jal_s_in,flagZero_in,lui_in,MemtoReg_in,RegWr_in,jump_s_in,jr_s_in,ihit, dhit,MemWr_in,halt_in,
          pcplusfour_in,rdat2_in, alu_portOut_in,instr_in,Ext_addr_in,rdat1_in,
          imm_addr_in,
          j_addr_in,
          wsel_in, shift_amt_in,
          funct_in,
    output dREN_out,dWEN_out,bne_s_out,beq_s_out,jal_s_out,flagZero_out,lui_out,MemtoReg_out,RegWr_out,jump_s_out,jr_s_out,MemWr_out,halt_out,
          pcplusfour_out,rdat2_out, alu_portOut_out,instr_out,Ext_addr_out,rdat1_out,
          imm_addr_out,
          j_addr_out,
          wsel_out,shift_amt_out,
          funct_out
  );
  // register file tb
  modport tb (
    input dREN_out,dWEN_out,bne_s_out,beq_s_out,jal_s_out,flagZero_out,lui_out,MemtoReg_out,RegWr_out,jump_s_out,jr_s_out,MemWr_out,halt_out,
          pcplusfour_out,rdat2_out, alu_portOut_out,instr_out,Ext_addr_out,rdat1_out,
          imm_addr_out,
          j_addr_out,
          wsel_out,shift_amt_out,
          funct_out,
    output dREN_in,dWEN_in,bne_s_in,beq_s_in,jal_s_in,flagZero_in,lui_in,MemtoReg_in,RegWr_in,jump_s_in,jr_s_in,ihit, dhit,MemWr_in,halt_in,
          pcplusfour_in, alu_portOut_in,instr_in,Ext_addr_in,rdat1_in,
          imm_addr_in,
          j_addr_in,
          wsel_in, shift_amt_in,
          funct_in,stall_for_data
  );
endinterface

`endif //ALU_IF_VH