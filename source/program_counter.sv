`include "cpu_types_pkg.vh"
`include "program_counter_if.vh"
//`include "system_if.vh"

module program_counter(
    input logic CLK,
    input logic nRST,
    program_counter_if.pc_mod pcif
    );

parameter PC_INIT=0;
import cpu_types_pkg::*;

always_ff @(posedge CLK or negedge nRST)
begin
    if (!nRST)
        pcif.pc<=PC_INIT;
    else if(pcif.PCen)
        pcif.pc<=pcif.pc_next;
end
endmodule