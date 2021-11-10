`include "cpu_types_pkg.vh"
`include "program_counter_if.vh"

module program_counter(
    input logic CLK,
    input logic nRST,
    program_counter_if.pc_mod pcif
    );

import cpu_types_pkg::*;

always_ff @(posedge CLK or negedge nRST)
begin
    if (!nRST)
        pcif.pc<='b0;
    //added stall input
    else if(pcif.PCen & ~pcif.stall)
        pcif.pc<=pcif.pc_next;
end
endmodule