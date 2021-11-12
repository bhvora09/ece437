`include "cpu_types_pkg.vh"
`include "hazard_unit_if.vh"


// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module hazard_unit_tb;

  // interface
  hazard_unit_if huif ();
  // test program
  test PROG (.tb_IO(huif));
  // DUT
`ifndef MAPPED
  hazard_unit DUT(huif);
`else
  hazard_unit DUT(
      .\huif.PCWrite, (huif.PCWrite),
      .\huif.deif_MemtoReg, (huif.deif_MemtoReg),
      .\huif.deif_memWr, (huif.deif_memWr),
      .\huif.emif_bneS, (huif.emif_bneS),
      .\huif.emif_beqS, (huif.emif_beqS),
      .\huif.emif_jS, (huif.emif_jS),
      .\huif.emif_jrS, (huif.emif_jrS),
      .\huif.emif_jalS, (huif.emif_jalS),
      .\huif.fdif_flush, (huif.fdif_flush),
      .\huif.fdif_stall, (huif.fdif_stall),
      .\huif.deif_flush, (huif.deif_flush),
      .\huif.deif_stall, (huif.deif_stall),
      .\huif.emif_flush, (huif.emif_flush),
      .\huif.emif_stall, (huif.emif_stall),
      .\huif.mwif_flush, (huif.mwif_flush),
      .\huif.mwif_stall, (huif.mwif_stall),
      .\huif.fdif_rs, (huif.fdif_rs),
      .\huif.fdif_rt, (huif.fdif_rt,
      .\huif.deif_rs, (huif.deif_rs),
      .\huif.deif_rt, (huif.deif_rt),
      .\huif.deif_rd, (huif.deif_rd),
      .\huif.emif_rt, (huif.emif_rt),
      .\huif.emif_rs, (huif.emif_rs)
  );
`endif
endmodule

program test(
  hazard_unit_if tb_IO
);

  import cpu_types_pkg::*;

  parameter PERIOD = 5;

  task init;
  begin
    huif.deif_MemtoReg = 0;
    huif.deif_memWr = 0;
    huif.emif_bneS = 0;
    huif.emif_beqS = 0;
    huif.emif_jS = 0;
    huif.emif_jrS = 0;
    huif.emif_jalS = 0;
    huif.fdif_rs = 0;
    huif.fdif_rt = 0;
    huif.fdif_rd = 0;
    huif.deif_rt = 0;
    huif.deif_rd =0;
    huif.deif_rs = 0;
    huif.emif_rt = 0;
    huif.emif_rd =0;
    huif.emif_rs = 0;
    #(PERIOD);
  end
  endtask


  integer tb_test_num;
  string tb_test_case;

  initial begin
    //******************************************************
    // TEST 0: Initialize
    //******************************************************
    tb_test_num = 0;
    tb_test_case = "initialization";
    init;

    //******************************************************
    // TEST 1: RAW ex fetch
    //******************************************************
    tb_test_num = tb_test_num +1;
    tb_test_case = "RAW ex";

    huif.deif_MemtoReg = 1;
    huif.fdif_rs = 5'd4;
    huif.deif_rt = 5'd4;
    
    #(PERIOD);

    init;

    huif.deif_MemtoReg = 1;
    huif.fdif_rt = 5'd7;
    huif.deif_rt = 5'd7;

    #(PERIOD);

    //******************************************************
    // TEST 2: RAW mem fetch
    //******************************************************
    tb_test_num = tb_test_num +1;
    tb_test_case = "RAW mem";
    
    init;
    
    huif.deif_MemtoReg = 1;
    huif.fdif_rs = 5'd4;
    huif.emif_rt = 5'd4;
    
    #(PERIOD);

    init;

    huif.deif_MemtoReg = 1;
    huif.fdif_rt = 5'd7;
    huif.emif_rt = 5'd7;

    #(PERIOD);

    //******************************************************
    // TEST 3: branch
    //******************************************************
    tb_test_num = tb_test_num +1;
    tb_test_case = "branch";
    
    init;
    
    huif.emif_beqS = 1;
    
    #(PERIOD);

    init;

    huif.emif_bneS = 1;

    #(PERIOD);

    //******************************************************
    // TEST 4: jump
    //******************************************************
    tb_test_num = tb_test_num +1;
    tb_test_case = "jump";
    
    init;
    
    huif.emif_jS = 1;
    
    #(PERIOD);

    init;

    huif.emif_jrS = 1;

    #(PERIOD);

    init;

    huif.emif_jalS = 1;

    #(PERIOD);


    

    $finish;

  end

endprogram