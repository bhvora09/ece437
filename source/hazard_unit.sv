/*
page 308 
load use
branch
jump
RAW
*/

`include "cpu_types_pkg.vh"
`include "hazard_unit_if.vh"

module hazard_unit(
    hazard_unit_if.hu huif
);

    always_comb
    begin 
        huif.fdif_stall = 0;
        huif.fdif_flush = 0;
        huif.deif_stall = 0;
        huif.deif_flush = 0;
        huif.emif_stall = 0;
        huif.emif_flush = 0;
        huif.mwif_stall = 0;
        huif.mwif_flush = 0;
        huif.PCWrite = 1;
        //branch prediction
        if(huif.emif_bneS) begin
            huif.deif_flush = 1;
            huif.fdif_flush = 1;
            huif.emif_flush = 1;
        end
        else if(huif.emif_beqS) begin
            huif.deif_flush = 1;
            huif.fdif_flush = 1;
            huif.emif_flush = 1;
        end

        //jump
        else if(huif.emif_jS) begin
            huif.deif_flush = 1;
            huif.fdif_flush = 1;
            huif.emif_flush = 1;
        end

        else if(huif.emif_jrS) begin
            huif.deif_flush = 1;
            huif.fdif_flush = 1;
            huif.emif_flush = 1;
        end

        else if(huif.emif_jalS) begin
            huif.deif_flush = 1;
            huif.fdif_flush = 1;
            huif.emif_flush = 1;
        end

        //RAW
        // else if(huif.deif_MemtoReg & ((huif.deif_rt == huif.fdif_rs) | (huif.deif_rt == huif.fdif_rt))) begin
        
        else if((huif.deif_rt != 'b0) & (huif.fdif_rs != 'b0) & (huif.deif_rt!=0))begin
            if((huif.deif_MemtoReg | huif.deif_RegWr)  & ((huif.deif_rt == huif.fdif_rs) | (huif.deif_rt == huif.fdif_rt))) begin
                huif.fdif_stall = 1;
                huif.PCWrite = 0;
            end
        //else if(huif.deif_MemtoReg & ((huif.emif_rt == huif.fdif_rs) | (huif.emif_rt == huif.fdif_rt))) begin
            if((huif.emif_MemtoReg | huif.emif_RegWr) & ((huif.emif_rt == huif.fdif_rs) | (huif.emif_rt == huif.fdif_rt)))begin
                huif.deif_stall = 1;
                huif.fdif_stall = 1;
                huif.PCWrite = 0;
            end
        end

    end

endmodule