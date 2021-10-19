`include "caches_if.vh"
`include "datapath_cache_if.vh"
`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"

module dcache(
    input logic CLK,nRST,
    datapth_cache_if.dcache dcif,
    caches_if.dcache cdif,
);
  // type import
import cpu_types_pkg::*;

//structs
//dcache_frame - [valid,dirty,tag, data[1:0]]
dcache_frame [8:0] table1;
dcache_frame [8:0] table2;

//dcache_t -  [tag-26, index-3, blkoff-1, bytoff-2]
dcachef_t iaddr;
