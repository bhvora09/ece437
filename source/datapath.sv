/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "alu_if.vh"
`include "control_unit_if.vh"
`include "datapath_cache_if.vh"
`include "memory_request_unit_if.vh"
`include "program_counter_if.vh"
`include "register_file_if.vh"
`include "cpu_types_pkg.vh"


module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
  );
  // import types
  import cpu_types_pkg::*;

  parameter PC_INIT=0;

  logic [31:0] SignExt_addr;
  logic [31:0] luiwdat;
  logic [31:0] ZeroExt_addr;
  logic [31:0] Ext_addr;
  logic [31:0] npc;
  logic [31:0] shift_left_1;
  logic [31:0] extended_address;
  logic [4:0] rd;

  //interfaces initialised as functions
  alu_if aluif();
  control_unit_if cuif();
  memory_request_unit_if mruif();
  program_counter_if pcif();
  register_file_if rfif();


  //adding all units in the datapath
  alu ALU(aluif);
  control_unit CU(cuif);
  memory_request_unit MRU(CLK,nRST,mruif);
  program_counter PC(CLK,nRST,pcif);
  register_file RF(CLK,nRST,rfif);
  
  always_comb begin
    SignExt_addr=32'b0;
    Ext_addr=32'h0;
    ZeroExt_addr=32'h0;
    rd=5'b0;
    npc=32'b0;
    shift_left_1=32'b0;
    extended_address=32'b0;
    luiwdat ='b0;
    //aluif.portA='b0;
    //aluif.portB='b0;

    //DP
    dpif.imemaddr=pcif.pc;
    dpif.dmemWEN=mruif.dmemWEN;
    dpif.imemREN=mruif.imemREN;
    dpif.dmemREN=mruif.dmemREN;
    dpif.dmemstore=rfif.rdat2;
    dpif.dmemaddr=aluif.portOut;
    //ALU
    //portA
    aluif.portA = rfif.rdat1;
    //signed ext
    if(cuif.instr[15])    //checked
      SignExt_addr = {16'hffff,cuif.imm_addr};
    else
      SignExt_addr = {16'h0000,cuif.imm_addr};
    //zero ext
    ZeroExt_addr = {16'h0000, cuif.imm_addr};
    
    if (cuif.ExtOp)
      Ext_addr = SignExt_addr;
    else
      Ext_addr = ZeroExt_addr;
    //portB
    if (cuif.ALUSrc)
      aluif.portB = Ext_addr;
    else
      aluif.portB = rfif.rdat2;
      //if alu=0
    //op
    aluif.op =  cuif.ALUctr;
    
    //CU
      //instr
    cuif.instr = dpif.imemload;
    //MRU
    mruif.iren=cuif.iREN;
      //dren
    mruif.dren = cuif.dREN; 
      //dwen
    mruif.dwen = cuif.dWEN;
      //dhit
    mruif.dhit = dpif.dhit;
      //ihit
    mruif.ihit = dpif.ihit;
    
    //PC
    //pcen
    pcif.PCen = dpif.ihit && (~dpif.dhit);
    //pc_next
    if(cuif.jal_s || cuif.jump_s) begin
      npc = pcif.pc + 4;
      extended_address =  {npc [31:28],dpif.imemload[25:0],2'b00};
      pcif.pc_next =  extended_address;end
    else if (cuif.bne_s)begin
      if(!aluif.flagZero)begin
        npc = pcif.pc + 4; 
        shift_left_1={Ext_addr[29:0],2'b00};
        pcif.pc_next = npc +shift_left_1;end
      else pcif.pc_next=pcif.pc+ 4; 
      end
    else if (cuif.beq_s)begin
      if(aluif.flagZero)begin
        npc = pcif.pc + 4; 
        shift_left_1={Ext_addr[29:0],2'b00};
        pcif.pc_next = npc +shift_left_1;end
      else pcif.pc_next=pcif.pc + 4;
        end
    else if (cuif.jr_s)
      pcif.pc_next = rfif.rdat1;
    else 
      pcif.pc_next= pcif.pc + 4;
    // case(cuif.PCsrc)
    //   2'b00: pcif.pc_next= pcif.pc + 4;
    //   2'b01: begin
    //     npc = pcif.pc +4; 
    //     shift_left_1=Ext_addr << 2;
    //     pcif.pc_next = npc +shift_left_1;
    //   end
    //   2'b10:begin
    //     npc = pcif.pc + 4;
    //     extended_address =  {npc [31:28],dpif.imemload[25:0],2'b00};
    //     pcif.pc_next =  extended_address;
    //   end
    //   2'b11:pcif.pc_next = rfif.rdat1;
      // endcase
    //end

    //RF
      //rsel1
      rfif.rsel1= cuif.reg_rs;
      //rsel2
      rfif.rsel2 = cuif.reg_rt;
      //wen
      
      rfif.WEN = cuif.RegWr && (dpif.ihit || dpif.dhit);
      

      //wsel
      if(cuif.jal_s)
        rd = 'hFFFFF;
      else
        rd = cuif.reg_rd;
      if(cuif.RegDst)
        rfif.wsel= rd;
      else
        rfif.wsel=cuif.reg_rt;
      
      //wdat
      if(cuif.lui)begin
        luiwdat = {cuif.imm_addr,16'h0000};
        rfif.wdat = {cuif.imm_addr,16'h0000};end
      else if (cuif.jal_s) //for jal
        rfif.wdat=pcif.pc + 4;
      else if(cuif.MemtoReg)
        rfif.wdat=dpif.dmemload;
      else
        rfif.wdat=aluif.portOut;
      //instr
    

    //
    
  end
  always_ff @(posedge CLK or negedge nRST) begin
     if(!nRST)
       dpif.halt<='b0;
      //dpif.halt<=cuif.halt || (nRST);
     else
      dpif.halt<=dpif.halt||cuif.halt;
      //dpif.halt<=(~cuif.halt) || (nRST && cuif.halt);
      
  end






endmodule
