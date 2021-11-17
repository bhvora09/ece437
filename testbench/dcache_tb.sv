`include "cache_control_if.vh"
`include "caches_if.vh"
`include "cpu_ram_if.vh"
`include "cpu_types_pkg.vh"
//`include "system_if.vh"

`timescale 1 ns / 1 ns

module dcache_tb;
    datapath_cache_if dcif0();
    datapath_cache_if dcif1();
    caches_if cif0();
    caches_if cif1();
    cache_control_if #(CPUS(2)) ccif(cif0, cif1);
    cpu_ram_if ramif();
    //system_if sysif();

    parameter PERIOD = 10;
    logic CLK = 0, nRST;

    test PROG (CLK,nRST,dcif0, dcif1, cif0, cif1);

    always #(PERIOD/2) CLK++;

    //DUT
    `ifndef MAPPED
        dcache DUT0(CLK, nRST, dcif0, cif0);
        dcache DUT1(CLK, nRST, dcif1, cif1);
        bus_controller BUS(CLK, nRST,ccif);
        ram RAM(CLK, nRST, ramif);
    `else
        dcache DUT0(
        .\CLK(CLK), 
        .\nRST(nRST),
        .\dcif.dmemREN (dcif0.dmemREN),
        .\dcif.dmemWEN (dcif0.dmemWEN),
        .\dcif.dhit (dcif0.dhit),
        .\dcif.dmemload (dcif0.dmemload),
        .\dcif.dmemstore(dcif0.dmemstore)
        .\dcif.dmemaddr (dcif0.dmemaddr),
        .\dcif.halt(dcif0.halt),
        .\dcif.datomic(dcif0.datomic),
        .\dcif.flushed(dcif0.flushed),
        .\cdif.dwait (cif0.dwait),
        .\cdif.dload (cif0.dload),
        .\cdif.daddr (cif0.daddr),
        .\cdif.dREN (cif0.dREN),
        .\cdif.dWEN (cif0.dWEN),
        .\cdif.dstore (cif0.dstore)
        .\cdif.ccwait (cif0.ccwait),
        .\cdif.ccinv (cif0.ccinv),
        .\cdif.ccsnoopaddr(cif0.ccsnoopaddr),
        .\cdif.ccwrite(cif0.ccwrite),
        .\cdif.cctrans(cif0.cctrans)
        );

        dcache DUT1(
        .\CLK(CLK), 
        .\nRST(nRST),
        .\dcif.dmemREN (dcif1.dmemREN),
        .\dcif.dmemWEN (dcif1.dmemWEN),
        .\dcif.dhit (dcif1.dhit),
        .\dcif.dmemload (dcif1.dmemload),
        .\dcif.dmemstore(dcif1.dmemstore)
        .\dcif.dmemaddr (dcif1.dmemaddr),
        .\dcif.halt(dcif1.halt),
        .\dcif.datomic(dcif1.datomic),
        .\dcif.flushed(dcif1.flushed),
        .\cdif.dwait (cif1.dwait),
        .\cdif.dload (cif1.dload),
        .\cdif.daddr (cif1.daddr),
        .\cdif.dREN (cif1.dREN),
        .\cdif.dWEN (cif1.dWEN),
        .\cdif.dstore (cif1.dstore)
        .\cdif.ccwait (cif1.ccwait),
        .\cdif.ccinv (cif1.ccinv),
        .\cdif.ccsnoopaddr(cif1.ccsnoopaddr),
        .\cdif.ccwrite(cif1.ccwrite),
        .\cdif.cctrans(cif1.cctrans)
        );

        bus_controller BUS(
            .\CLK(CLK), 
            .\nRST(nRST),
            .\ccif.iREN (ccif.iREN),
            .\ccif.iaddr (ccif.iaddr),
            .\ccif.iload (ccif.iload),
            .\ccif.iwait (ccif.iwait),
            .\ccif.rsel1 (ccif.rsel1),
            .\ccif.dREN (ccif.dREN),
            .\ccif.dWEN (ccif.dWEN),
            .\ccif.daddr (ccif.daddr),
            .\ccif.dstore (ccif.dstore),
            .\ccif.dload (ccif.dload),
            .\ccif.dwait (ccif.dwait),
            .\ccif.ramload (ccif.ramload),
            .\ccif.ramstate (ccif.ramstate),
            .\ccif.ramaddr (ccif.ramaddr),
            .\ccif.ramWEN (ccif.ramWEN),
            .\ccif.ramREN (ccif.ramREN),
            .\ccif.ramstore (ccif.ramstore),
        );

        ram RAM(
            .\CLK(CLK), 
            .\nRST(nRST),
            \ramif.ramload (ramif.ramload),
            .\ramif.ramstate (ramif.ramstate),
            .\ramif.ramaddr (ramif.ramaddr),
            .\ramif.ramWEN (ramif.ramWEN),
            .\ramif.ramREN (ramif.ramREN),
            .\ramif.ramstore (ramif.ramstore),
        );

        `endif
    assign ccif.ramload = ramif.ramload;
    assign ccif.ramstate = ramif.ramstate;
    assign ramif.ramaddr = ccif.ramaddr;
    assign ramif.ramWEN = ccif.ramWEN;
    assign ramif.ramREN = ccif.ramREN;
    assign ramif.ramstore = ccif.ramstore;

endmodule

