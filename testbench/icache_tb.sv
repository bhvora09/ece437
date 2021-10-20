`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "cache_control_if.vh"
`include "caches_if.vh"

`timescale 1 ns / 1 ns

module icache_tb;

    datapath_cache_if dcif();
    caches_if ccif();

    logic CLK = 0, nRST;
    parameter PERIOD = 10;

    test PROG (CLK, nRST, dcif, ccif);

    always #(PERIOD/2) CLK++;

    //DUT
    `ifndef MAPPED
        icache DUT(CLK, nRST, ccif, dcif);
    `else
        icache DUT(
            .\CLK(CLK), 
            .\nRST(nRST),
            .\dcif.imemREN(dcif.imemREN),
            .\dcif.ihit(dcif.ihit),
            .\dcif.imemload(dcif.imemload),
            .\dcif.imemaddr(dcif.imemaddr),
            .\ccif.iwait(ccif.iwait),
            .\ccif.iload(ccif.iload),
            .\ccif.iaddr(ccif.iaddr),
            .\ccif.iREN(ccif.iREN)
        );
    `endif

endmodule

program test(
    input logic CLK,
    output logic nRST,
    datapath_cache_if dctb,
    caches_if cctb
);
    import cpu_types_pkg::*;
    parameter PERIOD = 10;

    task init;
    begin
        dctb.imemaddr = 0;
        dctb.imemREN = 0;
        cctb.iwait = 0;
        cctb.iload = 0;
        #(PERIOD);
    end
    endtask

    integer tb_test_num;
    string tb_test_case;

    initial begin
        //******************************************************
        // TEST 0: reset
        //******************************************************
        tb_test_num = 0;
        tb_test_case = "initialization";
        nRST = 1;
        
        dctb.imemaddr = 1;
        dcif.imemREN = 1;
        cctb.iwait = 1;
        cctb.iload = 1;
        #(PERIOD);
        nRST = 0;
        #(PERIOD);
        nRST = 1;
        #(PERIOD);

        $finish;
    end


endprogram