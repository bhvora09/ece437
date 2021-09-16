`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"
//`include "system_if.vh"
module control_unit (
    
    control_unit_if.cu cuif
    //system_if.sys sysif
  
);
  // type import
  import cpu_types_pkg::*;
  //r_t rtypeinstr;
  //i_t itypeintru;
  //j_t jtypeinstr;
  //word_t instrO;
  //opcode_t opcode;
  //regbits_t reg_rs;
//   regbits_t  reg_rt;
//   regbits_t reg_rd;
//   funct_t funct;
  //aluop_t ALUctr;
//   parameter imm_w = 16;
//   parameter addr_w = 26;
//   parameter alu_op_w = 4;
//   parameter sham_w = 5;
  
//   logic [imm_w-1:0] imm_addr;
//   logic [addr_w-1:0] j_addr;
//   logic [sham_w-1:0] shift_amt;
  //ramstate_t ramstate;
  //parameter CPUS = 1;
    //assign instrO = word_t'(cuif.instr[31:0]);
    assign cuif.opcode=opcode_t'(cuif.instr[31:26]);
    assign cuif.reg_rs=regbits_t'(cuif.instr[25:21]);
    assign cuif.reg_rt =regbits_t'(cuif.instr[20:16]);
    assign cuif.reg_rd =regbits_t'(cuif.instr[15:11]);
    assign cuif.imm_addr=cuif.instr[15:0];
    assign cuif.j_addr  = cuif.instr[25:0];
    assign cuif.shift_amt= cuif.instr[10:6];
    assign cuif.funct = funct_t'(cuif.instr[5:0]);

 
  always_comb begin
    //sysif.halt='b0;
    cuif.PCen = 'b1;
    cuif.PCsrc='b00;
    cuif.RegDst='b0;
    cuif.RegWr='b0;
    cuif.ALUctr=ALU_ADD;
    cuif.MemWr='b0;
    cuif.MemtoReg='b0;
    cuif.ExtOp='b0;
    cuif.ALUSrc='b0;
    cuif.jal_s='b0;
    cuif.dREN='b0;
    cuif.dWEN='b0;
    cuif.iREN='b1;
    cuif.halt='b0;
    case(cuif.opcode)
    RTYPE:begin
        cuif.RegWr='b1;
        cuif.RegDst='b1;
        cuif.ExtOp='b0;
        cuif.ALUSrc='b0;
        cuif.jal_s='b0;
        cuif.MemWr='b0;
        cuif.MemtoReg='b0;
        //cuif.jump='b0; 
        case (cuif.funct) 
            SLLV:cuif.ALUctr = ALU_SLL;
            SRLV: cuif.ALUctr = ALU_SRL;
            JR: begin 
                cuif.ALUctr = ALU_ADD; 
                cuif.PCsrc=2'b11; end// alu wont matter;
            ADD:cuif.ALUctr = ALU_ADD; // add sign extender??
            ADDU:cuif.ALUctr = ALU_ADD;
            SUB:cuif.ALUctr = ALU_SUB;
            SUBU:cuif.ALUctr = ALU_SUB;
            AND:cuif.ALUctr = ALU_AND;
            OR:cuif.ALUctr = ALU_OR;
            XOR:cuif.ALUctr = ALU_XOR;
            NOR:cuif.ALUctr = ALU_NOR;
        endcase
        end
    J:  begin
        cuif.PCsrc= 'b10;
        cuif.RegWr='b0;
        cuif.MemWr='b0;
        end
    JAL: begin
        //ask in lab
        cuif.PCsrc= 'b10; //??
        cuif.RegWr='b1;
        cuif.MemWr='b0;
        cuif.jal_s='b1;
        cuif.RegDst='b1;end
    //JR: 
      //  cuif.PCsrc= 'b11;
    BEQ: begin
        cuif.PCsrc='b01;
        cuif.RegWr='b0;
        cuif.RegDst='b0;
        cuif.ALUSrc='b0;
        cuif.ALUctr=ALU_SUB;
        cuif.MemWr='b0;
         end
    BNE:  begin
        cuif.PCsrc='b01;
        cuif.RegWr='b0;
        cuif.RegDst='b0;
        cuif.ALUSrc='b0;
        cuif.ALUctr=ALU_SUB;
        cuif.MemWr='b0;
    end
    ADDI: begin
        cuif.PCsrc= 'b00;
        cuif.RegWr='b1;
        cuif.RegDst='b0;
        cuif.ExtOp='b1; //signed
        cuif.ALUSrc='b1;
        cuif.ALUctr= ALU_ADD;
        cuif.MemWr='b0;
        cuif.MemtoReg='b0;
    end
    ADDIU: begin
        cuif.PCsrc= 'b00;
        cuif.RegWr='b1;
        cuif.RegDst='b0;
        cuif.ExtOp='b1; //unsigned - zero extension
        cuif.ALUSrc='b1;
        cuif.ALUctr= ALU_ADD;
        cuif.MemWr='b0;
        cuif.MemtoReg='b0;
    end
    SLTI:begin
        cuif.PCsrc= 'b00;
        cuif.RegWr='b1;
        cuif.RegDst='b0;
        cuif.ExtOp='b1; //signed ..??
        cuif.ALUSrc='b1;
        cuif.ALUctr= ALU_SLT;
        cuif.MemWr='b0;
        cuif.MemtoReg='b0;
    end
    SLTIU:begin
        cuif.PCsrc= 'b00;
        cuif.RegWr='b1;
        cuif.RegDst='b0;
        cuif.ExtOp='b1; //signed ..??
        cuif.ALUSrc='b1;
        cuif.ALUctr= ALU_SLTU;
        cuif.MemWr='b0;
        cuif.MemtoReg='b0;
    end
    ANDI:begin
        cuif.PCsrc= 'b00;
        cuif.RegWr='b1;
        cuif.RegDst='b0;
        cuif.ExtOp='b0; //signed ..??
        cuif.ALUSrc='b1;
        cuif.ALUctr= ALU_AND;
        cuif.MemWr='b0;
        cuif.MemtoReg='b0;
    end
    ORI:begin
        cuif.PCsrc= 'b00;
        cuif.RegWr='b1;
        cuif.RegDst='b0;
        cuif.ExtOp='b0; //signed ..??
        cuif.ALUSrc='b1;
        cuif.ALUctr= ALU_OR;
        cuif.MemWr='b0;
        cuif.MemtoReg='b0;
    end
    XORI:begin
        cuif.PCsrc= 'b00;
        cuif.RegWr='b1;
        cuif.RegDst='b0;
        cuif.ExtOp='b0; //signed ..??
        cuif.ALUSrc='b1;
        cuif.ALUctr= ALU_XOR;
        cuif.MemWr='b0;
        cuif.MemtoReg='b0;
    end
    LW:begin
        cuif.PCsrc= 'b00;
        cuif.RegWr='b1;
        cuif.RegDst='b0;
        cuif.ExtOp='b1; //signed ..??
        cuif.ALUSrc='b1;
        cuif.ALUctr= ALU_ADD;
        cuif.MemWr='b0;
        cuif.MemtoReg='b1;
        //cuif.PCen='b0;
        cuif.dREN='b1;
        //cuif.iREN='b0;
    end
    SW:  begin
        cuif.PCsrc= 'b00;
        cuif.RegWr='b0;
        cuif.ExtOp='b1; //signed ..??
        cuif.ALUSrc='b1;
        cuif.ALUctr= ALU_ADD;
        cuif.MemWr='b0;
        //cuif.PCen='b0;
        cuif.dWEN='b1;
        //cuif.iREN='b0;
        end
    HALT: begin
        cuif.PCen='b0;
        cuif.halt='b1;
        //sysif.halt = 'b1;
        end

    endcase
  end
endmodule