program test(
    input logic CLK,
    output logic nRST,
    datapath_cache_if dcif0, 
    datapath_cache_if dcif1, 
    caches_if cif0, 
    caches_if cif1,
);

    import cpu_types_pkg::*;
    parameter PERIOD = 10;

    task init;
    begin
        nRST = 0;
        dcif0.halt = 0;
        dcif0.datomic = 0;
        dcif0.dmemaddr = 32'b0;
        dcif0.dmemREN = 1'b0;
        dcif0.dmemWEN = 1'b0;
        dcif0.dmemstore =32'b0;
        dcif1.halt = 0;
        dcif1.datomic = 0;
        dcif1.dmemaddr = 32'b0;
        dcif1.dmemREN = 1'b0;
        dcif1.dmemWEN = 1'b0;
        dcif1.dmemstore =32'b0;
        cif0.dwait = 0;
        cif0.dload = 0;
        cif0.ccwait = 0;
        cif0.ccinv = 0;
        cif0.ccsnoopaddr = 0;
        cif1.dwait = 0;
        cif1.dload = 0;
        cif1.ccwait = 0;
        cif1.ccinv = 0;
        cif1.ccsnoopaddr = 0;
        #(PERIOD);
    end
    endtask

    integer tb_test_num;
    string tb_test_case;

    initial begin
        tb_test_case = "init and rst";
        tb_test_num = 0;
        init;
        nRST = 1;
        #(PERIOD);
        //******************************************************
        // TEST 1: 
        //******************************************************
        tb_test_num = 1;
        tb_test_case = "I->S and I->S";
        nRST = 0;
        
        //P0
        dcif0.dmemaddr = 'hF0;
        dcif0.dmemREN = 1'b1;

        //P1
        dcif1.dmemaddr = 'hF0;
        dcif1.dmemREN = 1'b1;

        #(6*PERIOD);
        
        
        //******************************************************
        // TEST 2: 
        //******************************************************
        tb_test_num = tb_test_num +1;
        tb_test_case = "S->M and S->I";

        //P0
        dcif0.dmemaddr = 'hF0;
        dcif0.dmemWEN = 1'b1;
        dcif0.dmemstore = 1'hBEEF;

        #(6*PERIOD);

        //******************************************************
        // TEST 3: 
        //******************************************************
        tb_test_num = tb_test_num +1;
        tb_test_case = "M->S and I->S";

        //P1
        dcif1.dmemaddr = 'hF0;
        dcif1.dmemREN = 1'b1;

        #(6*PERIOD);
        
        //******************************************************
        // TEST 3: 
        //******************************************************
        tb_test_num = tb_test_num +1;
        tb_test_case = "M->S and I->S";

        //P1
        dcif1.dmemaddr = 'hF0;
        dcif1.dmemREN = 1'b1;

        #(6*PERIOD);

        //******************************************************
        // TEST 4: 
        //******************************************************
        tb_test_num = tb_test_num +1;
        tb_test_case = "I->I and I->M";

        //P1
        dcif1.dmemaddr = 'hA40;
        dcif1.dmemWEN = 1'b1;
        dcif1.dmemstore = 1'h7337;

        #(6*PERIOD);

        //******************************************************
        // TEST 5: 
        //******************************************************
        tb_test_num = tb_test_num +1;
        tb_test_case = "I->I and M->M";

        //P1
        dcif1.dmemaddr = 'hA40;
        dcif1.dmemWEN = 1'b1;
        dcif1.dmemstore = 1'hC007;

        #(6*PERIOD);

        //******************************************************
        // TEST 5: 
        //******************************************************
        tb_test_num = tb_test_num +1;
        tb_test_case = "I->M and M->S";
        
        //NOT complete
        //P1
        dcif1.dmemaddr = 'hA40;
        dcif1.dmemWEN = 1'b1;
        dcif1.dmemstore = 1'hC007;

        #(6*PERIOD);

        //make sure testcases cover all the msi states
        /*

        

        //******************************************************
        // TEST 3: 
        //******************************************************
        tb_test_num = tb_test_num +1;
        tb_test_case = "lw diff addr";
        //lw value at [F8]
        dctb.dmemaddr = 'hF8;
        cctb.dload = 32'h1337;
        #(PERIOD*6);

        cctb.dload = 32'hDEAD;
        #(PERIOD*6);

        //******************************************************
        // TEST 4: 
        //******************************************************
        tb_test_num = tb_test_num +1;
        tb_test_case = "writing";
        //----------sw words-------//
        dcif.dmemREN =1'b0;
        dcif.dmemWEN =1'b1;
        //sw value 7331 at [80]
        dctb.dmemaddr = 32'h80;
        dctb.dmemstore = 32'h7331;
        #(PERIOD*6);
       
        //******************************************************
        // TEST 5: 
        //******************************************************
        tb_test_num = tb_test_num +1;
        tb_test_case = "writing";
        //sw 2700 at [84]
        cctb.dload= 32'h7331;
        dctb.dmemaddr = 32'h84;
        dctb.dmemstore = 32'h2700;
        #(PERIOD*7);

        //******************************************************
        // TEST 6: 
        //******************************************************
        tb_test_num = tb_test_num +1;
        tb_test_case = "more writing";
        //sw 1331 at [88]
        dctb.dmemaddr = 32'h88;
        dctb.dmemstore = 32'h1331;
        #(PERIOD*6);

        //******************************************************
        // TEST 7: 
        //******************************************************
        tb_test_num = tb_test_num +1;
        tb_test_case = "halt";
        //sw DEADBEEF at [8C]
        dctb.dmemaddr = 32'h8C;
        dctb.dmemstore = 32'hDEADBEEF;
        #(PERIOD*19);
        
        dctb.halt = 1;
        dctb.dmemWEN=0;
        dctb.dmemREN=0;
        dctb.dmemaddr = 32'b0;
        dctb.dmemstore = 32'h0;
        cctb.dload = 32'h0;
        #(PERIOD*16);
        */

        $finish;
    end
endprogram