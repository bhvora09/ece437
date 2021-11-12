`include "cpu_types_pkg.vh"
`include "alu_if.vh"

module alu(
    alu_if.alu_ports aluif
    );

import cpu_types_pkg::*;
    always_comb begin
        aluif.flagNeg=0;
        aluif.flagOvf=0;
        aluif.flagZero=0;
        aluif.portOut=0;

        case(aluif.op)
        //shift left logic
        4'b0000: aluif.portOut =aluif.portB << aluif.portA[4:0];
        //shift right logic
        4'b0001: aluif.portOut = aluif.portB >> aluif.portA[4:0];
        //add
        4'b0010:
        begin
            aluif.portOut = aluif.portA + aluif.portB;
            if((aluif.portA[31] && aluif.portB[31]) || (~aluif.portOut[31] && (aluif.portA[31]^aluif.portB[31])))
                aluif.flagOvf='b1;
        end
        //subtract
        4'b0011:
        begin
            aluif.portOut = aluif.portA - aluif.portB;
            if(aluif.portA[31]<aluif.portB[31])
                aluif.flagOvf='b1;
        end
        //and bit by bit
        4'b0100: aluif.portOut = aluif.portA & aluif.portB;
    
        //or bit by bit
        4'b0101: aluif.portOut = aluif.portA | aluif.portB;
        //xor
        4'b0110: aluif.portOut = aluif.portA ^ aluif.portB;
        //nor
        4'b0111: aluif.portOut = ~(aluif.portA | aluif.portB);
        //slt- less than
        4'b1010: aluif.portOut = ($signed(aluif.portA) < $signed(aluif.portB) ? 1:0);
        //sltu
        4'b1011: aluif.portOut = (aluif.portA) < (aluif.portB) ? 1:0;
        endcase

        //for neg flag
        if(aluif.portOut[31]==1)
            aluif.flagNeg=1;
        if (aluif.portOut==0)
            aluif.flagZero=1;

    end

endmodule
