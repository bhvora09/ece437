`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "cache_control_if.vh"
`include "caches_if.vh"

`timescale 1 ns / 1 ns

module dcache_tb;
    datapath_cache_if dcif();
    caches_if cdif();
    
    parameter PERIOD = 10;
    logic CLK = 0, nRST;

    test PROG (CLK,nRST,dcif,cdif);

    always #(PERIOD/2) CLK++;

    //DUT
    `ifndef MAPPED
        dcache DUT(CLK, nRST, dcif, cdif);
    `else
        dcache DUT(
        .\CLK(CLK), 
        .\nRST(nRST),
        .\dcif.dmemREN (dcif.dmemREN),
        .\dcif.dmemWEN (dcif.dmemWEN),
        .\dcif.dhit (dcif.dhit),
        .\dcif.dmemload (dcif.dmemload),
        .\dcif.dmemstore(dcif.dmemstore)
        .\dcif.dmemaddr (dcif.dmemaddr),
        .\ccif.dwait (ccif.dwait),
        .\ccif.dload (ccif.dload),
        .\ccif.daddr (ccif.daddr),
        .\ccif.dREN (ccif.dREN),
        .\ccif.dWEN (ccif.dWEN),
        .\ccif.dstore (ccif.dstore)
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
        //cctb.dload = 32'b0;
        dctb.dmemstore =32'b0;
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
        nRST = 0;

        //lw checking 
        
        dctb.dmemaddr = 'hF0;
        dcif.dmemREN = 1'b1;
        dcif.dmemWEN = 1'b0;
        cctb.dwait = 0;
        dcif.halt = 0;
        //lw value of addr[F0] -> 7337
        dctb.dmemstore = 32'b01010;
        cctb.dload = 32'h7337;
        #(PERIOD);
        nRST =1;
        #(PERIOD);
        #(PERIOD);
        cctb.dload = 32'h2701;
        #(PERIOD);
        
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        //lw value at [F4]
        dctb.dmemaddr = 'hB0;
        dcif.dmemREN = 1'b1;
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        dctb.dmemaddr = 'hF4;
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        //lw value at [F8]
        dctb.dmemaddr = 'hF8;
        cctb.dload = 32'h1337;
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        cctb.dload = 32'hDEAD;
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        //----------sw words-------//
        dcif.dmemREN =1'b0;
        dcif.dmemWEN =1'b1;
        //sw value 7331 at [80]
        dctb.dmemaddr = 32'h80;
        dctb.dmemstore = 32'h7331;
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        //sw 2700 at [84]
        cctb.dload= 32'h7331;
        dctb.dmemaddr = 32'h84;
        dctb.dmemstore = 32'h2700;
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);

        //sw 1331 at [88]
        dctb.dmemaddr = 32'h88;
        dctb.dmemstore = 32'h1331;
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        //sw DEADBEEF at [8C]
        dctb.dmemaddr = 32'h8C;
        dctb.dmemstore = 32'hDEADBEEF;
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD*5);
       
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        dctb.halt = 1;
        dctb.dmemWEN=0;
        dctb.dmemREN=0;
        dctb.dmemaddr = 32'b0;
        dctb.dmemstore = 32'h0;
        cctb.dload = 32'h0;
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);
        #(PERIOD);

        $finish;
    end
endprogram