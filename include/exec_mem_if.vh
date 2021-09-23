`ifndef EXEC_MEM_IF_VH
`define EXEC_MEM_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface  exec_mem_if;
  // import types
  import cpu_types_pkg::*;

  
    logic dRENin,dWENin,bNEin,bEQin,jALin,flagZero_in,lUIin,memtoReg_in,regwr_in;
    logic dRENout,dWENout,bNEin,bEQout,jALout,flagZero_out,lUIout,memtoReg_out,regwr_out;
    word_t pcplusfour_in,rdat2_from_reg_in,branch_addr_in, alu_portOut_in;
    word_t pcplusfour_out,rdat2_from_reg_out,branch_addr_out, alu_portOut_out;
    logic [15:0] imm_addr_for_lui_in,imm_addr_for_lui_out;
    logic [4:0] dest_reg_in, dest_reg_out;
  
    
  // alu  ports
  modport em_if (
    input dRENin,dWENin,bNEin,bEQin,jALin,flagZero_in,lUIin,memtoReg_in,regwr_in,
          pcplusfour_in,rdat2_from_reg_in,branch_addr_in, alu_portOut_in,dest_reg_in,
          imm_addr_for_lui_in,
    output dRENout,dWENout,bNEin,bEQout,jALout,flagZero_out,lUIout,memtoReg_out,regwr_out
            pcplusfour_out,rdat2_from_reg_out,branch_addr_out, alu_portOut_out,dest_reg_out,
            imm_addr_for_lui_out
  );
  // register file tb
  modport tb (
    input dRENout,dWENout,bNEin,bEQout,jALout,flagZero_out,lUIout,memtoReg_out,regwr_out,
            pcplusfour_out,rdat2_from_reg_out,branch_addr_out, alu_portOut_out,dest_reg_out,
            imm_addr_for_lui_out,
    output dRENin,dWENin,bNEin,bEQin,jALin,flagZero_in,lUIin,memtoReg_in,regwr_in,
          pcplusfour_in,rdat2_from_reg_in,branch_addr_in, alu_portOut_in,dest_reg_in,
          imm_addr_for_lui_in
  );
endinterface

`endif //ALU_IF_VH