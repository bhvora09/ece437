`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH

`include "cpu_types_pkg.vh"

interface hazard_unit_if;

    import cpu_types_pkg::*;

    logic PCWrite, deif_RegWr, deif_MemtoReg, decode_memWr, emif_MemtoReg, emif_RegWr,emif_bneS, emif_beqS, emif_jS, emif_jrS, emif_jalS;
    logic fdif_flush, fdif_stall, deif_stall, deif_flush, emif_flush, emif_stall, mwif_stall, mwif_flush; //flush and stall signals
    //word_t instr; //fdif.instr
    regbits_t  fdif_rs, fdif_rt, fdif_rd, deif_rt, deif_rd, deif_rs, emif_rt, emif_rs, emif_rd; 
    opcode_t deif_opcode,emif_opcode;

    modport hu(
        input deif_RegWr, deif_MemtoReg, decode_memWr,emif_MemtoReg, emif_RegWr, emif_bneS, emif_beqS, emif_jS, emif_jrS, emif_jalS, fdif_rs, fdif_rt, fdif_rd, deif_rt, deif_rd, deif_rs, emif_rt, emif_rs, emif_rd,deif_opcode,emif_opcode,
        output PCWrite, fdif_flush, fdif_stall, deif_stall, deif_flush, emif_flush, emif_stall, mwif_stall, mwif_flush
    );

    modport tb(
        input PCWrite, fdif_flush, fdif_stall, deif_stall, deif_flush, emif_flush, emif_stall, mwif_stall, mwif_flush,
        output deif_RegWr, deif_MemtoReg, decode_memWr,emif_MemtoReg, emif_RegWr, emif_bneS, emif_beqS, emif_jS, emif_jrS, emif_jalS, fdif_rs, fdif_rt, fdif_rd, deif_rt, deif_rd, deif_rs, emif_rt, emif_rs, emif_rd,deif_opcode,emif_opcode
    );

endinterface

`endif