/*
  Eric Villasenor
  evillase@gmail.com

  this block holds the i and d cache
*/


// interfaces
`include "datapath_cache_if.vh"
`include "caches_if.vh"

// cpu types
`include "cpu_types_pkg.vh"

module caches (
  input logic CLK, nRST,
  datapath_cache_if.cache dcif,
<<<<<<< HEAD
<<<<<<< HEAD:source/caches.sv
  caches_if cif
);
=======
=======
>>>>>>> 1ac40db70f9e0525d126bc9ae8633e0e1aa71449:pipeline/source/caches.sv
  caches_if.caches cif
);
  // import types
  import cpu_types_pkg::word_t;

  parameter CPUID = 0;
<<<<<<< HEAD:source/caches.sv
>>>>>>> singlecycle
=======
=======
  caches_if cif
);
>>>>>>> 06d6d2ca6704ebf35a725d6ad479e4aa9723e632
>>>>>>> 1ac40db70f9e0525d126bc9ae8633e0e1aa71449:pipeline/source/caches.sv

  word_t instr;
  word_t daddr;

  // icache
  //icache  ICACHE(dcif, cif);
  // dcache
  //dcache  DCACHE(dcif, cif);

  // single cycle instr saver (for memory ops)
  always_ff @(posedge CLK or negedge nRST)
  begin
    if (!nRST)
    begin
      instr <= '0;
      daddr <= '0;
    end
    else
    if (dcif.ihit)
    begin
      instr <= cif.iload;
      daddr <= dcif.dmemaddr;
    end
  end
  // dcache invalidate before halt
  assign dcif.flushed = dcif.halt;

<<<<<<< HEAD
<<<<<<< HEAD:source/caches.sv
  //singlecycle
=======
  //single cycle
>>>>>>> 1ac40db70f9e0525d126bc9ae8633e0e1aa71449:pipeline/source/caches.sv
  assign dcif.ihit = (dcif.imemREN) ? ~cif.iwait : 0;
  assign dcif.dhit = (dcif.dmemREN|dcif.dmemWEN) ? ~cif.dwait : 0;
  assign dcif.imemload = (cif.iwait) ? instr : cif.iload;
=======
  //singlecycle
  assign dcif.ihit = (dcif.imemREN) ? ~cif.iwait : 0;
  assign dcif.dhit = (dcif.dmemREN|dcif.dmemWEN) ? ~cif.dwait : 0;
<<<<<<< HEAD:source/caches.sv
  assign dcif.imemload = (cif.iwait) ? instr : cif.iload;
>>>>>>> singlecycle
=======
  assign dcif.imemload = cif.iload;
>>>>>>> 06d6d2ca6704ebf35a725d6ad479e4aa9723e632
>>>>>>> 1ac40db70f9e0525d126bc9ae8633e0e1aa71449:pipeline/source/caches.sv
  assign dcif.dmemload = cif.dload;


  assign cif.iREN = dcif.imemREN;
  assign cif.dREN = dcif.dmemREN;
  assign cif.dWEN = dcif.dmemWEN;
  assign cif.dstore = dcif.dmemstore;
  assign cif.iaddr = dcif.imemaddr;
<<<<<<< HEAD
<<<<<<< HEAD:source/caches.sv
  assign cif.daddr = dcif.dmemaddr;
=======
  assign cif.daddr = daddr;
>>>>>>> singlecycle
=======
  assign cif.daddr = daddr;
=======
  assign cif.daddr = dcif.dmemaddr;
>>>>>>> 06d6d2ca6704ebf35a725d6ad479e4aa9723e632
>>>>>>> 1ac40db70f9e0525d126bc9ae8633e0e1aa71449:pipeline/source/caches.sv

endmodule
