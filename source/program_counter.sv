`include "cpu_types_pkg.vh"
`include "program_counter_if.vh"

module program_counter(
    input logic CLK,
    input logic nRST,
    program_counter_if.pc_mod pcif
    );

import cpu_types_pkg::*;

always_ff @(posedge CLK)
begin
if (nRST==1) begin
    if(pcif.PCen)
        pcif.pc<=pcif.pc_next;
end
else
    pcif.pc<='b0;
end
endmodule