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
`include "ifetch_idecode_if.vh"
`include "idecode_iexec_if.vh"
`include "exec_mem_if.vh"
`include "mem_wrb_if.vh"
`include "cpu_types_pkg.vh"


module datapath_for_pipeline (
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
  logic [31:0] instr;
  logic  stall;

  //interfaces initialised as functions
  alu_if aluif();
  control_unit_if cuif();
  memory_request_unit_if mruif();
  program_counter_if pcif();
  register_file_if rfif();
  ifetch_idecode_if fdif();
  idecode_iexec_if deif();
  exec_mem_if emif();
  mem_wrb_if mwif();

  //adding all units in the datapath
  alu ALU(aluif);
  control_unit CU(cuif);
  memory_request_unit MRU(CLK,nRST,mruif);
  program_counter PC(CLK,nRST,pcif);
  register_file RF(CLK,nRST,rfif);
  ifetch_idecode FETCHDECODE(CLK, nRST, fdif);
  idecode_iexec DECODEXEC(CLK, nRST, deif);
  exec_mem EXECMEM(CLK, nRST, emif);
  mem_wrb MEMWRB(CLK, nRST, mwif);


  //opcodes
  opcode_t opinfetch;
  opcode_t opindecode;
  opcode_t opinexec;
  opcode_t opinmem;
  opcode_t opinwrback;

  assign opinfetch = opcode_t'(fdif.instr_in[31:26]);
  assign opindecode = opcode_t'(deif.instr_in[31:26]);
  assign opinexec = opcode_t'(emif.instr_in[31:26]);
  assign opinmem = opcode_t'(mwif.instr_in[31:26]);
  assign opinwrback = opcode_t'(mwif.instr_out[31:26]);

  funct aluopinfetch;
  funct aluopindecode;
  funct aluopinexec;
  funct aluopinmem;
  funct aluopinwrback;

  assign aluopinfetch = funct'(fdif.instr_in[5:0]);
  assign aluopindecode = funct'(deif.instr_in[5:0]);
  assign aluopinexec = funct'(emif.instr_in[5:0]);
  assign aluopinmem = funct'(mwif.instr_in[5:0]);
  assign aluopinwrback = funct'(mwif.instr_out[5:0]);



  always_comb begin
    //all variables
    SignExt_addr=32'b0;
    Ext_addr=32'h0;
    ZeroExt_addr=32'h0;
    rd=5'b0;
    npc=32'b0;
    shift_left_1=32'b0;
    extended_address=32'b0;
    instr = dpif.imemload;

    //ADD LOGIC FOR STALL in each stage 
    //stall = ; not sure

    //aluif.portA='b0;
    //aluif.portB='b0;

    //FETCH stage-> 1.dp 2.pc(clk) 3.mru  4. fetch_decode_if
    //====================================================================
    //1.DP
    //-----------------------------------------------------------
    dpif.imemaddr=pcif.pc;
    dpif.dmemWEN=mruif.dmemWEN;
    dpif.imemREN=mruif.imemREN;
    //read happens in mem stage
    dpif.dmemREN=mruif.dmemREN;
    //dpif.dmemstore=rfif.rdat2;
    dpif.dmemstore=emif.rdat2_out;  //add
    //dpif.dmemaddr=aluif.portOut;
    dpif.dmemaddr=emif.alu_portOut_out; //add
    //--------------------------------------------
    //2.PC
    //2.1 pcen
    //-------------------------------------------
    pcif.PCen = dpif.ihit && (~dpif.dhit);
    //------------------------------------------
    
    //2.2 sign extender in decode stage
    //--------------------------------------------
    if(cuif.instr[15])    //checked
      SignExt_addr = {16'hffff,cuif.imm_addr};
    else
      SignExt_addr = {16'h0000,cuif.imm_addr};
    //zero ext
    ZeroExt_addr = {16'h0000, cuif.imm_addr};
    
    if (cuif.ExtOp)
      deif.Ext_addr_in = SignExt_addr;  //add both
    else
      deif.Ext_addr_in = ZeroExt_addr; 
    //portB
    if (deif.ALUSrc)
      aluif.portB = deif.Ext_addr_out;  //add
    else
      aluif.portB = deif.rdat2_out;     //add
    //---------------------------------------------------


    //2.2 pc_next-> branch, jal, jr, jump in mem and normal cases in fetch
    //------------------------------------------------------------
    if(emif.jal_s_out || emif.jump_s_out) begin //add both
      extended_address =  {emif.pcplusfour_out[31:28],emif.instr_out[25:0],2'b00}; //add
      pcif.pc_next =  extended_address;end
    //for branch  mem stage
    else if (emif.bne_s_out)begin //add
      if(!emif.flagZero_out)begin //add
        npc = emif.pcplusfour_out; //add
        shift_left_1={emif.Ext_addr_out[29:0],2'b00}; //add
        pcif.pc_next = npc +shift_left_1;end
      else pcif.pc_next=pcif.pc+ 4; 
      end
    //for branch equal in mem stage
    else if (emif.beq_s_out)begin //add
      if(emif.flagZero_out)begin //add
        npc = emif.pcplusfour_out; //add 
        shift_left_1={emif.Ext_addr_out[29:0],2'b00}; //add
        pcif.pc_next = npc +shift_left_1;end
      else pcif.pc_next=pcif.pc + 4;
        end
    else if (emif.jr_s_out) //add
      //pcif.pc_next = rfif.rdat1;
      pcif.pc_next = deif.rdat1_out;   //add
    else 
      pcif.pc_next= pcif.pc + 4;
    //------------------------------------------------------

    // 3. Memory Request Unit
    //---------------------------------------------------------
    mruif.iren=cuif.iREN; //always 1???
      //dren- data read happens in mem stage
    mruif.dren = emif.dREN_out; //add 
      //dwen- data write also happens in mem stage
    mruif.dwen = emif.dWEN_out; //add
      //dhit - affected by data read or write in mem stage
    mruif.dhit = emif.dhit_out; //add
      //ihit
    mruif.ihit = dpif.ihit; //not sure about ihit
    //--------------------------------------------------------------------------

    //4.ifetch idecode if
    //--------------------------------------------------------------------------
    fdif.instr_in = dpif.imemload; //add
    fdif.pcplusfour_in = pcif.pc + 4; //add
    fdif.pc_in = pcif.pc; //add
    //------------------------------------------------------------------------
     //ifetch idecode if----- added by akshaj
    // fdif.instr_in = instr;
    // fdif.pc = pc;
    // fdif.nxt_pc_in = pc_next;
    // fdif.stall = stall;
    // fdif.lui_s_in = cuif.lui_s;
    // fdif.jal_s_in = cuif.jal_s;
    // fdif.jr_s_in = cuif.jr_s;
    // fdif.j_s_in = cuif.j_s;
    // fdif.ihit_in = dpif.ihit;
    // fdif.dhit_in = dpif.dhit;
    // fdif.jal_addr_in = instr[25:0];
    // fdif.jr_addr_in = instr[25:0];
    // fdif.j_addr_in = instr[25:0];
    // fdif.branch_addr_in = [15:0];
    //==========================================================================
    
    //DECODE stage 1.cu 2.regfile  3.decode_execute_if
    //===========================================================================
    //1. control unit-decode
    //--------------------------------------------------------------------------
    //instr- from fetch stage
    cuif.instr = fdif.instr_out;  //add
    //--------------------------------------------------------------------------
    
    //2. register file -decode
    //--------------------------------------------------------------------------
    //rsel1
    rfif.rsel1= cuif.reg_rs;
    //rsel2
    rfif.rsel2 = cuif.reg_rt;
    //wen - happens in writeback stage
    rfif.WEN = mwif.RegWr_out; //&& (dpif.ihit || dpif.dhit);  //add
    
    //wsel - should get value in writeback stage
    if(deif.jal_s_out)  //add
      rd = 'b11111;
    else
      rd = deif.reg_rd_out; //add
    //wsel
    rfif.wsel = mwif.wsel_out;  //add

    if(deif.RegDst_out) //happens in execute stage
      emif.wsel_in= rd;  //going to execute mem pipeline
    else
      emif.wsel_in=deif.reg_rt_out; //going to execute mem pipeline
      
    //wdat
    if(mwif.lui_out)begin //add
      //luiwdat = {cuif.imm_addr,16'h0000};
      rfif.wdat = {mwif.imm_addr_out,16'h0000};end  //add
    else if (mwif.jal_s_out) //for jal  //add
      rfif.wdat=mwif.pcplusfour_out;  //add
    else if(mwif.MemtoReg_out)  //add
      rfif.wdat=mwif.wdat_out;  //add
    else
      rfif.wdat=mwif.alu_portOut_out; //add
    //--------------------------------------------------------------------------

    
   //3. idecode exec if ----add all signals in interfaces
    //-----------------------------------------------------------------------------------
    deif.dREN_in = cuif.dREN;
    deif.dWEN_in = cuif.dWEN;
    deif.bne_s_in =  cuif.bne_s;
    deif.beq_s_in = cuif.beq_s;
    deif.jal_s_in =cuif.jal_s;
    deif.jr_s_in = cuif.jr_s;
    deif.jump_s_in= cuif.jump_s;
    deif.lui_in = cuif.lui;
    deif.RegDst_in = cuif.RegDest;
    deif.ALUctr_in = cuif.ALUctr;
    deif.ALUopindecode = cuif.opcode;
    deif.ALUSrc_in = cuif.ALUSrc;
    deif.pcplusfour_in=fdif.pcplusfour_out;
    deif.instr_in = fdif.instr_out;
    deif.RegWr_out = cuif.RegWr;
    deif.MemWr_out = cuif.MemWr;
    deif.MemtoReg_out = cuif.MemtoReg;
    deif.halt_in = cuif.halt;
    deif.reg_rd_in=cuif.reg_rd;
    deif.imm_addr_in=cuif.imm_addr;
    deif.j_addr_in = cuif.j_addr;
    deif.shift_amt_in = cuif.shift_amt;
    deif.funct_in = cuif.funct;
    deif.rdat1_in = rfif.rdat1;
    deif.rdat2_in = rfif.rdat2;
    //-----------------------------------------------------------------------------------


    //execute stage
    //----------------------------------------------------------------------------------
    //alu
    //idecode exec if
    //exec mem if

    //memory stage
    //memeory request unit
    //exec mem if
    //mem writeback if

    //writeback stage
    //register file
    //mem writeback if

    
    // //ALU
    // //portA
    // aluif.portA = rfif.rdat1;
    // //signed ext
    // if(cuif.instr[15])    //checked
    //   SignExt_addr = {16'hffff,cuif.imm_addr};
    // else
    //   SignExt_addr = {16'h0000,cuif.imm_addr};
    // //zero ext
    // ZeroExt_addr = {16'h0000, cuif.imm_addr};
    
    // if (cuif.ExtOp)
    //   Ext_addr = SignExt_addr;
    // else
    //   Ext_addr = ZeroExt_addr;
    // //portB
    // if (cuif.ALUSrc)
    //   aluif.portB = Ext_addr;
    // else
    //   aluif.portB = rfif.rdat2;
    //   //if alu=0
    // //op
    // aluif.op =  cuif.ALUctr;
    
    
    
    
 

    // //RF
    //   //rsel1
    //   rfif.rsel1= cuif.reg_rs;
    //   //rsel2
    //   rfif.rsel2 = cuif.reg_rt;
    //   //wen
      
    //   rfif.WEN = cuif.RegWr && (dpif.ihit || dpif.dhit);
      

    //   //wsel
    //   if(cuif.jal_s)
    //     rd = 'hFFFFF;
    //   else
    //     rd = cuif.reg_rd;
    //   if(cuif.RegDst)
    //     rfif.wsel= rd;
    //   else
    //     rfif.wsel=cuif.reg_rt;
      
    //   //wdat
    //   if(cuif.lui)begin
    //     luiwdat = {cuif.imm_addr,16'h0000};
    //     rfif.wdat = {cuif.imm_addr,16'h0000};end
    //   else if (cuif.jal_s) //for jal
    //     rfif.wdat=pcif.pc + 4;
    //   else if(cuif.MemtoReg)
    //     rfif.wdat=dpif.dmemload;
    //   else
    //     rfif.wdat=aluif.portOut;
    //   //instr
    

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
