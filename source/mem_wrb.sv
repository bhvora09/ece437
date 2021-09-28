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
    
    mwif.jal_s_out<='b0;
    mwif.lui_out<='b0;
    mwif.MemtoReg_out <='b0;
    mwif.RegWr_out<= 'b0;
    mwif.halt_out <= 'b0;

    
    mwif.pcplusfour_out<='b0;
    mwif.instr_out <='b0;
    mwif.wdat_out <= 'b0;
    mwif.alu_portOut_out <= 'b0;
    
    mwif.imm_addr_out <='b0;
    mwif.wsel_out <='b0;
    mwif.shift_amt_out <= 'b0;
    mwif.functinmem_out <='b0;
    end

    else begin
    mwif.jal_s_out<=mwif.jal_s_in;
    mwif.lui_out<=mwif.lui_in;
    mwif.MemtoReg_out <= mwif.MemtoReg_in;
    mwif.RegWr_out<= mwif.RegWr_in;
    mwif.halt_out <= mwif.halt_in;

    mwif.pcplusfour_out<=mwif.pcplusfour_in;
    mwif.instr_out <= mwif.instr_in;
    mwif.wdat_out <= mwif.wdat_in;
    mwif.alu_portOut_out <= mwif.aluportOut_in;
    
    mwif.imm_addr_out <=mwif.imm_addr_in;
    mwif.wsel_out <=mwif.wsel_in;
    mwif.shift_amt_out <= mwif.shift_amt_in;
    mwif.functinmem_out <=mwif.functinmem_in;
    end
end
endmodule