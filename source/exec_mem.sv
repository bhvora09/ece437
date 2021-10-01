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
    emif.dREN_out <= 'b0;
    emif.dWEN_out <= 'b0;
    emif.bne_s_out <= 'b0;
    emif.beq_s_out <= 'b0;
    emif.jal_s_out<='b0;
    emif.flagZero_out<='b0;
    emif.lui_out<='b0;
    emif.MemtoReg_out<='b0;
    emif.RegWr_out <='b0;
    emif.jump_s_out <='b0;
    emif.jr_s_out <= 'b0;
    //emif.dhit_out <= 'b0;
    emif.MemWr_out <='b0;
    emif.halt_out <='b0;

    emif.pcplusfour_out<='b0;
    emif.rdat2_out <='b0;
    emif.alu_portOut_out <= 'b0;
    emif.instr_out <= 'b0;
    emif.Ext_addr_out <= 'b0;
    emif.rdat1_out <= 'b0;

    emif.imm_addr_out <='b0;
    emif.j_addr_out <='b0;
    emif.wsel_out <='b0;
    emif.shift_amt_out <='b0;
    emif.funct_out  <= 'b0;

    emif.rdat1_out <='b0;

        emif.pcplusfour_out<='b0;
        emif.rdat2_out <='b0;
        emif.alu_portOut_out <= 'b0;
        emif.instr_out <= 'b0;
        emif.Ext_addr_out <= 'b0;
        emif.rdat1_out <= 'b0;

        emif.imm_addr_out <='b0;
        emif.j_addr_out <='b0;
        emif.wsel_out <='b0;
        emif.shift_amt_out <='b0;
        emif.funct_out  <= 'b0;

        emif.rdat1_out <='b0;

        end

    // else if(emif.stall_for_data) begin
    //     emif.dREN_out <=  emif.dREN_out;
    //     emif.dWEN_out <= emif.dWEN_out;
    //     emif.bne_s_out <= emif.bne_s_out;
    //     emif.beq_s_out <= emif.beq_s_out;
    //     emif.jal_s_out<= emif.jal_s_out;
    //     emif.flagZero_out<=emif.flagZero_out;
    //     emif.lui_out<=emif.lui_out;
    //     emif.MemtoReg_out<=emif.MemtoReg_out;
    //     emif.RegWr_out <=emif.RegWr_out;
    //     emif.jump_s_out <=emif.jump_s_out;
    //     emif.jr_s_out <= emif.jr_s_out;
    //     emif.dhit_out <= emif.dhit_out;
    //     emif.MemWr_out <=emif.MemWr_out;
    //     emif.halt_out <=emif.halt_out;

    //     emif.pcplusfour_out<= emif.pcplusfour_out;
    //     emif.rdat2_out <=emif.rdat2_out;
    //     emif.alu_portOut_out <= emif.alu_portOut_out;
    //     emif.instr_out <= emif.instr_out; 
    //     emif.Ext_addr_out <= emif.Ext_addr_out;
    //     emif.rdat1_out <= emif.rdat1_out;

    //     emif.imm_addr_out <= emif.imm_addr_out;
    //     emif.j_addr_out <=emif.j_addr_out;
    //     emif.wsel_out <= emif.wsel_out;
    //     emif.shift_amt_out <=emif.shift_amt_out;
    //     emif.funct_out  <=  emif.funct_out;

    //     emif.rdat1_out <= emif.rdat1_out;

    //     end
    else begin
        emif.dREN_out <= emif.dREN_in;
        emif.dWEN_out <= emif.dWEN_in;
        emif.bne_s_out <= emif.bne_s_in;
        emif.beq_s_out <= emif.beq_s_in;
        emif.jal_s_out<=emif.jal_s_in;
        emif.flagZero_out<=emif.flagZero_in;
        emif.lui_out<=emif.lui_in;
        emif.MemtoReg_out<=emif.MemtoReg_in;
        emif.RegWr_out <=emif.RegWr_in;
        emif.jump_s_out <=emif.jump_s_in;
        emif.jr_s_out <= emif.jr_s_in;
        //emif.dhit_out <= emif.dhit_in;
        emif.MemWr_out <=emif.MemWr_in;
        emif.halt_out <=emif.halt_in ;

        emif.pcplusfour_out<=emif.pcplusfour_in;
        emif.rdat2_out <=emif.rdat2_in;
        emif.alu_portOut_out <= emif.alu_portOut_in;
        emif.instr_out <=  emif.instr_in;
        emif.Ext_addr_out <= emif.Ext_addr_in ;
        emif.rdat1_out <= emif.rdat1_in;

        emif.imm_addr_out <=emif.imm_addr_in;
        emif.j_addr_out <=emif.j_addr_in ;
        emif.wsel_out <=emif.wsel_in;
        emif.shift_amt_out <=emif.shift_amt_in;
        emif.funct_out  <= emif.funct_in;

        emif.rdat1_out <= emif.rdat1_in;

    end
end
endmodule