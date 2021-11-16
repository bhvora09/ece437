/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
//`include "datapath_cache_if.vh"  //datapath to cache
`include "cache_control_if.vh"  //cache to memory ctrl
//`include "caches_if"
`include "cpu_ram_if.vh"        // cpu to ram
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  //datapath_cache_if.dp dcif
  cache_control_if.cc ccif
  //cpu_ram_if.ram crif
);
  // type import
  import cpu_types_pkg::*;
  //ramstate_t ramstate;
  parameter CPUS = 2;

  //bus_controller BC (CLK, nRST, ccif);//added bus controller

  assign ccif.iwait = (ccif.iREN) && (ccif.dREN || ccif.dWEN || (ccif.ramstate!=ACCESS)) ;
  assign ccif.dwait = (ccif.dREN || ccif.dWEN) && (ccif.ramstate!=ACCESS);
   
  always_comb begin
    // ccif.iload='b0;
    // ccif.dload='b0;
    ccif.ramaddr='b0;
    ccif.ramREN='b0;
    ccif.ramWEN='b0;
    ccif.ramstore='b0;
    //ccif.dstore='b0;
    if (ccif.dREN==1)
    begin
      ccif.ramaddr  =ccif.daddr; 
      ccif.ramREN= 'b1;
      ccif.ramWEN='b0;
      ccif.ramstore='b0; //data is to be read at addr
      // ccif.dload  = ccif.ramload;  
      // ccif.iload = 'b0;
    end
    else if (ccif.dWEN==1)
    begin
      ccif.ramaddr  =ccif.daddr; 
      ccif.ramREN= 'b0;
      ccif.ramWEN='b1;
      ccif.ramstore=ccif.dstore; //data is to be read at addr
      // ccif.dload  = 'b0;  
      // ccif.iload = 'b0;
    end
    else if(ccif.iREN==1)
    begin
      ccif.ramaddr  =ccif.iaddr; 
      ccif.ramREN= 'b1;
      ccif.ramWEN='b0;
      ccif.ramstore='b0; //data is to be read at addr
      ccif.dload  = 'b0;  
      ccif.iload = ccif.ramload;
    end
  end


  
endmodule
