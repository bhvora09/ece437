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

    //ADD LOGIC FOR STALL
    stall = ;

    //aluif.portA='b0;
    //aluif.portB='b0;

    //fetch stage-> dp pc(clk) mru
    //dp
    //DP
    dpif.imemaddr=pcif.pc;
    dpif.dmemWEN=mruif.dmemWEN;
    dpif.imemREN=mruif.imemREN;
    //read happens in mem stage
    dpif.dmemREN=mruif.dmemREN;
    //dpif.dmemstore=rfif.rdat2;
    dpif.dmemstore=mem_wrb_if.rdat2_from_reg;
    //dpif.dmemaddr=aluif.portOut;
    dpif.dmemaddr=mem_wrb_if.alu_portOut_out;
    //pc
    //pcen
    pcif.PCen = dpif.ihit && (~dpif.dhit);
    
    
    //sign extender  in decode stage
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


    //pc_next-> branch, jal, jr, jump in mem and normal cases in fetch
    //------------------------------------------------------------
    if(mwif.jal_s || mwif.jump_s) begin
      extended_address =  {pcplusfour_in [31:28],dpif.imemload[25:0],2'b00};
      pcif.pc_next =  extended_address;end
    //for branch --done-- mem stage
    else if (emif.bne_s_out)begin //add
      if(!emif.flagZero_out)begin //add
        npc = emif.pcplusfour_out; //add
        shift_left_1={emif.Ext_addr_out[29:0],2'b00}; //add
        pcif.pc_next = npc +shift_left_1;end
      else pcif.pc_next=pcif.pc+ 4; 
      end
    else if (emif.beq_s_out)begin //add
      if(emif.flagZero_out)begin //add
        npc = emif.pcplusfour_out; //add 
        shift_left_1={emif.Ext_addr_out[29:0],2'b00}; //add
        pcif.pc_next = npc +shift_left_1;end
      else pcif.pc_next=pcif.pc + 4;
        end
    else if (emif.jr_s_out)
      //pcif.pc_next = rfif.rdat1;
      pcif.pc_next = deif.rdat1_out;   //add
    else 
      pcif.pc_next= pcif.pc + 4;
    //------------------------------------------------------
    //memory request unit

    //ifetch idecode if
    fdif.instr_in = instr;
    fdif.pc = pc;
    fdif.nxt_pc_in = pc_next;
    fdif.stall = stall;
    fdif.lui_s_in = cuif.lui_s;
    fdif.jal_s_in = cuif.jal_s;
    fdif.jr_s_in = cuif.jr_s;
    fdif.j_s_in = cuif.j_s;
    fdif.ihit_in = dpif.ihit;
    fdif.dhit_in = dpif.dhit;
    fdif.jal_addr_in = instr[25:0];
    fdif.jr_addr_in = instr[25:0];
    fdif.j_addr_in = instr[25:0];
    fdif.branch_addr_in = [15:0];


    //decode stage
    //control unit
    //register file
    //ifecth idecode if
    //idecode exec if

    //execute stage
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
    
    // //CU
    //   //instr
    // cuif.instr = dpif.imemload;
    // //MRU
    // mruif.iren=cuif.iREN;
    //   //dren
    // mruif.dren = cuif.dREN; 
    //   //dwen
    // mruif.dwen = cuif.dWEN;
    //   //dhit
    // mruif.dhit = dpif.dhit;
    //   //ihit
    // mruif.ihit = dpif.ihit;
    
    /    

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
