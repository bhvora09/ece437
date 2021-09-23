//make clean - command helps  clean prev make commands
`include "cpu_types_pkg.vh"
`include "exec_mem_if.vh"

//initialise module
module exec_mem(
    input CLK,
    input nRST,
    exec_mem_if.em_if emif
 );

//variables
import cpu_types_pkg::*;

always_ff@(posedge CLK or negedge nRST) begin
    if(!nRST)
    begin
    emif.dRENout <= 'b0;
    emif.dWENout <= 'b0;
    emif.bNEout <= 'b0;
    emif.bEQout <= 'b0;
    emif.jALout<='b0;
    emif.pcplusfour_out<='b0;
    emif.flagZero_out<= 'b0;
    emif.branch_addr_out<='b0;
    emif.alu_portOut_out <= 'b0;
    emif.rdat2_from_reg_out <= 'b0;
    emif.lUIout<= 'b0;
    emif.imm_addr_for_lui_out<='b0;
    end
    else begin
    emif.dRENout <= emif.dRENin;
    emif.dWENout <= emif.dWENin;
    emif.bNEout <= emif.bNEin;
    emif.bEQout <= emif.bEQin;
    emif.jALout<=emif.jALin;
    emif.pcplusfour_out<=emif.pcplusfour_in;
    emif.flagZero_out<= emif.flagZero_in;
    emif.branch_addr_out<=emif.branch_addr_in;
    emif.alu_portOut_out <= emif.aluportOut_in;
    emif.rdat2_from_reg_out <= emif.rdat2_from_reg_in;
    emif.lUIout<= emif.lUIin;
    emif.imm_addr_for_lui_out<=emif.imm_addr_for_lui_in;
    end
end