//COPIED FROM HAZARD UNIT TB

`include "cpu_types_pkg.vh"
`include "forwarding_unit_if.vh"


// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module forwarding_unit_tb;

  // interface
  forwarding_unit_if fuif ();
  // test program
  test PROG (.tb_IO(fuif));
  // DUT
`ifndef MAPPED
  forwarding_unit DUT(fuif);
`else
  forwarding_unit DUT(
    .\fuif.emif_RegWr, (fuif.emif_RegWr),
    .\fuif.mwif_RegWr, (fuif.mwif_RegWr),
    .\fuif.emif_rd, (fuif.emif_rd),
    .\fuif.mwif_rd, (fuif.mwif_rd),
    .\fuif.deif_rs, (fuif.deif_rs),
    .\fuif.deif_rt, (fuif.deif_rt),
    .\fuif.emif_portout, (fuif.emif_portout),
    .\fuif.mwif_portout, (fuif.mwif_portout),
    .\fuif.Asel, (fuif.Asel),
    .\fuif.Bsel, (fuif.Bsel),
    .\fuif.DataB, (fuif.DataB),
    .\fuif.DataA, (fuif.DataA)      
  );
`endif
endmodule

program test(
  forwarding_unit_if tb_IO
);

  import cpu_types_pkg::*;

  parameter PERIOD = 5;

  task init;
  begin
    fuif.emif_RegWr = '0;
    fuif.mwif_RegWr = '0;
    fuif.emif_rd = '0;
    fuif.mwif_rd = '0;
    fuif.deif_rs = '0;
    fuif.deif_rt = '0;
    fuif.emif_portout = '0;
    fuif.mwif_portout = '0;
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
    // TEST 1: Forward from mem
    //******************************************************
    tb_test_num = tb_test_num +1;
    tb_test_case = "mem";
    fuif.emif_RegWr = 1;
    fuif.deif_rs = 5;
    fuif.deif_rt = 5;
    fuif.emif_rd = 5;
    fuif.emif_portout = 'hFF00FF00;

    #(PERIOD);

    //******************************************************
    // TEST 2: Forward from wb
    //******************************************************
    tb_test_num = tb_test_num +1;
    tb_test_case = "wb";
    init;

    fuif.mwif_RegWr = 1;
    fuif.deif_rs = 18;
    fuif.deif_rt = 18;
    fuif.mwif_rd = 18;
    fuif.mwif_portout = 'hBEEF;

    #(PERIOD);

    //******************************************************
    // TEST 3: regWr 0 wb
    //******************************************************
    tb_test_num = tb_test_num +1;
    tb_test_case = "regWr 0 wb";
    init;

    fuif.mwif_RegWr = 0;
    fuif.deif_rs = 18;
    fuif.deif_rt = 18;
    fuif.mwif_rd = 18;
    fuif.mwif_portout = 'hBEEF;

    #(PERIOD);

    //******************************************************
    // TEST 4: regWr 0 mem
    //******************************************************
    tb_test_num = tb_test_num +1;
    tb_test_case = "regWr 0 mem";
    fuif.emif_RegWr = 0;
    fuif.deif_rs = 5;
    fuif.deif_rt = 5;
    fuif.emif_rd = 5;
    fuif.emif_portout = 'hFF00FF00;

    #(PERIOD);
    
    //******************************************************
    // TEST 5: reg 0 wb
    //******************************************************
    tb_test_num = tb_test_num +1;
    tb_test_case = "reg 0 wb";
    init;

    fuif.mwif_RegWr = 1;
    fuif.deif_rs = 0;
    fuif.deif_rt = 0;
    fuif.mwif_rd = 0;
    fuif.mwif_portout = 'hBEEF;

    #(PERIOD);

    //******************************************************
    // TEST 6: reg 0 mem
    //******************************************************
    tb_test_num = tb_test_num +1;
    tb_test_case = "reg 0 mem";
    fuif.emif_RegWr = 1;
    fuif.deif_rs = 0;
    fuif.deif_rt = 0;
    fuif.emif_rd = 0;
    fuif.emif_portout = 'hFF00FF00;

    #(PERIOD);

    //******************************************************
    // TEST 7: sametime
    //******************************************************
    tb_test_num = tb_test_num +1;
    tb_test_case = "both";
    init;

    fuif.mwif_RegWr = 1;
    fuif.deif_rs = 18;
    fuif.deif_rt = 18;
    fuif.mwif_rd = 18;
    fuif.mwif_portout = 'hBEEF;

    fuif.emif_RegWr = 1;
    fuif.deif_rs = 5;
    fuif.deif_rt = 5;
    fuif.emif_rd = 5;
    fuif.emif_portout = 'hFF00FF00;

    #(PERIOD);

    $finish;
    

  end

endprogram