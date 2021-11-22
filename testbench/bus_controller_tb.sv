// mapped needs this
`include "cache_control_if.vh"
`include "caches_if.vh"
`include "cpu_ram_if.vh"
`include "cpu_types_pkg.vh"
`include "system_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module bus_controller_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface

  caches_if cif0();
  caches_if cif1();
  cache_control_if #(.CPUS(2)) ccif(cif0, cif1);
  cpu_ram_if ramif();
  system_if sysif();

  // test program
  test PROG (CLK,nRST,ccif,ramif);
  // DUT
`ifndef MAPPED
  bus_controller DUT(CLK, nRST, ccif);//bus controller called inside
  ram RAM(CLK, nRST, ramif);

`else
  bus_controller DUT(
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
    .\nRST (nRST),
    .\CLK (CLK)
  );

  ram RAM(
    .\ramif.ramload (ramif.ramload),
    .\ramif.ramstate (ramif.ramstate),
    .\ramif.ramaddr (ramif.ramaddr),
    .\ramif.ramWEN (ramif.ramWEN),
    .\ramif.ramREN (ramif.ramREN),
    .\ramif.ramstore (ramif.ramstore),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

  //Connect ram module and memory control module
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
  cache_control_if.cc ccif_tb,
  cpu_ram_if.ram ramif_tb
);

  parameter PERIOD = 10;
  integer tb_test_num;
  string tb_test_case;

  task reset_dut;
  begin
    nRST = 1'b0;

    @(posedge CLK);
    @(posedge CLK);

    @(negedge CLK);
    nRST = 1'b1;
  end
  endtask

  task automatic dump_memory();
    string filename = "memcpu.hex";
    int memfd;

    sysif.tbCTRL = 1;
    sysif.addr = 0;
    sysif.WEN = 0;
    sysif.REN = 0;

    memfd = $fopen(filename,"w");
    if (memfd)
      $display("Starting memory dump.");
    else
      begin $display("Failed to open %s.",filename); $finish; end

    for (int unsigned i = 0; memfd && i < 16384; i++)
    begin
      int chksum = 0;
      bit [7:0][7:0] values;
      string ihex;

      sysif.addr = i << 2;
      sysif.REN = 1;
      repeat (4) @(posedge CLK);
      if (sysif.load === 0)
        continue;
      values = {8'h04,16'(i),8'h00,sysif.load};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),sysif.load,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      sysif.tbCTRL = 0;
      sysif.REN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask

  initial begin
    //******************************************************
    // TEST 0: Initialize
    //******************************************************
    tb_test_num = 0;
    tb_test_case = "initialization";
    nRST = '1;
    cif0.iREN = '0;
    cif0.iaddr = '0;
    cif0.dREN = '0;
    cif0.dWEN = '0;
    cif0.daddr ='0;
    cif0.dstore = '0;
    sysif.tbCTRL = '0;
    cif0.cctrans = 0;
    cif0.ccwrite = 0;

    cif1.iREN = '0;
    cif1.iaddr = '0;
    cif1.dREN = '0;
    cif1.dWEN = '0;
    cif1.daddr ='0;
    cif1.dstore = '0;
    cif1.cctrans = '0;
    cif1.ccwrite = '0;

    #(2*PERIOD);

    reset_dut;
    
    //both i caches want to read //1
    tb_test_num = tb_test_num+1;
    cif0.iREN = '1;
    cif0.iaddr = 'h0004;
    cif0.dREN = '0;
    cif0.dWEN = '0;
    cif0.daddr ='hABCD;
    cif0.dstore = '0;
    cif0.cctrans = 0;
    cif0.ccwrite = 0;

    cif1.iREN = 'b1;
    cif1.iaddr = 'h000C;
    cif1.dREN = '0;
    cif1.dWEN = '0;
    cif1.daddr ='hABCD;
    cif1.dstore = '0;
    cif1.cctrans = 0;
    cif1.ccwrite = 0;

    #(PERIOD*4);

    //both d caches want to read invalid and not dirty //2
    tb_test_num = tb_test_num+1;
    cif0.iREN = '0;
    cif0.iaddr = 'h0004;
    cif0.dREN = '1;
    cif0.dWEN = '0;
    cif0.daddr ='h8;
    cif0.dstore = '0;
    cif0.cctrans = 0;
    cif0.ccwrite = 0;

    cif1.iREN = 'b0;
    cif1.iaddr = 'h000C;
    cif1.dREN = '1;
    cif1.dWEN = '0;
    cif1.daddr ='hf0;
    cif1.dstore = '0;
    cif1.cctrans = 0;
    cif1.ccwrite = 0;

    #(PERIOD*8);
    cif0.dREN = '0;
    #(PERIOD*7); 
    // both wants to write to valid and dirty //3
    tb_test_num = tb_test_num+1;
    cif0.iREN = '0;
    cif0.iaddr = 'hFF00;
    cif0.dREN = '0;
    cif0.dWEN = '1;
    cif0.daddr ='hABCD;
    cif0.dstore = 'h1234;
    cif0.cctrans = 1;
    cif0.ccwrite = 1;

    cif1.iREN = 'b0;
    cif1.iaddr = 'hFF00;
    cif1.dREN = '0;
    cif1.dWEN = '1;
    cif1.daddr ='hABCD;
    cif1.dstore = 'hA1B2;
    cif1.cctrans = 0;
    cif1.ccwrite = 0;
    
    #(PERIOD*2);
    cif0.cctrans = 1;
    cif0.dWEN = '0;
    cif0.ccwrite = 0;
    cif1.cctrans = 1;
    cif1.ccwrite = 1;
    #(PERIOD);
    cif0.daddr = 'hABC9;
    #(PERIOD*2);
    //0-read 1 - write //4
    tb_test_num = tb_test_num+1;

    cif0.iREN = '0;
    cif0.iaddr = 'hFF00;
    cif0.dREN = '1;
    cif0.dWEN = '0;
    cif0.daddr ='hABCD;
    cif0.dstore = 'h1234;//sim:/bus_controller_tb/PROG/tb_test_num

    cif1.iREN = 'b0;
    cif1.iaddr = 'hFF00;
    cif1.dREN = '0;
    cif1.dWEN = '1;
    cif1.daddr ='hABCD;
    cif1.dstore = 'hA1B2;
    cif1.cctrans = 0;
    cif1.ccwrite = 0;
    
    #(PERIOD*6);
    cif0.dREN = '0;
    #(PERIOD*6);

    //0 - read, valid and not dirty -snooping - 1- valid and not dirty //5
    tb_test_num = tb_test_num+1;//sim:/bus_controller_tb/PROG/tb_test_num

    cif0.dWEN = '0;
    cif0.daddr ='hABCD;
    cif0.dstore = 'h1234;
    cif0.cctrans = 1;
    cif0.ccwrite = 0;

    cif1.iREN = 'b0;
    cif1.iaddr = 'hFF00;
    cif1.dREN = '0;
    cif1.dWEN = '0;
    cif1.daddr ='hABCD;
    cif1.dstore = 'hA1B2;
    cif1.cctrans = 1;
    cif1.ccwrite = 0;
    
    #(PERIOD*2);

    ////0 - read, valid and not dirty -snooping - 1- valid and dirty //6
    tb_test_num = tb_test_num+1;
    cif0.iREN = '0;
    cif0.iaddr = 'hFF00;
    cif0.dREN = '1;
    cif0.dWEN = '0;
    cif0.daddr ='hABCD;
    cif0.dstore = 'h1234;
    cif0.cctrans = 1;
    cif0.ccwrite = 0;

    cif1.iREN = 'b0;
    cif1.iaddr = 'hFF00;
    cif1.dREN = '0;
    cif1.dWEN = '0;
    cif1.daddr ='hABCD;
    cif1.dstore = 'hA1B2;
    cif1.cctrans = 1;
    cif1.ccwrite = 1;
    
    #(PERIOD*2);
  

    //0 - read, valid and not dirty -snooping - 1- invalid and not dirty //7
    tb_test_num = tb_test_num+1;
    cif0.iREN = '0;
    cif0.iaddr = 'hFF00;
    cif0.dREN = '1;
    cif0.dWEN = '0;
    cif0.daddr ='hABCD;
    cif0.dstore = 'h1234;
    cif0.cctrans = 1;
    cif0.ccwrite = 0;

    cif1.iREN = 'b0;
    cif1.iaddr = 'hFF00;
    cif1.dREN = '0;
    cif1.dWEN = '0;
    cif1.daddr ='hABCD;
    cif1.dstore = 'hA1B2;
    cif1.cctrans = 1;
    cif1.ccwrite = 0;
    
    #(PERIOD*2);


    //0- read, valid and dirty - //8
    tb_test_num = tb_test_num+1;
    cif0.iREN = '0;
    cif0.iaddr = 'hFF00;
    cif0.dREN = '1;
    cif0.dWEN = '0;
    cif0.daddr ='hABCD;
    cif0.dstore = 'h1234;
    cif0.cctrans = 1;
    cif0.ccwrite = 1;

    cif1.iREN = 'b0;
    cif1.iaddr = 'hFF00;
    cif1.dREN = '0;
    cif1.dWEN = '0;
    cif1.daddr ='hABCD;
    cif1.dstore = 'hA1B2;
    cif1.cctrans = 0;
    cif1.ccwrite = 0;
    
    #(PERIOD*2);


    //0- read, invalid and not dirty //9
    tb_test_num = tb_test_num+1;
    cif0.iREN = '0;
    cif0.iaddr = 'hFF00;
    cif0.dREN = '1;
    cif0.dWEN = '0;
    cif0.daddr ='hABCD;
    cif0.dstore = 'h1234;
    cif0.cctrans = 0;
    cif0.ccwrite = 0;

    cif1.iREN = 'b0;
    cif1.iaddr = 'hFF00;
    cif1.dREN = '0;
    cif1.dWEN = '0;
    cif1.daddr ='hABCD;
    cif1.dstore = 'hA1B2;
    cif1.cctrans = 0;
    cif1.ccwrite = 0;
    
    #(PERIOD*6);
   
    //0 - write, valid and not dirty -snooping - 1(M)-valid and dirty- invalidate others //10
    tb_test_num = tb_test_num+1;
    cif0.iREN = '0;
    cif0.iaddr = 'hFF00;
    cif0.dREN = '0;
    cif0.dWEN = '1;
    cif0.daddr ='hABCD;
    cif0.dstore = 'h1234;
    cif0.cctrans = 1;
    cif0.ccwrite = 0;

    cif1.iREN = 'b0;
    cif1.iaddr = 'hFF00;
    cif1.dREN = '0;
    cif1.dWEN = '0;
    cif1.daddr ='hABCD;
    cif1.dstore = 'hA1B2;
    cif1.cctrans = 1;
    cif1.ccwrite = 1;
    
    #(PERIOD*6);
    cif1.cctrans = 0;
    cif1.ccwrite = 0;
    #(PERIOD*6);

    //0 - write, valid and not dirty -snooping - 1 invalid and not dirty //11
    tb_test_num = tb_test_num+1;
    cif0.iREN = '0;
    cif0.iaddr = 'hFF00;
    cif0.dREN = '0;
    cif0.dWEN = '1;
    cif0.daddr ='hABCD;
    cif0.dstore = 'h1234;
    cif0.cctrans = 1;
    cif0.ccwrite = 0;

    cif1.iREN = 'b0;
    cif1.iaddr = 'hFF00;
    cif1.dREN = '0;
    cif1.dWEN = '0;
    cif1.daddr ='hABCD;
    cif1.dstore = 'hA1B2;
    cif1.cctrans = 0;
    cif1.ccwrite = 0;
    
    #(PERIOD*6);
    #(PERIOD*6);

    //0- write, valid and dirty   1- invalid //12
    tb_test_num = tb_test_num+1;
    cif0.iREN = '0;
    cif0.iaddr = 'hFF00;
    cif0.dREN = '0;
    cif0.dWEN = '1;
    cif0.daddr ='hABCD;
    cif0.dstore = 'h1234;
    cif0.cctrans = 1;
    cif0.ccwrite = 1;

    cif1.iREN = 'b0;
    cif1.iaddr = 'hFF00;
    cif1.dREN = '0;
    cif1.dWEN = '0;
    cif1.daddr ='hABCD;
    cif1.dstore = 'hA1B2;
    cif1.cctrans = 0;
    cif1.ccwrite = 0;
    
    #(PERIOD*2);
    

  //0- write, valid and dirty -    1- shared  //13
    tb_test_num = tb_test_num+1;
    cif0.iREN = '0;
    cif0.iaddr = 'hFF00;
    cif0.dREN = '0;
    cif0.dWEN = '1;
    cif0.daddr ='hABCD;
    cif0.dstore = 'h1234;
    cif0.cctrans = 1;
    cif0.ccwrite = 1;

    cif1.iREN = 'b0;
    cif1.iaddr = 'hFF00;
    cif1.dREN = '0;
    cif1.dWEN = '0;
    cif1.daddr ='hABCD;
    cif1.dstore = 'hA1B2;
    cif1.cctrans = 1;
    cif1.ccwrite = 0;
    
    #(PERIOD*6);
    #(PERIOD*6);


    //0- write invalid and not dirty  //14 - other cache is valid
    tb_test_num = tb_test_num+1;
    cif0.iREN = '0;
    cif0.iaddr = 'hFF00;
    cif0.dREN = '0;
    cif0.dWEN = '1;
    cif0.daddr ='hABCD;
    cif0.dstore = 'h1234;
    cif0.cctrans = 1;
    cif0.ccwrite = 0;

    cif1.iREN = 'b0;
    cif1.iaddr = 'hFF00;
    cif1.dREN = '0;
    cif1.dWEN = '0;
    cif1.daddr ='hABCD;
    cif1.dstore = 'hA1B2;
    cif1.cctrans = 1;
    cif1.ccwrite = 0;
    
    #(PERIOD*6);
    #(PERIOD*6);

    //mem controller testcases
    /*//******************************************************
    // TEST 1: read write data
    //******************************************************
    tb_test_num = tb_test_num + 1;
    tb_test_case = "read write data";
    cif0.iREN = '0;
    cif0.iaddr = '0;
    cif0.dREN = '0;
    cif0.dWEN = '0;
    cif0.daddr ='0;
    cif0.dstore = '0;

    #(PERIOD);

    cif0.dREN = '1;
    cif0.daddr =16'h0000;

    #(3*PERIOD);

    cif0.dREN = '0;
    cif0.dWEN = '1;
    cif0.dstore = 32'hfc4b5912;

    #(3*PERIOD);


    reset_dut;  

    //******************************************************
    // TEST 2: read instr
    //******************************************************
    tb_test_num = tb_test_num + 1;
    tb_test_case = "read instr";
    cif0.iREN = '0;
    cif0.iaddr = '0;
    cif0.dREN = '0;
    cif0.dWEN = '0;
    cif0.daddr ='0;
    cif0.dstore = '0;

    #(PERIOD);
    cif0.iREN = '1;
    cif0.iaddr = 32'h0004;

    #(3*PERIOD);

    reset_dut; 

    //******************************************************
    // TEST 3: conflicting instr and data read
    //******************************************************
    tb_test_num = tb_test_num + 1;
    tb_test_case = "conflicting instr and data read";
    cif0.iREN = '0;
    cif0.iaddr = '0;
    cif0.dREN = '0;
    cif0.dWEN = '0;
    cif0.daddr ='0;
    cif0.dstore = '0;

    #(PERIOD);

    cif0.iREN = '1;
    cif0.iaddr = 32'h0008;
    cif0.dREN = '1;
    cif0.daddr = 16'h000C;

    #(3*PERIOD);

    reset_dut; 

    //******************************************************
    // TEST 4: conflicting instr read and data write
    //******************************************************
    tb_test_num = tb_test_num + 1;
    tb_test_case = "conflicting instr read and data write";
    cif0.iREN = '0;
    cif0.iaddr = '0;
    cif0.dREN = '0;
    cif0.dWEN = '0;
    cif0.daddr ='0;
    cif0.dstore = '0;

    #(PERIOD);

    cif0.iREN = '1;
    cif0.iaddr = 16'h0010;
    cif0.dWEN = '1;
    cif0.dstore = 32'h600510;
    cif0.daddr = 16'h0014;
    cif0.dREN = 'b1;
    cif0.daddr = $u
    #(3*PERIOD);

    reset_dut; 

    //******************************************************
    // TEST 5: dump memory
    //******************************************************
    tb_test_num = tb_test_num + 1;
    tb_test_case = "dump memory";
    cif0.iREN = '0;
    cif0.iaddr = '0;
    cif0.dREN = '0;
    cif0.dWEN = '0;
    cif0.daddr ='0;
    cif0.dstore = '0;*/

    //dump_memory;

    reset_dut; 
    
    $finish;

    

  end


endprogram