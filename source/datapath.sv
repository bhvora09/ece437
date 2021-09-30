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


module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
  );
  // import types
  import cpu_types_pkg::*;

  parameter PC_INIT=0;

  logic [31:0] SignExt_addr;
  //logic [31:0] luiwdat;
  logic [31:0] ZeroExt_addr;
  logic [31:0] Ext_addr;
  logic [31:0] npc;
  logic [31:0] shift_left_1;
  logic [31:0] extended_address;
  logic [4:0] rd;
  //logic [31:0] instr;
  //logic  stall;

  //interfaces initialised as functions
  alu_if aluif();
  control_unit_if cuif();
  //memory_request_unit_if mruif();
  program_counter_if pcif();
  register_file_if rfif();
  ifetch_idecode_if fdif();
  idecode_iexec_if deif();
  exec_mem_if emif();
  mem_wrb_if mwif();

  //adding all units in the datapath
  alu ALU(aluif);
  control_unit CU(cuif);
  //memory_request_unit MRU(CLK,nRST,mruif);
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

  aluop_t aluopinfetch;
  aluop_t aluopindecode;
  aluop_t aluopinexec;
  aluop_t aluopinmem;
  aluop_t aluopinwrback;

  assign aluopinfetch = aluop_t'(fdif.instr_in[5:0]);
  assign aluopindecode = aluop_t'(deif.instr_in[5:0]);
  assign aluopinexec = aluop_t'(emif.instr_in[5:0]);
  assign aluopinmem = aluop_t'(mwif.instr_in[5:0]);
  assign aluopinwrback = aluop_t'(mwif.instr_out[5:0]);

  //1.pc
  assign pcif.PCen = dpif.ihit;

  //1. fdif
  assign fdif.instr_in = dpif.imemload; //add
  assign fdif.pcplusfour_in = pcif.pc + 4; //add
  assign fdif.pc_in = pcif.pc;
  assign fdif.ihit = dpif.ihit;
  assign fdif.dhit = dpif.dhit;

  //1/4.dp
  assign dpif.imemREN=1'b1;
  assign dpif.imemaddr=pcif.pc;

  assign dpif.dmemWEN=emif.dWEN_out;
  assign dpif.dmemREN=emif.dREN_out;
  assign dpif.dmemstore=emif.rdat2_out;
  assign dpif.dmemaddr=emif.alu_portOut_out;

  //2.cu
  assign cuif.instr = fdif.instr_out;

  //2. rfif
  assign rfif.rsel1= cuif.reg_rs;
  assign rfif.rsel2 = cuif.reg_rt;
  assign rfif.WEN = mwif.RegWr_out; //&& (dpif.ihit || dpif.dhit);  //add
  assign rfif.wsel = mwif.wsel_out; 

  //2.deif
  assign deif.dREN_in = cuif.dREN;
  assign deif.dWEN_in = cuif.dWEN;
  assign deif.bne_s_in =  cuif.bne_s;
  assign deif.beq_s_in = cuif.beq_s;
  assign deif.jal_s_in =cuif.jal_s;
  assign deif.jr_s_in = cuif.jr_s;
  assign deif.jump_s_in= cuif.jump_s;
  assign deif.lui_in = cuif.lui;
  assign deif.RegDst_in = cuif.RegDst;
  assign deif.ALUctr_in = cuif.ALUctr;
  assign deif.ALUSrc_in = cuif.ALUSrc;
  assign deif.pcplusfour_in=fdif.pcplusfour_out;
  assign deif.instr_in = fdif.instr_out;
  assign deif.RegWr_in = cuif.RegWr;
  assign deif.MemWr_in = cuif.MemWr;
  assign deif.MemtoReg_in = cuif.MemtoReg;
  assign deif.halt_in = cuif.halt;
  assign deif.reg_rd_in=cuif.reg_rd;
  assign deif.imm_addr_in=cuif.imm_addr;
  assign deif.j_addr_in = cuif.j_addr;
  assign deif.shift_amt_in = cuif.shift_amt;
  assign deif.funct_in = cuif.funct;
  assign deif.rdat1_in = rfif.rdat1;
  assign deif.rdat2_in = rfif.rdat2;
  assign deif.reg_rt_in = cuif.reg_rt;
  assign deif.ihit = dpif.ihit;
  assign deif.dhit = dpif.dhit;

  //3.ALU
  assign aluif.portA = deif.rdat1_out;
  assign aluif.op =  deif.ALUctr_out;

  //3.execute/mem pipeline reg
  assign emif.dREN_in = deif.dREN_out;
  assign emif.dWEN_in = deif.dWEN_out;
  assign emif.bne_s_in =  deif.bne_s_out;
  assign emif.beq_s_in = deif.beq_s_out;
  assign emif.jal_s_in =deif.jal_s_out;
  assign emif.jr_s_in = deif.jr_s_out;
  assign emif.jump_s_in= deif.jump_s_out;
  assign emif.lui_in = deif.lui_out;

  assign emif.pcplusfour_in=deif.pcplusfour_out;
  assign emif.instr_in = deif.instr_out;
  assign emif.RegWr_in = deif.RegWr_out;
  assign emif.MemWr_in = deif.MemWr_out;
  assign emif.MemtoReg_in = deif.MemtoReg_out;
  assign emif.halt_in = deif.halt_out;
    
  assign emif.imm_addr_in=deif.imm_addr_out;
  assign emif.j_addr_in = deif.j_addr_out;   //add 
  assign emif.shift_amt_in = deif.shift_amt_out;
  assign emif.funct_in = deif.funct_out; //funct in execute
    
  assign emif.flagZero_in = aluif.flagZero;
  assign emif.rdat2_in = deif.rdat2_out;
  assign emif.alu_portOut_in = aluif.portOut;
  assign emif.Ext_addr_in = deif.Ext_addr_out;
  assign emif.rdat1_in = deif.rdat1_out;

  assign emif.ihit = dpif.ihit;
  assign emif.dhit = dpif.dhit;
  
  //mem/wrb stage 
  assign mwif.jal_s_in =emif.jal_s_out;
  assign mwif.lui_in = emif.lui_out;
    
  assign mwif.pcplusfour_in=emif.pcplusfour_out;
  assign mwif.instr_in = emif.instr_out;
  assign mwif.RegWr_in = emif.RegWr_out;
  assign mwif.MemtoReg_in = emif.MemtoReg_out;
  assign mwif.halt_in = emif.halt_out;
  assign mwif.imm_addr_in=emif.imm_addr_out;
  assign mwif.shift_amt_in = emif.shift_amt_out;
  assign mwif.funct_in = emif.funct_out;
  assign mwif.wdat_in = dpif.dmemload;
  assign mwif.alu_portOut_in = emif.alu_portOut_out;
  assign mwif.wsel_in= emif.wsel_out;
  
  assign mwif.ihit = dpif.ihit;
  assign mwif.dhit = dpif.dhit;

  //mru
    // if (dpif.dhit) begin
    //     //$display("dhit");
    //     dpif.dmemREN<=1'b0;
    //     dpif.dmemWEN<=1'b0;
    //   end
    // else if (dpif.ihit) begin
    //   dpif.dmemREN<=emif.dREN_out;
    //   dpif.dmemWEN<=emif.dWEN_out;
    //   end

    
    //2.2 sign extender in decode stage
    //--------------------------------------------
  always_comb begin
    SignExt_addr=32'b0;
    Ext_addr=32'h0;
    ZeroExt_addr=32'h0;
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
  end
    //---------------------------------------------------


    //2.2 pc_next-> branch, jal, jr, jump in mem and normal cases in fetch
    //------------------------------------------------------------
  always_comb begin
    npc=32'b0;
    shift_left_1=32'b0;
    extended_address=32'b0;
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
      pcif.pc_next = emif.rdat1_out;   //add
    else 
      pcif.pc_next= pcif.pc + 4;
  end
    //------------------------------------------------------

    // 3. Memory Request Unit
    //---------------------------------------------------------
    //mruif.iren=1'b1; //always 1???
      
    //mruif.dren = emif.dREN_out; //add 
      
    //mruif.dwen = emif.dWEN_out; //add
  
    //mruif.dhit = dpif.dhit; //add
     
    //mruif.ihit = dpif.ihit; //not sure about ihit
 
    
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
    
    

    //2.rfif
    
    //wdat
  always_comb begin
    if(mwif.lui_out)begin 
      rfif.wdat = {mwif.imm_addr_out,16'h0000};end  
    else if (mwif.jal_s_out) 
      rfif.wdat=mwif.pcplusfour_out;  
    else if(mwif.MemtoReg_out)  
      rfif.wdat=mwif.wdat_out;  
    else
      rfif.wdat=mwif.alu_portOut_out; 
  end



    //portB
  always_comb begin
    if (deif.ALUSrc_out)
      aluif.portB = deif.Ext_addr_out;  //add
    else
      aluif.portB = deif.rdat2_out;     //add
  end      
    
    //wsel - should get value in writeback stage
  always_comb begin
    rd = 'b0;
    if(deif.jal_s_out)  //add
      rd = 'b11111;
    else
      rd = deif.reg_rd_out; //add
    if(deif.RegDst_out) //happens in execute stage
      emif.wsel_in= rd;  //going to execute mem pipeline
    else
      emif.wsel_in=deif.reg_rt_out; //going to execute mem pipeline
  end
    
  always_ff @(posedge CLK or negedge nRST) begin
     if(!nRST)
       dpif.halt<='b0;
      //dpif.halt<=cuif.halt || (nRST);
     else if (mwif.halt_out)
      dpif.halt<=mwif.halt_out;
      //dpif.halt<=(~cuif.halt) || (nRST && cuif.halt);
      
  end
endmodule
