`ifndef IDECODE_IEXEC_IF_VH
`define IDECODE_IEXEC_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface idecode_iexec_if;
    // import types
    import cpu_types_pkg::*;

    //in
    logic dWEN_in, dREN_in;
    word_t rdat1, rdat2;
    word_t instr_in;
    logic [4:0] rs, rt, rd;
    logic [15:0] imm_addr;
    logic lui_s_in, jal_s_in, jr_s_in, j_s_in;
    logic RegDst_in, ALUsrc_in, ALUctr_in, RegWr_in, MemWr_in, MemtoReg_in;
    logic stall;
    logic ihit_in, dhit_in;
    word_t jal_addr_in, jr_addr_in, j_addr_in, branch_addr_in;
    word_t Ext_addr_in;
    logic bne_s_in, beq_s_in;
    opcode_t aluopindecode_in;
    logic halt_in;
    logic [4:0] shift_amt_in;
    funct_t funct_in;

    //out
    logic dWEN_out, dREN_out;
    logic jal_s_out, jr_s_out, j_s_out;
    logic RegDst_out, ALUsrc_out, ALUctr_out, RegWr_out, MemWr_out, MemtoReg_out, halt_out;
    word_t instr_out;
    word_t pcplusfour_out;
    word_t rdat1_out, rdat2_out;
    logic [4:0] rs_out, rt_out, rd_out;
    logic [15:0] imm_addr_out;
    logic lui_s_out;
    logic ihit_out, dhit_out;
    word_t jal_addr_out, jr_addr_out, j_addr_out, branch_addr_out;
    word_t Ext_addr_out;
    logic bne_s_out, beq_s_out;
    opcode_t aluopindecode_out;
    logic [4:0] shift_amt_out;
    funct_t functindecode_out;


    
    modport idie (
        input dWEN_in, dREN_in, rdat1, rdat2, pcplusfour_in, rs, rt, rd, imm_addr, lui_s_in, jal_s_in, j_s_in, jr_s_in, RegDst_in, ALUsrc_in, ALUctr_in, stall, ihit_in, dhit_in, instr_in, jal_addr_in, jr_addr_in, j_addr_in, branch_addr_in, Ext_addr_in, bne_s_in, beq_s_in, aluopindecode_in, RegWr_in, MemWr_in, MemtoReg_in, halt_in, shift_amt_in, funct_in,
        output dWEN_out, dREN_out, jal_s_out, RegDst_out, ALUsrc_out, ALUctr_out, pcplusfour_out, rdat1_out, rdat2_out, rs_out, rt_out, rd_out, imm_addr_out, lui_s_out, ihit_out, dhit_out, instr_out, jal_addr_out, jr_addr_out, j_addr_out, branch_addr_out, j_s_out, jr_s_out, Ext_addr_out, bne_s_out, beq_s_out, aluopindecode_out, RegWr_out, MemWr_out, MemtoReg_out, halt_out, shift_amt_out, functindecode_out
    );

    modport tb (
        input dWEN_out, dREN_out, jal_s_out, RegDst_out, ALUsrc_out, ALUctr_out, pcplusfour_out, rdat1_out, rdat2_out, rs_out, rt_out, rd_out, imm_addr_out, lui_s_out, ihit_out, dhit_out, instr_out, jal_addr_out, jr_addr_out, j_addr_out, branch_addr_out, j_s_out, jr_s_out, Ext_addr_out, bne_s_out, beq_s_out, aluopindecode_out, RegWr_out, MemWr_out, MemtoReg_out, halt_out, shift_amt_out, functindecode_out
        output dWEN_in, dREN_in, rdat1, rdat2, pcplusfour_in, rs, rt, rd, imm_addr, lui_s_in, jal_s_in, j_s_in, jr_s_in, RegDst_in, ALUsrc_in, ALUctr_in, stall, ihit_in, ihit_in, instr_in, jal_addr_in, jr_addr_in, j_addr_in, branch_addr_in, Ext_addr_in, bne_s_in, beq_s_in, aluopindecode_in, RegWr_in, MemWr_in, MemtoReg_in, halt_in, shift_amt_in, funct_in
    );
endinterface

`endif //IDECODE_IEXEC_IF_VH