/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

`include "cache_control_if.vh"  //cache to memory ctrl
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  import cpu_types_pkg::*;
  parameter CPUS = 2;

  typedef enum logic {IDLE, CHECK1, WB1, WB2, RD1, RD2, WAIT} states;
  states s;
  states nS;

    always_ff @(posedge CLK, negedge nRST ) begin:FLIPFLOP
        if(!nRST) begin
            s <= IDLE;
        end
        else begin
            s <= nS;
        end

    end
    
   //bus_controller BC (CLK, nRST, ccif);//added bus controller

  assign ccif.iwait = (ccif.iREN) && (ccif.dREN || ccif.dWEN || (ccif.ramstate!=ACCESS)) ;
  assign ccif.dwait = (ccif.dREN || ccif.dWEN) && (ccif.ramstate!=ACCESS);
   
  always_comb begin
    ccif.iload='b0;
    ccif.dload='b0;
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
        ccif.dload  = ccif.ramload;  
        ccif.iload = 'b0;
      end
      else if (ccif.dWEN==1)
      begin
        ccif.ramaddr  =ccif.daddr; 
        ccif.ramREN= 'b0;
        ccif.ramWEN='b1;
        ccif.ramstore=ccif.dstore; //data is to be read at addr
        ccif.dload  = 'b0;  
        ccif.iload = 'b0;
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
