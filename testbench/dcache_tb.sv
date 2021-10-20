`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "cache_control_if.vh"
`include "caches_if.vh"

`timescale 1 ns / 1 ns

module dcache_tb;

    datapath_cache_if dcif();
    caches_if ccif();

    logic CLK = 0, nRST;
    parameter PERIOD = 10;

    test PROG (CLK, nRST, dcif, ccif);

    always #(PERIOD/2) CLK++;

    //DUT
    `ifndef MAPPED
        dcache DUT(CLK, nRST, ccif, dcif);
    `else
        dcache DUT(
        .\CLK(CLK), 
        .\nRST(nRST),
        .\dcif.dmemREN(dcif.dmemREN),
        .\dcif.dmemWEN(dcif.dmemWEN),
        .\dcif.dhit(dcif.dhit),
        .\dcif.dmemload(dcif.dmemload),
        .\dcif.dmemstore(dcif.dmemstore)
        .\dcif.dmemaddr(dcif.dmemaddr),
        .\ccif.dwait(ccif.dwait),
        .\ccif.dload(ccif.dload),
        .\ccif.daddr(ccif.daddr),
        .\ccif.dREN(ccif.dREN),
        .\ccif.dWEN(ccif.dWEN),
        .\ccif.dstore(ccif.dstore)
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
        nRST = 0;
        dctb.dmemaddr = 32'b0;
        dctb.dmemREN = 1'b0;
        dctb.dmemWEN = 1'b0;
        //cctb.dwait = 1'b0; //dwait is input
        cctb.dload = 32'b0;
        cctb.dstore =32'b0;
        #(PERIOD);
    end
    integer tb_test_num;
    string tb_test_case;

    initial begin
        //******************************************************
        // TEST 0: reset
        //******************************************************
        tb_test_num = 0;
        tb_test_case = "initialization";
        nRST = 1;
        
        dctb.dmemaddr = 'b100;
        dcif.dmemREN = 1'b1;
        dcif.dmemWEN = 1'b0;
        cctb.dwait = 0;
        cctb.dload = 32'b1;
        #(PERIOD);
        #(PERIOD);

        $finish;
    end


endprogram
    endtask
