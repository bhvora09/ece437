`ifndef IDECODE_IEXEC_IF_VH
`define IDECODE_IEXEC_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface idecode_iexec_if;
    // import types
    import cpu_types_pkg::*;

    //in
    word_t instr_in,Ext_addr_in, pcplusfour_in,rdat1_in, rdat2_in;
    logic dWEN_in, dREN_in, bne_s_in, beq_s_in, jal_s_in, jr_s_in, jump_s_in,lui_in,stall_for_data;
    logic RegDst_in, ALUSrc_in,  RegWr_in, MemWr_in, MemtoReg_in, halt_in; 
    logic [15:0] imm_addr_in;
    logic [4:0] reg_rt_in,reg_rd_in,shift_amt_in;
    logic [25:0] j_addr_in;
    logic [5:0] funct_in;
    logic [3:0] ALUctr_in;
    
    //logic ihit_in, 
    logic dhit_in;
    

    //out
    word_t instr_out,Ext_addr_out,pcplusfour_out,rdat1_out, rdat2_out;
    logic dWEN_out, dREN_out, bne_s_out, beq_s_out, jal_s_out, jr_s_out, jump_s_out,lui_out;
    logic RegDst_out, ALUSrc_out, RegWr_out, MemWr_out, MemtoReg_out, halt_out;
    logic [15:0] imm_addr_out;
    logic [4:0] reg_rt_out,reg_rd_out,shift_amt_out;
    logic [25:0] j_addr_out;
    logic [5:0] funct_out;
    logic [3:0] ALUctr_out;
    //logic ihit_out, 
    logic dhit_out;

    modport de_if (
        input instr_in,Ext_addr_in, pcplusfour_in,rdat1_in, rdat2_in,
                dWEN_in, dREN_in, bne_s_in, beq_s_in, jal_s_in, jr_s_in, jump_s_in,lui_in,
                RegDst_in, ALUSrc_in, ALUctr_in, RegWr_in, MemWr_in, MemtoReg_in, halt_in,
                imm_addr_in,
                reg_rt_in,reg_rd_in,shift_amt_in,
                j_addr_in,
                funct_in,
                //ihit_in,
                dhit_in,
                stall_for_data,
        output instr_out,Ext_addr_out,pcplusfour_out,rdat1_out, rdat2_out,
                dWEN_out, dREN_out, bne_s_out, beq_s_out, jal_s_out, jr_s_out, jump_s_out,lui_out,
                RegDst_out, ALUSrc_out, ALUctr_out, RegWr_out, MemWr_out, MemtoReg_out, halt_out,
                imm_addr_out,
                reg_rt_out,reg_rd_out,shift_amt_out,
                j_addr_out,
                funct_out,
               // ihit_out, 
                dhit_out
        );

    modport tb (
       input instr_out,Ext_addr_out,pcplusfour_out,rdat1_out, rdat2_out,
                dWEN_out, dREN_out, bne_s_out, beq_s_out, jal_s_out, jr_s_out, jump_s_out,lui_out,
                RegDst_out, ALUSrc_out, ALUctr_out, RegWr_out, MemWr_out, MemtoReg_out, halt_out,
                imm_addr_out,
                reg_rt_out,reg_rd_out,shift_amt_out,
                j_addr_out,
                funct_out,
                //ihit_out,
                dhit_out,
        output instr_in,Ext_addr_in, pcplusfour_in,rdat1_in, rdat2_in,
                dWEN_in, dREN_in, bne_s_in, beq_s_in, jal_s_in, jr_s_in, jump_s_in,lui_in,
                RegDst_in, ALUSrc_in, ALUctr_in, RegWr_in, MemWr_in, MemtoReg_in, halt_in,
                imm_addr_in,
                reg_rt_in,reg_rd_in,shift_amt_in,
                j_addr_in,
                funct_in,
                //ihit_in,
                dhit_in,
                stall_for_data
    );
endinterface

`endif //IDECODE_IEXEC_IF_VH