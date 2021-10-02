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

// assign mwif.jal_s_out = (~mwif.stall_for_data) && mwif.jal_s_out;
// assign mwif.lui_out =(~mwif.stall_for_data) && mwif.lui_out;
// assign mwif.MemtoReg_out =(~mwif.stall_for_data) && mwif.MemtoReg_out;
// assign mwif.RegWr_out = (~mwif.stall_for_data) && mwif.RegWr_out;
// assign mwif.halt_out = (~mwif.stall_for_data) && mwif.halt_out;

    
// assign mwif.pcplusfour_out =(~mwif.stall_for_data) && mwif.pcplusfour_out;
// assign mwif.instr_out = (~mwif.stall_for_data) && mwif.instr_out;
// assign mwif.wdat_out =  (~mwif.stall_for_data) && mwif.wdat_out;
// assign mwif.alu_portOut_out =(~mwif.stall_for_data) && mwif.alu_portOut_out;
    
// assign mwif.imm_addr_out =(~mwif.stall_for_data) && mwif.imm_addr_out;
// assign mwif.wsel_out =(~mwif.stall_for_data) && mwif.wsel_out;
// assign mwif.shift_amt_out = (~mwif.stall_for_data) && mwif.shift_amt_out;
// assign mwif.funct_out =(~mwif.stall_for_data) && mwif.funct_out;

always_ff@(posedge CLK or negedge nRST) begin
    if(!nRST)
    begin
    
    mwif.jal_s_out<='b0;
    mwif.lui_out<='b0;
    mwif.MemtoReg_out <='b0;
    mwif.RegWr_out<= 'b0;
    mwif.halt_out <= 'b0;

    
    mwif.pcplusfour_out<='b0;
    mwif.pc_out<='b0;
    mwif.instr_out <='b0;
    mwif.wdat_out <= 'b0;
    mwif.alu_portOut_out <= 'b0;
    mwif.rdat2_out <= 'b0;
    
    mwif.imm_addr_out <='b0;
    mwif.wsel_out <='b0;
    mwif.shift_amt_out <= 'b0;
    mwif.reg_rs_out <='b0;
    mwif.reg_rt_out<='b0;

    mwif.opcode_out <= opcode_t'('b0);
    mwif.funct_out <=funct_t'('b0);
    end
    
    // else if(mwif.stall_for_data)
    // begin
    
    //end
    else begin
    mwif.jal_s_out<=mwif.jal_s_in;
    mwif.lui_out<=mwif.lui_in;
    mwif.MemtoReg_out <= mwif.MemtoReg_in;
    mwif.RegWr_out<= mwif.RegWr_in;
    mwif.halt_out <= mwif.halt_in;

    mwif.pcplusfour_out<=mwif.pcplusfour_in;
    mwif.pc_out<=mwif.pc_in;
    mwif.instr_out <= mwif.instr_in;
    mwif.wdat_out <= mwif.wdat_in;
    mwif.alu_portOut_out <= mwif.alu_portOut_in;
    mwif.rdat2_out <= mwif.rdat2_in;
    
    mwif.imm_addr_out <=mwif.imm_addr_in;
    mwif.wsel_out <=mwif.wsel_in;
    mwif.shift_amt_out <= mwif.shift_amt_in;
    mwif.reg_rs_out <=mwif.reg_rs_in;
    mwif.reg_rt_out<=mwif.reg_rt_in;

    mwif.opcode_out <= mwif.opcode_in;
    mwif.funct_out <=mwif.funct_in;
    end
end
endmodule