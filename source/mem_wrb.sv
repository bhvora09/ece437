//make clean - command helps  clean prev make commands
`include "cpu_types_pkg.vh"
`include "mem_wrb_if.vh"

//initialise module
module mem_wrb(
    input CLK,
    input nRST,
    mem_wrb_if.mw_if mwif
 );

//variables
import cpu_types_pkg::*;

always_ff@(posedge CLK or negedge nRST) begin
    if(!nRST)
    begin
    mwif.jALout<='b0;
    mwif.pcplusfour_out<='b0;
    mwif.alu_portOut_out <= 'b0;
    mwif.lUIout<= 'b0;
    mwif.imm_addr_for_lui_out<='b0;
    mwif.data_from_mem_out <= 'b0;
    mwif.memtoReg_out <='b0;
    mwif.regwr_out<= 'b0;
    mwif.dest_reg_out <= 'b0;
    end
    else begin
    mwif.jALout<=mwif.jALin;
    mwif.pcplusfour_out<=mwif.pcplusfour_in;
    mwif.alu_portOut_out <= mwif.aluportOut_in;
    mwif.lUIout<= mwif.lUIin;
    mwif.imm_addr_for_lui_out<=mwif.imm_addr_for_lui_in;
    mwif.data_from_mem_out <= data_from_mem_out;
    mwif.memtoReg_out <=mwif.memtoReg_in;
    mwif.regwr_out<= mwif.regwr_in;
    mwif.dest_reg_out <= mwif.dest_reg_in;


    end
end