`include "idecode_iexec_if.vh"
`include "cpu_types_pkg.vh"

module idecode_iexec_if
(
    input CLK, nRST,
    idecode_iexec_if.idie idieif
);

    import cpu_types_pkg::*;

    always_ff @(posedge CLK, negedge nRST) begin : PROCEED
        if(!nRST) begin
            idieif.dWEN_out <=0;
            idieif.dREN_out <=0;
            idieif.jal_s_out <=0;
            idieif.jr_s_out <= 0;
            idieif.j_s_out <= 0;
            idieif.RegDst_out <=0;
            idieif.ALUsrc_out <=0;
            idieif.ALUctr_out <=0;
            idieif.nxt_pc_out <=0;
            idieif.rdat1_out <=0;
            idieif.rdat2_out <=0;
            idieif.rs_out <=0;
            idieif.rt_out <=0;
            idieif.rd_out <=0;
            idieif.imm_addr <=0;
            idieif.lui_s_out <=0;
            idieif.ihit_out <=0;
            idieif.dhit_out <=0;
            idieif.instr_out <=0;
            idieif.jal_addr_out <= 0; 
            idieif.jr_addr_out <= 0;
            idieif.j_addr_out <= 0;
            idieif.branch_addr_out <=0;
            
        end

        else if(idieif.stall) begin
            idieif.dWEN_out <= idieif.dWEN_out;
            idieif.dREN_out <= idieif.dREN_out;
            idieif.jal_s_out <= idieif.jal_s_out;
            idieif.jr_s_out <= idieif.jr_s_out;
            idieif.j_s_out <= idieif.j_s_out;
            idieif.RegDst_out <= idieif.RegDst_out;
            idieif.ALUsrc_out <= idieif.ALUsrc_out;
            idieif.ALUctr_out <= idieif.ALUctr_out;
            idieif.nxt_pc_out <= idieif.nxt_pc_out;
            idieif.rdat1_out <= idieif.rdat1_out;
            idieif.rdat2_out <= idieif.rdat2_out;
            idieif.rs_out <= idieif.rs_out;
            idieif.rt_out <= idieif.rt_out;
            idieif.rd_out <= idieif.rd_out;
            idieif.imm_addr <= idieif.imm_addr;
            idieif.lui_s_out <= idieif.lui_s_out;
            idieif.ihit_out <= idieif.ihit_out;
            idieif.dhit_out <= idieif.dhit_out;
            idieif.instr_out <= idieif.instr_out;
            idieif.jal_addr_out <= idieif.jal_addr_out; 
            idieif.jr_addr_out <= idieif.jr_addr_out;
            idieif.j_addr_out <= idieif.j_addr_out;
            idieif.branch_addr_out <= idieif.branch_addr_out;
        end

        else begin
            idieif.dWEN_out <=idieif.dWEN_in;
            idieif.dREN_out <=idieif.dWEN_in;
            idieif.jal_s_out <=idieif.jal_s_in;
            idieif.jr_s_out <= idieif.jr_s_in;
            idieif.j_s_out <= idieif.j_s_in;
            idieif.RegDst_out <= idieif.RegDst_in;
            idieif.ALUsrc_out <= idieif.ALUsrc_in;
            idieif.ALUctr_out <= idieif.ALUctr_in;
            idieif.nxt_pc_out <=idieif.nxt_pc_in;
            idieif.rdat1_out <=idieif.rdat1;
            idieif.rdat2_out <=idieif.rdat2;
            idieif.rs_out <= idieif.rs;
            idieif.rt_out <= idieif.rt;
            idieif.rd_out <= idieif.rd;
            idieif.imm_addr <= idieif.imm_addr;
            idieif.lui_s_out <= idieif.lui_s_in;
            idieif.ihit_out <= idieif.ihit_in;
            idieif.dhit_out <= idieif.dhit_in;
            idieif.instr_out <= idieif.instr_in;
            idieif.jal_addr_out <= idieif.jal_addr_in; 
            idieif.jr_addr_out <= idieif.jr_addr_in;
            idieif.j_addr_out <= idieif.j_addr_in;
            idieif.branch_addr_out<=branch_addr_in;
        end
            

        else begin
            
        
    end
endmodule
