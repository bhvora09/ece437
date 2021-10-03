`include "cpu_types_pkg.vh"
`include "program_counter_if.vh"

module program_counter(
    input logic CLK, nRST,
    program_counter_if.pc_mod pcif
    );

import cpu_types_pkg::*;

always_ff @(posedge CLK or negedge nRST)
begin
if (!nRST) begin
   pcif.pc<='b0;
end
else begin
    if(pcif.PCen)
        pcif.pc<=pcif.pc_next;
end
end
endmodule