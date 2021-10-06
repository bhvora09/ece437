//COPIED FROM HAZARD UNIT TB

`include "cpu_types_pkg.vh"
`include "fowarding_unit_if.vh"


// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module forwarding_unit_tb;

  // interface
  forwarding_unit_if fuif ();
  // test program
  test PROG (.tb_IO(fuif));
  // DUT
`ifndef MAPPED
  hazard_unit DUT(fuif);
`else
  hazard_unit DUT(
      .\fuif.deif_rt, (fuif.deif_rt),
      .\fuif.deif_rd, (fuif.deif_rd),
      .\fuif.emif_rt, (fuif.emif_rt),
      .\fuif.emif_rs, (fuif.emif_rs)
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