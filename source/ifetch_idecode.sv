`include "ifetch_idecode_if.vh"
`include "cpu_types_pkg.vh"

module ifetch_idecode_if
(
    input CLK, nRST,
    ifetch_idecode_if.ifid ifidif
);

    import cpu_types_pkg::*;

    always_ff @(posedge CLK, negedge nRST) begin : PROCEED
        if(!nRST) begin
            ifidif.instOut <=0;
            ifidif.nxt_pc_out <=0;
            ifidif.jump_inst <=0;
            ifidif.rs <= 0;
            ifidif.rt <= 0;
            ifidif.rd <= 0;
            ifidif.imm_addr <= 0;
            ifidif.lui_s_out <= 0;
            ifidif.dhit_out <= 0;
            ifidif.ihit_out <= 0;
            ifidif.jal_addr_out <= 0; 
            ifidif.jr_addr_out <= 0;
            ifidif.j_addr_out <= 0;
            idieif.branch_addr_out <=0;
            idieif.jal_s_out <=0;
            idieif.jr_s_out <= 0;
            idieif.j_s_out <= 0;
        end
        else if(ifidif.stall)begin
            ifidif.instOut <= ifidif.instOut;
            ifidif.nxt_pc_out <= ifidif.nxt_pc_out;
            ifidif.jump_inst <= ifidif.jump_inst;
            ifidif.rs <= ifidif.rs;
            ifidif.rt <= ifidif.rt;
            ifidif.rd <= ifidif.rd;
            ifidif.imm_addr <= ifidif.imm_addr;
            ifidif.lui_s_out <= ifidif.lui_s_out;
            ifidif.dhit_out <= ifidif.dhit_out;
            ifidif.ihit_out <= ifidif.ihit_out;
            ifidif.jal_addr_out <= ifidif.jal_addr_out; 
            ifidif.jr_addr_out <= ifidif.jr_addr_out;
            ifidif.j_addr_out <= ifidif.j_addr_out;
            idieif.branch_addr_out <= idieif.branch_addr_out;
            idieif.jal_s_out <= idieif.jal_s_out;
            idieif.jr_s_out <= idieif.jr_s_out;
            idieif.j_s_out <= idieif.j_s_out;
        end
        else
        begin
            ifidif.instOut <= ifidif.instIn;
            ifidif.nxt_pc_out <= ifidif.nxt_pc_in;
            ifidif.jump_inst <= ifidif.inst_in[25:0];
            ifidif.rs <= ifidif.inst_in[25:21];
            ifidif.rt <= ifidif.inst_in[20:16];
            ifidif.rd <= ifidif.inst_in[15:11];
            ifidif.imm_addr <= ifidif.inst_in[15:0];
            ifidif.lui_s_out <= ifidif.lui_s_in;
            ifidif.dhit_out <= ifidif.dhit_in;
            ifidif.ihit_out <= ifidif.ihit_in;
            ifidif.jal_addr_out <= ifidif.jal_addr_in; 
            ifidif.jr_addr_out <= ifidif.jr_addr_in;
            ifidif.j_addr_out <= ifidif.j_addr_in;
            idieif.branch_addr_out <= branch_addr_in;
            idieif.jal_s_out <=idieif.jal_s_in;
            idieif.jr_s_out <= idieif.jr_s_in;
            idieif.j_s_out <= idieif.j_s_in;
        end
        
    end