`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "cache_control_if.vh"
`include "caches_if.vh"

`timescale 1 ns / 1 ns

module icache_tb;
    logic CLK = 0, nRST;
    datapath_cache_if dcif();
    caches_if ccif();
    
    parameter PERIOD = 10;

    test PROG (CLK, nRST,dcif, ccif );

    always #(PERIOD/2) CLK++;

    //DUT
    `ifndef MAPPED
        icache DUT(CLK, nRST, dcif, ccif);
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

    task inputs;
        input  logic [31:0] i;
        input  logic j, k;
        input  logic [31:0] l;
    begin
        dctb.imemaddr = i;
        dctb.imemREN = j;
        cctb.iwait = k;
        cctb.iload = l;
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
        dctb.imemREN = 1;
        cctb.iwait = 1;
        cctb.iload = 1;
        #(PERIOD);
        nRST = 0;
        #(PERIOD*2);
        

        //******************************************************
        // TEST 1: empty read
        //******************************************************
        tb_test_num = tb_test_num+1;
        tb_test_case = "init";
        
        nRST = 1;
        #(PERIOD);
        init;

        tb_test_case = "miss then hit";
        inputs({26'h45, 4'd5, 2'b1}, 1, 1, 32'hBEEF);
        #(PERIOD*3);  
        ccif.iwait = 0;
        #(PERIOD);

        //******************************************************
        // TEST 2: another empty read later CLK the data comes in
        //******************************************************
        tb_test_num = tb_test_num+1;
        tb_test_case = "diff empty read";

        inputs({26'h729, 4'd11, 2'b0}, 1, 1, 32'h7337);
        #(PERIOD*3);  
        cctb.iload = 32'h7337;
        #(PERIOD)
        ccif.iwait = 0;
        #(PERIOD);

        //******************************************************
        // TEST 3: hit read
        //******************************************************
        tb_test_num = tb_test_num+1;
        tb_test_case = "hit";
        
        inputs({26'h45, 4'd5, 2'b1}, 1, 0, 0);
        #(PERIOD*3);

        //******************************************************
        // TEST 4: evict
        //******************************************************
        tb_test_num = tb_test_num+1;
        tb_test_case = "evict";
        
        nRST = 1;
        #(PERIOD);
        init;

        inputs({26'h140, 4'd5, 2'b0}, 1, 1, 32'hC007);
        #(PERIOD*3);  
        ccif.iwait = 0;
        #(PERIOD);

        //******************************************************
        // TEST 5: hit read other address
        //******************************************************
        tb_test_num = tb_test_num+1;
        tb_test_case = "hit other addr";
        
        inputs({26'h729, 4'd11, 2'b1}, 1, 0, 0);
        #(PERIOD*1);

        $finish;
    end


endprogram