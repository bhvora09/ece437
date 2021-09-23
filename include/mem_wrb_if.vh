`ifndef MEM_WRB_IF_VH
`define MEM_WRB_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface  mem_wrb_if;
  // import types
  import cpu_types_pkg::*;

    //from exec mem stage
    logic jALin,lUIin,memtoReg_in,regwr_in;
    logic jALout,lUIout,memtoReg_out,regwr_in;
    word_t pcplusfour_in, alu_portOut_in;
    word_t pcplusfour_out, alu_portOut_out,dest_reg_out,
    logic [15:0] imm_addr_for_lui_in;
    logic [15:0] imm_addr_for_lui_out;
    logic [4:0] dest_reg_in, dest_reg_out;
    //removed dren,dwen, bne,beq,flagzero,rdat2_from_reg, branch_addr
    //newly added
    word_t data_from_mem_in,data_from_mem_out;
  
    
  // alu  ports
  modport mw_if (
    input jALin,lUIin,memtoReg_in,regwr_in,
          pcplusfour_in, alu_portOut_in,dest_reg_in,data_from_mem_in,
          imm_addr_for_lui_in,
    output jALout,lUIout,memtoReg_out,regwr_in,
            pcplusfour_out, alu_portOut_out,dest_reg_out,data_from_mem_out,
            imm_addr_for_lui_out
  );
  // register file tb
  modport tb (
    input jALout,lUIout,memtoReg_out,regwr_in,
            pcplusfour_out, alu_portOut_out,dest_reg_out,data_from_mem_out,
            imm_addr_for_lui_out,
    input jALin,lUIin,memtoReg_in,regwr_in,
          pcplusfour_in, alu_portOut_in,dest_reg_in,data_from_mem_in,
          imm_addr_for_lui_in
  );
endinterface

`endif //ALU_IF_VH