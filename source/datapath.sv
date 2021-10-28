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
`include "hazard_unit_if.vh"
`include "cpu_types_pkg.vh"
`include "forwarding_unit_if.vh"


module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
  );
  // import types
  import cpu_types_pkg::*;

  parameter PC_INIT=0;

  //logic dREN_from_mem,dWEN_from_mem;
  logic [31:0] SignExt_addr;
  //logic [31:0] luiwdat;
  logic [31:0] ZeroExt_addr;
  logic [31:0] Ext_addr;
  logic [31:0] npc;
  logic [31:0] shift_left_1;
  logic [31:0] extended_address;
  logic [4:0] rd;
  logic halt;
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
  hazard_unit_if huif();
  forwarding_unit_if fuif();

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
  hazard_unit hazard_unit (huif);
  forwarding_unit forwarding_unit (fuif);


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
   assign pcif.PCen = dpif.ihit & huif.PCWrite & (~dpif.halt);

  //1. fdif
  assign fdif.instr_in = huif.fdif_flush ? 'b0: dpif.imemload; //huif added
  assign fdif.pcplusfour_in = huif.fdif_flush ? 'b0: (pcif.pc + 4); //huif added
  assign fdif.pc_in = huif.fdif_flush ? 'b0 : pcif.pc; //huif added
  assign fdif.ihit = dpif.ihit;
  assign fdif.dhit = dpif.dhit;
  assign fdif.stall = huif.fdif_stall | ((emif.dREN_out| emif.dWEN_out) & ~dpif.dhit);

  
  //1/4.dp
  assign dpif.imemREN=1'b1 & (~dpif.halt);
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
  assign deif.dREN_in = huif.deif_flush ? 'b0: cuif.dREN;
  assign deif.dWEN_in = huif.deif_flush ? 'b0: cuif.dWEN;
  assign deif.instr_in = huif.deif_flush ? 'b0: fdif.instr_out;
  assign deif.pcplusfour_in= huif.deif_flush ? 'b0: fdif.pcplusfour_out;
  assign deif.rdat1_in =  huif.deif_flush ? 'b0: rfif.rdat1;
  assign deif.rdat2_in =  huif.deif_flush ? 'b0: rfif.rdat2;
  assign deif.jal_s_in =huif.deif_flush ? 'b0: cuif.jal_s;
  assign deif.jr_s_in = huif.deif_flush ? 'b0: cuif.jr_s;
  assign deif.jump_s_in= huif.deif_flush ? 'b0: cuif.jump_s;
  assign deif.bne_s_in = huif.deif_flush ? 'b0:  cuif.bne_s;
  assign deif.beq_s_in = huif.deif_flush ? 'b0: cuif.beq_s;
  assign deif.lui_in = huif.deif_flush ? 'b0: cuif.lui;
  assign deif.RegDst_in = huif.deif_flush ? 'b0: cuif.RegDst;
  assign deif.ALUctr_in = huif.deif_flush ? 'b0: cuif.ALUctr;
  assign deif.ALUSrc_in = huif.deif_flush ? 'b0: cuif.ALUSrc;
  assign deif.RegWr_in = huif.deif_flush ? 'b0: cuif.RegWr;
  assign deif.MemWr_in = huif.deif_flush ? 'b0: cuif.MemWr;
  assign deif.MemtoReg_in = huif.deif_flush ? 'b0: cuif.MemtoReg;
  assign deif.halt_in = huif.deif_flush ? 'b0: cuif.halt;
  assign deif.imm_addr_in=huif.deif_flush ? 'b0: cuif.imm_addr;
  assign deif.reg_rs_in = huif.deif_flush ? 'b0: cuif.reg_rs;
  assign deif.reg_rt_in = huif.deif_flush ? 'b0: cuif.reg_rt;
  assign deif.reg_rd_in=huif.deif_flush ? 'b0: cuif.reg_rd;
  assign deif.shift_amt_in = huif.deif_flush ? 'b0: cuif.shift_amt;
  assign deif.j_addr_in = huif.deif_flush ? 'b0: cuif.j_addr;
  assign deif.funct_in = huif.deif_flush ? funct_t'('b0): cuif.funct;
  assign deif.opcode_in = huif.deif_flush ? opcode_t'('b0): cuif.opcode;
  assign deif.pc_in =huif.deif_flush ? 'b0: fdif.pc_out;
  assign deif.ihit = dpif.ihit;
  assign deif.dhit = dpif.dhit;
  assign deif.stall = huif.deif_stall | ((emif.dREN_out | emif.dWEN_out) & ~dpif.dhit);

  //3.ALU
  assign aluif.portA = fuif.Asel? fuif.DataA : deif.rdat1_out;
  assign aluif.op =  deif.ALUctr_out;

  //3.execute/mem pipeline reg
  assign emif.dREN_in =huif.emif_flush ? 'b0:  deif.dREN_out;
  assign emif.dWEN_in = huif.emif_flush ? 'b0: deif.dWEN_out;
  assign emif.bne_s_in =  huif.emif_flush ? 'b0: deif.bne_s_out;
  assign emif.beq_s_in = huif.emif_flush ? 'b0: deif.beq_s_out;
  assign emif.jal_s_in =huif.emif_flush ? 'b0: deif.jal_s_out;
  assign emif.jr_s_in = huif.emif_flush ? 'b0: deif.jr_s_out;
  assign emif.jump_s_in= huif.emif_flush ? 'b0: deif.jump_s_out;
  assign emif.lui_in =huif.emif_flush ? 'b0:  deif.lui_out;
  assign emif.pcplusfour_in=huif.emif_flush ? 'b0: deif.pcplusfour_out;
  assign emif.pc_in =huif.emif_flush ? 'b0: deif.pc_out;
  assign emif.instr_in = huif.emif_flush ? 'b0: deif.instr_out;
  assign emif.RegWr_in = huif.emif_flush ? 'b0: deif.RegWr_out;
  assign emif.MemWr_in =huif.emif_flush ? 'b0:  deif.MemWr_out;
  assign emif.MemtoReg_in = huif.emif_flush ? 'b0: deif.MemtoReg_out;
  assign emif.halt_in = huif.emif_flush ? 'b0: deif.halt_out;
  assign emif.imm_addr_in=huif.emif_flush ? 'b0: deif.imm_addr_out;
  assign emif.j_addr_in = huif.emif_flush ? 'b0: deif.j_addr_out;   //add 
  assign emif.shift_amt_in = huif.emif_flush ? 'b0: deif.shift_amt_out;
  assign emif.reg_rs_in =huif.emif_flush ? 'b0: deif.reg_rs_out;
  assign emif.reg_rt_in =huif.emif_flush ? 'b0: deif.reg_rt_out;
  assign emif.reg_rd_in = emif.wsel_in;
  assign emif.opcode_in =huif.emif_flush ? opcode_t'('b0):  deif.opcode_out;
  assign emif.funct_in = huif.emif_flush ? funct_t'('b0): deif.funct_out; //funct in execute
  assign emif.flagZero_in = huif.emif_flush ? 'b0: aluif.flagZero;
  assign emif.rdat2_in = huif.emif_flush ? 'b0: deif.rdat2_out;
  assign emif.alu_portOut_in = huif.emif_flush ? 'b0: (deif.lui_out ? {deif.imm_addr_out,16'h0000} : aluif.portOut);
  assign emif.Ext_addr_in = huif.emif_flush ? 'b0: deif.Ext_addr_out;
  assign emif.rdat1_in = huif.emif_flush ? 'b0: deif.rdat1_out;
  assign emif.ihit = dpif.ihit;
  assign emif.dhit = dpif.dhit;
  assign emif.stall =((emif.dREN_out | emif.dWEN_out) & ~dpif.dhit);
  
  //mem/wrb stage 
  assign mwif.jal_s_in =mwif.flush  ? 'b0 :emif.jal_s_out;
  assign mwif.lui_in = mwif.flush  ? 'b0 : emif.lui_out;
  assign mwif.pcplusfour_in=mwif.flush  ? 'b0 : emif.pcplusfour_out;
  assign mwif.pc_in =mwif.flush  ? 'b0 : emif.pc_out;
  assign mwif.instr_in = mwif.flush  ? 'b0 : emif.instr_out;
  assign mwif.rdat2_in = mwif.flush  ? 'b0 : emif.rdat2_out;
  assign mwif.RegWr_in = mwif.flush  ? 'b0 : emif.RegWr_out;
  assign mwif.MemtoReg_in = mwif.flush  ? 'b0 : emif.MemtoReg_out;
  assign mwif.halt_in = mwif.flush  ? 'b0 : emif.halt_out;
  assign mwif.imm_addr_in=mwif.flush  ? 'b0 : emif.imm_addr_out;
  assign mwif.shift_amt_in = mwif.flush  ? 'b0 : emif.shift_amt_out;
  assign mwif.reg_rs_in =mwif.flush  ? 'b0 : emif.reg_rs_out;
  assign mwif.reg_rt_in =mwif.flush  ? 'b0 : emif.reg_rt_out;
  assign mwif.reg_rd_in = mwif.flush  ? 'b0 : emif.reg_rd_out;
  assign mwif.funct_in =mwif.flush  ?funct_t'('b0) :  emif.funct_out;
  assign mwif.opcode_in = mwif.flush  ? opcode_t'('b0): emif.opcode_out;
  assign mwif.wdat_in =mwif.flush  ? 'b0 :  dpif.dmemload;
  assign mwif.alu_portOut_in = mwif.flush  ? 'b0 : emif.alu_portOut_out;
  assign mwif.wsel_in= mwif.flush  ? 'b0 : emif.wsel_out;
  assign mwif.ihit = dpif.ihit;
  assign mwif.dhit = dpif.dhit;
  assign mwif.flush = ((emif.dREN_out| emif.dWEN_out) & ~dpif.dhit);

  //hu
  assign huif.emif_bneS = emif.bne_s_out ? (emif.flagZero_out=='b0 ? 'b1:'b0 ):'b0;
  assign huif.fdif_rs = cuif.reg_rs;
  assign huif.fdif_rt = cuif.reg_rt;
  assign huif.deif_rt = deif.reg_rt_out;
  assign huif.deif_MemtoReg = deif.MemtoReg_out;
  assign huif.deif_RegWr = deif.RegWr_out;
  assign huif.emif_rt =  emif.reg_rt_out;
  assign huif.emif_MemtoReg = emif.MemtoReg_out;
  assign huif.emif_RegWr = emif.RegWr_out;
  assign huif.deif_opcode = opcode_t'(deif.opcode_out);
  assign huif.emif_opcode = opcode_t'(emif.opcode_out);
  assign huif.deif_rd = deif.reg_rd_out;
  assign huif.emif_rd = emif.reg_rd_out;
  assign huif.decode_memWr = cuif.MemWr;

  //fu
  assign fuif.emif_RegWr = emif.RegWr_out;
  assign fuif.emif_rd = emif.wsel_out;
  assign fuif.deif_rs = deif.reg_rs_out;
  assign fuif.deif_rt = deif.reg_rt_out;
  assign fuif.emif_portout = emif.alu_portOut_out;
  assign fuif.mwif_RegWr = mwif.RegWr_out;
  assign fuif.mwif_rd = mwif.wsel_out;
  assign fuif.mwif_portout = mwif.alu_portOut_out;
  
  assign dpif.halt= halt | mwif.halt_out;

    
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
      deif.Ext_addr_in = huif.deif_flush ? 'b0: SignExt_addr;  //add both
    else
      deif.Ext_addr_in = huif.deif_flush ? 'b0: ZeroExt_addr; 
  end
    //---------------------------------------------------


    //2.2 pc_next-> branch, jal, jr, jump in mem and normal cases in fetch
    //------------------------------------------------------------
  always_comb begin
    npc=32'b0;
    shift_left_1=32'b0;
    extended_address=32'b0;
    huif.emif_beqS=0;
    huif.emif_jalS=0;
    huif.emif_jrS=0;
    huif.emif_jS=0;

    if(emif.jal_s_out || emif.jump_s_out) 
    begin //add both
      extended_address =  {emif.pcplusfour_out[31:28],emif.instr_out[25:0],2'b00}; //add
      pcif.pc_next =  extended_address;
      huif.emif_jalS =emif.jal_s_out;
      huif.emif_jS = emif.jump_s_out;
      end

    //for branch  mem stage
    else if (emif.bne_s_out)
    begin //add
      if(!emif.flagZero_out)
      begin //add
        npc = emif.pcplusfour_out; //add
        shift_left_1={emif.Ext_addr_out[29:0],2'b00}; //add
        pcif.pc_next = npc +shift_left_1;
        //huif.emif_bneS=emif.bne_s_out && ~(emif.flagZero_out); 
        end
      else 
        pcif.pc_next=pcif.pc+ 4; 
      end
    //for branch equal in mem stage
    else if (emif.beq_s_out)
    begin //add
      if(emif.flagZero_out)
      begin //add
        npc = emif.pcplusfour_out; //add 
        shift_left_1={emif.Ext_addr_out[29:0],2'b00}; //add
        pcif.pc_next = npc +shift_left_1;
        end
       
      else 
        pcif.pc_next=pcif.pc + 4;
      end
    else if (emif.jr_s_out) 
    begin
      pcif.pc_next = emif.rdat1_out;
      huif.emif_jrS = 1;   
      end
    else 
      pcif.pc_next= pcif.pc + 4;
      huif.emif_beqS = emif.beq_s_out  && emif.flagZero_out;
  end
    //------------------------------------------------------

    //2.rfif
    
    //wdat
  always_comb begin
    // if(mwif.lui_out)begin 
    //   rfif.wdat = {mwif.imm_addr_out,16'h0000};end  
    if (mwif.jal_s_out) 
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
    else if(fuif.Bsel)
      aluif.portB = fuif.DataB;
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
      emif.wsel_in= huif.emif_flush ? 'b0: rd;  //going to execute mem pipeline
    else
      emif.wsel_in= huif.emif_flush ? 'b0: deif.reg_rt_out; //going to execute mem pipeline
  end

  always_ff @(posedge CLK or negedge nRST) begin
    if(!nRST)
      halt <= 1'b0;
    else
      halt <= halt | mwif.halt_out;
      if(halt == 1) halt <= halt;
  end
endmodule