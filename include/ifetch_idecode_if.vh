`ifndef IFETCH_IDECODE_IF_VH
`define IFETCH_IDECODE_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface ifetch_idecode_if;
    // import types
    import cpu_types_pkg::*;

    //in
    word_t instr_in;
    word_t pc_in, pcplusfour_in;
    logic lui_s_in, jal_s_in, jr_s_in, j_s_in;
    logic stall;
    logic ihit_in, dhit_in;
    word_t jal_addr_in, jr_addr_in, j_addr_in, branch_addr_in;

    //out
    word_t instr_out;
    word_t pc_plusfour_out;
    logic [25:0] jump_instr;
    logic [4:0] rs, rt, rd;
    logic [15:0] imm_addr;
    logic lui_s_out, jal_s_out, jr_s_out, j_s_out;
    logic ihit_out, dhit_out;
    word_t jal_addr_out, jr_addr_out, j_addr_out, branch_addr_out;

    
    modport idie (
        input instr_in, pc_in, pcplusfour_in, lui_s_in, stall, ihit_in, dhit_in, jal_addr_in, jr_addr_in, j_addr_in, branch_addr_in, jal_s_in, j_s_in, jr_s_in,
        output instr_out, pcplusfour_out, jump_instr, rs, rt, rd, imm_addr, lui_s_out, ihit_out, dhit_out, jal_addr_out, jr_addr_out, j_addr_out, branch_addr_out, jal_s_out, jr_s_out, j_s_out
    );

    modport tb (
        input instr_out, pcplusfour_out, jump_instr, rs, rt, rd, imm_addr, lui_s_out, ihit_out, dhit_out, jal_addr_out, jr_addr_out, j_addr_out, branch_addr_out, jal_s_out, jr_s_out, j_s_out,
        output instr_in, pc_in, pcplusfour_in, lui_s_in, stall, ihit_in, dhit_in, jal_addr_in, jr_addr_in, j_addr_in, branch_addr_in, jal_s_in, j_s_in, jr_s_in
    );
endinterface

`endif //IFETCH_IDECODE_IF_VH
