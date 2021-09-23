/*
  Eric Villasenor
  evillase@gmail.com

  ALU interface
*/
`ifndef ALU_IF_VH
`define ALU_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_if;
  // import types
  import cpu_types_pkg::*;

  //logic     WEN;
    logic flagNeg,flagZero,flagOvf;
  //regbits_t wsel, rsel1, rsel2;
    logic[3:0] op;
    //aluop_t op;
  //word_t    wdat, rdat1, rdat2;
    word_t portA,portB,portOut;
    
  // alu  ports
  modport alu_ports (
    //input   WEN, wsel, rsel1, rsel2, wdat,
    input portA,portB,op,
    //output  rdat1, rdat2
    output flagNeg, flagZero, flagOvf, portOut
  );
  // register file tb
  modport tb (
    //input   rdat1, rdat2,
    input flagNeg, flagZero, flagOvf, portOut,
    //output  WEN, wsel, rsel1, rsel2, wdat
    output portA,portB,op
  );
endinterface

`endif //ALU_IF_VH
