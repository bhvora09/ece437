`ifndef MEMORY_REQUEST_UNIT_IF_VH
`define MEMORY_REQUEST_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface memory_request_unit_if;
  // import types
  import cpu_types_pkg::*;
  
  //logic CLK, nRST;
  logic ihit,dhit,dren,dwen,iren,dmemREN,dmemWEN,imemREN;

  // memory request unit if
  modport mru (
    input   ihit,dhit,dren,dwen,iren,
    output  dmemREN,dmemWEN,imemREN
  );
  // memory request unit tb
  modport tb (
    input   dmemREN,dmemWEN,imemREN,
    output  ihit,dhit,dren,dwen,iren
  );
endinterface

`endif //MEMORY_REQUEST_UNIT_IF_VH