`ifndef FORWARDING_UNIT_IF_VH
`define FORWARDING_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface forwarding_unit_if;
    // import types
    import cpu_types_pkg::*;

    //in
    logic emif_RegWr, mwif_RegWr;
    regbits_t emif_rd, mwif_rd, deif_rs, deif_rt;
    word_t emif_portout, mwif_portout;


    //out
    logic Asel, Bsel;
    word_t DataB, DataA;
    
    modport fu (
        input emif_RegWr, mwif_RegWr, emif_rd, mwif_rd, deif_rs, deif_rt, emif_portout, mwif_portout,
        output Asel, Bsel, DataB, DataA
    );

    modport tb (
        input Asel, Bsel, DataB, DataA,
        output emif_RegWr, mwif_RegWr, emif_rd, mwif_rd, deif_rs, deif_rt, emif_portout, mwif_portout
    );
endinterface

`endif //FORWARDING_UNIT_IF_VH