/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "caches_if.vh"
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"
`include "system_if.vh"
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module memory_control_tb;

  parameter PERIOD = 10;
  parameter CPUS = 2;
  logic CLK = 0, nRST;

  // test vars
  
  // clock
  always #(PERIOD/2) CLK++;

  // interface
  
  cpu_ram_if rif();
  caches_if cif0();
  caches_if cif1();
  system_if syif();
  cache_control_if #(.CPUS(1)) ccif (cif0,cif1);
  //cache_control_if ccif ();
  
  // DUT
`ifndef MAPPED
  memory_control MCDUT(CLK, nRST, ccif);
`else
  memory_control MCDUT(
    
    .\ccif.ramload (ccif.ramload),
    .\ccif.ramstate (ccif.ramstate),
    .\ccif.ramaddr (ccif.ramaddr),
    .\ccif.ramWEN (ccif.ramWEN),
    .\ccif.ramREN (ccif.ramREN),
    .\ccif.ramstore (ccif.ramstore),

    .\ccif.iREN (ccif.iREN),
    .\ccif.dREN (ccif.dREN),
    .\ccif.dWEN (ccif.dWEN),
    .\ccif.iaddr (ccif.iaddr),
    .\ccif.iwait (ccif.iwait),
    .\ccif.daddr (ccif.daddr),
    .\ccif.dstore (ccif.dstore),
    .\ccif.iload (ccif.iload),
    .\ccif.dload (ccif.dload),
    .\ccif.dwait (ccif.dwait),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

`ifndef MAPPED
  ram RAMDUT(CLK, nRST, rif);
`else
  ram RAMDUT(
    /*
    .\rif.ramstate (rif.ramstate),
    .\rif.ramload (rif.ramload),
    .\rif.ramREN (rif.ramREN),
    .\rif.ramWEN (rif.ramWEN),
    .\rif.ramaddr (rif.ramaddr),
    .\rif.ramstore (rif.ramstore), */
  );
`endif


//cpu_ram interface -> cache_control interface
assign ccif.ramstate = rif.ramstate;
assign ccif.ramload = rif.ramload;
assign rif.ramREN = (syif.tbCTRL )? syif.REN :ccif.ramREN;
assign rif.ramWEN = (syif.tbCTRL )? syif.WEN : ccif.ramWEN;
assign rif.ramaddr= (syif.tbCTRL )? syif.addr :ccif.ramaddr;
assign rif.ramstore= (syif.tbCTRL )? syif.store: ccif.ramstore;

// test program
  test PROG (CLK, nRST, rif,cif0, syif);

endmodule

program test(
  input  logic CLK,
  output logic nRST,
  //cache_control_if ccif,
  cpu_ram_if rif,
  caches_if cif0,
  system_if syif
  //cache_control_if.tb ccif
  
);
  //import cpu_types_pkg::*
  //ramstate_t ramstate;

  parameter PERIOD = 10;
  initial begin
    syif.tbCTRL = 0;
    nRST = 'b0;
    //ccif.ramstate = "FREE";
    cif0.iREN = 'b0;
    cif0.dREN = 'b0;
    cif0.dWEN = 'b0;
    cif0.iaddr = 'b0;
    cif0.daddr = 'b0;
    cif0.dstore ='b0;
  
    @(negedge CLK);
    //ram has twice more clockcycles. so 
  #(PERIOD);  
  #(PERIOD);
    nRST = 'b1;

  #(PERIOD);  
  #(PERIOD);
    //read an instruction at addr 4
    //ccif.ramstate = "FREE";
    cif0.iREN = 1'b1;
    cif0.dREN = 1'b0;
    cif0.dWEN = 1'b0;
    cif0.iaddr = 32'h4;
    cif0.daddr = 32'b0;
    cif0.dstore =32'b0;

  #(PERIOD);
  #(PERIOD);
  #(PERIOD);
  #(PERIOD);

    //read data at addr 8 and check ram addr value not colliding with iaddr
    cif0.iREN = 1'b0;
    cif0.dREN = 1'h1;
    cif0.dWEN = 1'b0;
    cif0.iaddr = 32'h0;
    cif0.daddr = 32'h8;
    cif0.dstore =32'h0;
  
  #(PERIOD);
  #(PERIOD);

    //store data at addr C and check ram addr value not colliding with iaddr
    cif0.iREN = 1'b0;
    cif0.dREN = 1'b0;
    cif0.dWEN = 1'b1;
    cif0.iaddr = 32'h4;
    cif0.daddr = 32'h8;
    cif0.dstore =32'hC;

  #(PERIOD);
  #(PERIOD);

//instr read and datawrite at the same time data
    cif0.iREN = 1'b1;
    cif0.dREN = 1'b0;
    cif0.dWEN = 1'b1;
    cif0.iaddr = 32'hC;
    cif0.daddr = 32'h10;
    cif0.dstore =32'h55555;

  #(PERIOD);
  #(PERIOD);

//instr read and data read 
    cif0.iREN = 1'b1;
    cif0.dREN = 1'b1;
    cif0.dWEN = 1'b0;
    cif0.iaddr = 32'h10;
    cif0.daddr = 32'h14;
    cif0.dstore =32'b0;

  #(PERIOD);
  #(PERIOD);

    cif0.iREN = 1'b0;
    cif0.dREN = 1'b0;
    cif0.dWEN = 1'b0;
    cif0.iaddr = 32'b0;
    cif0.daddr = 32'b0;
    cif0.dstore =32'b0;

  #(PERIOD);
  #(PERIOD);

  dump_memory();
  $finish;

  end

//from system_tb
 task automatic dump_memory();
    string filename = "memcpu.hex";
    int memfd;

    syif.tbCTRL = 1;
    syif.addr = 0;
    syif.WEN = 0;
    syif.REN = 0;


    
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

      syif.addr = i << 2;
      syif.REN = 1;
      repeat (4) @(posedge CLK);
      if (ccif.ramload === 0)
        continue;
      values = {8'h04,16'(i),8'h00,ccif.ramload};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),ccif.ramload,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      syif.tbCTRL = 0;
      syif.REN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask



  /*@(posedge CLK)
  //read instr from memory at iaddr
  nRST = 'b0;
  //ccif.ramstate = "ACCESS";
  ccif.iREN= 'b1;
  ccif.dREN = 'b0;
  ccif.dWEN = 'b0;
  ccif.iaddr = 'b10;

  @(posedge CLK)
  //read instr from memory at iaddr
  nRST = 'b0;
  //ccif.ramstate = ACCESS;
  ccif.iREN= 'b0;
  ccif.dREN = 'b1;
  ccif.dWEN = 'b0;
  ccif.iaddr = 'b11;*/

  

//end
endprogram