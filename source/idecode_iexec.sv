`include "idecode_iexec_if.vh"
`include "cpu_types_pkg.vh"

module idecode_iexec(
    input CLK, nRST,
    idecode_iexec_if.de_if idieif
);

    import cpu_types_pkg::*;

    always_ff @(posedge CLK, negedge nRST) begin : PROCEED
        if(!nRST) begin
            idieif.dREN_out <='b0;
            idieif.dWEN_out <= 'b0;
            idieif.instr_out <='b0;
            idieif.Ext_addr_out<='b0;
            idieif.pcplusfour_out<='b0;
            idieif.rdat1_out <='b0;
            idieif.rdat2_out <='b0;
            idieif.jal_s_out <='b0;
            idieif.jr_s_out <= 'b0;
            idieif.jump_s_out <= 'b0;
            idieif.bne_s_out<='b0;
            idieif.beq_s_out<='b0;
            idieif.lui_out <='b0;
            idieif.RegDst_out <='b0;
            idieif.ALUSrc_out <='b0;
            idieif.ALUctr_out <='b0;
            idieif.RegWr_out<='b0;
            idieif.MemWr_out<='b0;
            idieif.MemtoReg_out<='b0;
            idieif.halt_out<='b0;
            idieif.imm_addr_out <='b0;
            idieif.reg_rs_out <= 'b0;
            idieif.reg_rt_out <='b0;
            idieif.reg_rd_out<='b0;
            idieif.shift_amt_out <='b0;
            idieif.j_addr_out <= 'b0;

            idieif.funct_out <=funct_t'('b0);
            idieif.opcode_out <=opcode_t'('b0);
            idieif.pc_out <= 'b0;
            end

        else if(idieif.stall) begin
            idieif.instr_out <= idieif.instr_out;
            idieif.Ext_addr_out<=idieif.Ext_addr_out;
            idieif.pcplusfour_out<=idieif.pcplusfour_out;
            idieif.rdat1_out <=idieif.rdat1_out;
            idieif.rdat2_out <=idieif.rdat2_out;

            idieif.dWEN_out <=idieif.dWEN_out;
            idieif.dREN_out <=idieif.dREN_out;
            idieif.jal_s_out <=idieif.jal_s_out;
            idieif.jr_s_out <= idieif.jr_s_out;
            idieif.jump_s_out <= idieif.jump_s_out;
            idieif.bne_s_out<=idieif.bne_s_out;
            idieif.beq_s_out<=idieif.beq_s_out;
            idieif.lui_out <= idieif.lui_out;

            idieif.RegDst_out <= idieif.RegDst_out;
            idieif.ALUSrc_out <= idieif.ALUSrc_out;
            idieif.ALUctr_out <= idieif.ALUctr_out;
            idieif.RegWr_out<=idieif.RegWr_out;
            idieif.MemWr_out<=idieif.MemWr_out;
            idieif.MemtoReg_out<=idieif.MemtoReg_out;
            idieif.halt_out<=idieif.halt_out;
            
            idieif.imm_addr_out <= idieif.imm_addr_out;
            
            idieif.reg_rs_out <= idieif.reg_rs_out;
            idieif.reg_rt_out <=idieif.reg_rt_out;
            idieif.reg_rd_out<=idieif.reg_rd_out;
            idieif.shift_amt_out <= idieif.shift_amt_out;

            idieif.j_addr_out <= idieif.j_addr_out;

            idieif.funct_out <=idieif.funct_out;
            idieif.opcode_out <= idieif.opcode_out;
            idieif.pc_out <= idieif.pc_out;
        end

        else if(idieif.ihit | idieif.dhit )  begin //let it pass only if ihit has come
            idieif.instr_out <= idieif.instr_in;
            idieif.Ext_addr_out<=idieif.Ext_addr_in;
            idieif.pcplusfour_out<=idieif.pcplusfour_in;
            idieif.rdat1_out <=idieif.rdat1_in;
            idieif.rdat2_out <=idieif.rdat2_in;

            idieif.dWEN_out <=idieif.dWEN_in;
            idieif.dREN_out <=idieif.dREN_in;
            idieif.jal_s_out <=idieif.jal_s_in;
            idieif.jr_s_out <= idieif.jr_s_in;
            idieif.jump_s_out <= idieif.jump_s_in;
            idieif.bne_s_out<=idieif.bne_s_in;
            idieif.beq_s_out<=idieif.beq_s_in;
            idieif.lui_out <= idieif.lui_in;

            idieif.RegDst_out <= idieif.RegDst_in;
            idieif.ALUSrc_out <= idieif.ALUSrc_in;
            idieif.ALUctr_out <= idieif.ALUctr_in;
            idieif.RegWr_out<=idieif.RegWr_in;
            idieif.MemWr_out<=idieif.MemWr_in;
            idieif.MemtoReg_out<=idieif.MemtoReg_in;
            idieif.halt_out<=idieif.halt_in;
            
            idieif.imm_addr_out <= idieif.imm_addr_in;
            
            idieif.reg_rs_out <= idieif.reg_rs_in;
            idieif.reg_rt_out <=idieif.reg_rt_in;
            idieif.reg_rd_out<=idieif.reg_rd_in;
            idieif.shift_amt_out <= idieif.shift_amt_in;

            idieif.j_addr_out <= idieif.j_addr_in;

            idieif.funct_out <=idieif.funct_in;
            idieif.opcode_out <= idieif.opcode_in;
            idieif.pc_out <= idieif.pc_in;
            //idieif.dhit_out <= idieif.dhit_in;
            //idieif.ihit_out <= idieif.ihit_in;
            //idieif.dhit_out <= idieif.dhit_in;    
        end
     end
endmodule
