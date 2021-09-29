`include "ifetch_idecode_if.vh"
`include "cpu_types_pkg.vh"

module ifetch_idecode(
    input CLK, nRST,
    ifetch_idecode_if.fd_if ifidif
);

    import cpu_types_pkg::*;

    always_ff @(posedge CLK, negedge nRST) begin : PROCEED
        if(!nRST) begin
            ifidif.instr_out <=0;
            ifidif.pc_out <=0;
            ifidif.pcplusfour_out <=0;
            //ifidif.dhit_out <= 0;
            //ifidif.ihit_out <= 0;
        end

        // else if(ifidif.stall)begin
        //     ifidif.instr_out <= ifidif.instr_out;
        //     ifidif.npcplusfour_out <= ifidif.pcplusfour_out;
        //     ifidif.jump_inst <= ifidif.jump_inst;
        //     ifidif.rs <= ifidif.rs;
        //     ifidif.rt <= ifidif.rt;
        //     ifidif.rd <= ifidif.rd;
        //     ifidif.imm_addr <= ifidif.imm_addr;
        //     ifidif.lui_s_out <= ifidif.lui_s_out;
        //     ifidif.dhit_out <= ifidif.dhit_out;
        //     ifidif.ihit_out <= ifidif.ihit_out;
        //     ifidif.jal_addr_out <= ifidif.jal_addr_out; 
        //     ifidif.jr_addr_out <= ifidif.jr_addr_out;
        //     ifidif.j_addr_out <= ifidif.j_addr_out;
        //     idieif.branch_addr_out <= idieif.branch_addr_out;
        //     idieif.jal_s_out <= idieif.jal_s_out;
        //     idieif.jr_s_out <= idieif.jr_s_out;
        //     idieif.j_s_out <= idieif.j_s_out;
        // end
        else
        begin
            ifidif.instr_out <= ifidif.instr_in;
            ifidif.pc_out <=ifidif.pc_in;
            ifidif.pcplusfour_out <= ifidif.pcplusfour_in;
            //ifidif.dhit_out <= ifidif.dhit_in;
            //ifidif.ihit_out <= ifidif.ihit_in;
        end
        
    end
    
endmodule
