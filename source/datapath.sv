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
// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"
//`include "system_if.vh"
//initialise module
module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
  );
  // import types
  import cpu_types_pkg::*;
  parameter PC_INIT=0;
  opcode_t [5:0] opcode;
  regbits_t [4:0] reg_rs;
  regbits_t [4:0] reg_rt;
  regbits_t [4:0] reg_rd;
  funct_t [5:0] funct;
  //parameter IMM_W     = 16;
  logic [15:0] imm_addr;
  logic [25:0] j_addr;
  logic [4:0] shift_amt;
  logic [31:0] SignExt_addr;
  logic [31:0] ZeroExt_addr;
  logic [31:0] Ext_addr;
  logic [31:0] npc;
  logic [31:0] shift_left_1;
  logic [31:0] extended_address;
  logic [31:0] rd;

  // pc initialisation
  //parameter PC = 0;

  //interfaces initialised as functions
  alu_if aluif();
  control_unit_if cuif();
  memory_request_unit_if mruif();
  program_counter_if pcif();
  register_file_if rfif();
  //system_if sysif();

  //adding all units in the datapath
  alu ALU(aluif);
  control_unit CU(cuif);
  memory_request_unit MRU(CLK,nRST,mruif);
  program_counter PC(CLK,nRST,pcif);
  register_file RF(CLK,nRST,rfif);
  //system SYS(CLK,nRST,sysif);
  
  assign opcode=cuif.instr[31:26];
  assign reg_rs=cuif.instr[25:21];
  assign reg_rt =cuif.instr[20:16];
  assign reg_rd =cuif.instr[15:11];
  assign imm_addr=cuif.instr[15:0];
  assign j_addr  = cuif.instr[25:0];
  assign shift_amt= cuif.instr[10:6];
  assign funct =  cuif.instr [5:0];
  
  always_comb begin
    //DP
    dpif.imemaddr=pcif.pc;
    dpif.dmemWEN=mruif.dwen;
    dpif.halt=cuif.halt;
    dpif.imemREN=mruif.iren;
    dpif.dmemREN=mruif.dren;
    dpif.dmemstore=rfif.rdat2;
    dpif.dmemaddr=aluif.portOut;
    //ALU
    //portA
    aluif.portA = rfif.rdat1;
    //signed ext
    if(cuif.instr[15])
      SignExt_addr = {16'hffff,imm_addr};
    else
      SignExt_addr = {16'h0000,imm_addr};
    //zero ext
      ZeroExt_addr = {16'h0000, imm_addr};
    if (cuif.ExtOp)
      Ext_addr = SignExt_addr;
    else
      Ext_addr = ZeroExt_addr;
    //portB
    if (cuif.ALUSrc)
      aluif.portB = Ext_addr;
    else
      aluif.portB = rfif.rdat2;

    

    //op
    aluif.op =  cuif.ALUctr;
    
    //CU
      //instr
    cuif.instr = dpif.imemload;
    //MRU
      //dren
    mruif.dren = cuif.dREN; 
      //dwen
    mruif.dwen = cuif.dWEN;
      //dhit
    mruif.dhit = dpif.dhit;
      //ihit
    mruif.dhit = dpif.ihit;
    
    //PC
      //pc_next
    //if(cuif.PCen) begin
    pcif.PCen=cuif.PCen;
    case(cuif.PCsrc)
      2'b00: pcif.pc_next= pcif.pc + 4;
      2'b01: begin
        npc = pcif.pc +4; 
        shift_left_1=Ext_addr << 2;
        pcif.pc_next = npc +shift_left_1;
      end
      2'b10:begin
        extended_address =  {6'b000000,j_addr};
        pcif.pc_next =  extended_address;
      end
      2'b11:pcif.pc_next = rfif.rdat1;
      endcase
    //end

    //RF
      //rsel1
      rfif.rsel1= reg_rs;
      //rsel2
      rfif.rsel2 = reg_rt;
      //wen
      rfif.WEN = cuif.RegWr;
      //wsel
      if(cuif.jal_s)
        rd = 'hFFFFF;
      else
        rd = reg_rd;
      if(cuif.RegDst)
        rfif.wsel= rd;
      else
        rfif.wsel=reg_rt;
      
      //wdat
      if(cuif.MemtoReg)
        rfif.wdat=aluif.portOut;
      else if (cuif.jal_s)
        rfif.wdat=pcif.pc + 4;
      else
        rfif.wdat=dpif.dmemstore;
      //instr
    

    //
    
  end






endmodule
