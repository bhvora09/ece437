`include "ifetch_idecode_if.vh"
`include "cpu_types_pkg.vh"

module ifetch_idecode(
    input CLK, nRST,
    ifetch_idecode_if.fd_if ifidif
);
import cpu_types_pkg::*;

// assign ifidif.instr_in2 = (~ifidif.stall_for_instr) & ifidif.instr_in ;
// assign ifidif.pc_in2 =(~ifidif.stall_for_instr) & ifidif.pc_in ;
// assign ifidif.pcplusfour_in2 =(~ifidif.stall_for_instr) & ifidif.pcplusfour_in ;

   

    always_ff @(posedge CLK, negedge nRST) begin : PROCEED
        if(!nRST) begin
            ifidif.instr_out <=0;
            ifidif.pc_out <=0;
            ifidif.pcplusfour_out <=0;
            //ifidif.dhit_out <= 0;
            //ifidif.ihit_out <= 0;
        end

        else if(ifidif.stall_for_data) begin
            ifidif.instr_out <=ifidif.instr_out;
            ifidif.pc_out <=ifidif.pc_out;
            ifidif.pcplusfour_out <=ifidif.pcplusfour_out;
            //ifidif.dhit_out <= 0;
            //ifidif.ihit_out <= 0;
        end
        else
        begin
            ifidif.instr_out <= ifidif.instr_in2;
            ifidif.pc_out <=ifidif.pc_in2;
            ifidif.pcplusfour_out <= ifidif.pcplusfour_in2;
            //ifidif.dhit_out <= ifidif.dhit_in;
            //ifidif.ihit_out <= ifidif.ihit_in;
        end
        
    end
    
endmodule
