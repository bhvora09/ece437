`include "forwarding_unit_if.vh"
`include "cpu_types_pkg.vh"

module forwarding_unit
(
    forwarding_unit_if.fu fuif
);

    import cpu_types_pkg::*;

    always_comb begin : LOG

        fuif.Asel = 0;
        fuif.Bsel = 0;
        fuif.DataA = 0;
        fuif.DataB = 0; 

        if((fuif.emif_RegWr)  & (fuif.emif_rd != 'b0) & (fuif.emif_rd == fuif.deif_rs)) begin
                fuif.Asel = 1;
                fuif.DataA = fuif.emif_portout;
        end

        if((fuif.emif_RegWr)  & (fuif.emif_rd != 'b0) & (fuif.emif_rd == fuif.deif_rt)) begin
                fuif.Bsel = 1;
                fuif.DataB = fuif.emif_portout;
        end

        if((fuif.mwif_RegWr)  & (fuif.mwif_rd != 'b0) & (fuif.mwif_rd == fuif.deif_rs)) begin
                fuif.Asel = 1;
                fuif.DataA = fuif.mwif_portout;
        end

        if((fuif.mwif_RegWr)  & (fuif.mwif_rd != 'b0) & (fuif.mwif_rd == fuif.deif_rt)) begin
                fuif.Bsel = 1;
                fuif.DataB = fuif.mwif_portout;
        end
    end

endmodule