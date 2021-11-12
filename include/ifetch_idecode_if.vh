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
    logic ihit, dhit,stall;

    //out
    word_t instr_out;
    word_t pc_out, pcplusfour_out;
    //logic ihit_out, dhit_out;
    
    modport fd_if (
        input instr_in,ihit, dhit,
            pc_in, pcplusfour_in, stall,
            //ihit_in, dhit_in,
        output instr_out, 
            pc_out, pcplusfour_out
            //ihit_out, dhit_out
    );

    modport tb (
        input instr_out, 
            pc_out, pcplusfour_out,
            //ihit_out, dhit_out,
        output instr_in,ihit, dhit,stall,
            pc_in, pcplusfour_in
            //ihit_in, dhit_in
    );
endinterface

`endif //IFETCH_IDECODE_IF_VH
