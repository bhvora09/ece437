`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH

`include "cpu_types_pkg.vh"

interface hazard_unit_if;

    import cpu_types_pkg::*;

    logic PCWrite, deif_MemtoReg, deif_memWr, emif_bneS, emif_beqS, emif_jS, emif_jrS, emif_jalS;
    logic fdif_flush, fdif_stall, deif_stall, deif_flush, emif_flush, emif_stall, mwif_stall, mwif_flush; //flush and stall signals
    //word_t instr; //fdif.instr
    regbits_t  fdif_rs, fdif_rt, fdif_rd, deif_rt, deif_rd, deif_rs, emif_rt, emif_rs, emif_rd; 

    modport hu(
        input deif_MemtoReg, deif_memWr, emif_bneS, emif_beqS, emif_jS, emif_jrS, emif_jalS, fdif_rs, fdif_rt, fdif_rd, deif_rt, deif_rd, deif_rs, emif_rt, emif_rs, emif_rd,
        output PCWrite, fdif_flush, fdif_stall, deif_stall, deif_flush, emif_flush, emif_stall, mwif_stall, mwif_flush
    );

    modport tb(
        input PCWrite, fdif_flush, fdif_stall, deif_stall, deif_flush, emif_flush, emif_stall, mwif_stall, mwif_flush,
        output deif_MemtoReg, deif_memWr, emif_bneS, emif_beqS, emif_jS, emif_jrS, emif_jalS, fdif_rs, fdif_rt, fdif_rd, deif_rt, deif_rd, deif_rs, emif_rt, emif_rs, emif_rd
    );

endinterface

`endif