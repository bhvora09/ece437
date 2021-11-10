`ifndef PROGRAM_COUNTER_IF_VH
`define PROGRAM_COUNTER_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface program_counter_if;
  // import types
  import cpu_types_pkg::*;
  //change 8 - added stall 
  //logic     CLK, nRST;
  logic PCen,stall;
  //regbits_t wsel, rsel1, rsel2;
  word_t    pc, pc_next;


  // pc ports
  modport pc_mod (
    input   PCen,pc_next,stall,
    output  pc
  );
  // pc tb
  modport tb (
    input   pc,
    output  PCen,pc_next,stall
  );
endinterface

`endif //PROGRAM_COUNTER_IF_VH
