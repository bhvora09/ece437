`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"

module control_unit (
    control_unit_if.cu cuif
);
  // type import
import cpu_types_pkg::*;

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
    //cuif.PCen = 'b1;
    //cuif.PCsrc='b00;
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
    //cuif.iREN='b1;
    cuif.halt='b0;
    cuif.beq_s='b0;
    cuif.bne_s='b0;
    cuif.jump_s='b0;
    cuif.jr_s='b0;
    cuif.lui='b0;
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
                cuif.jr_s='b1;
                //cuif.PCsrc=2'b11;
                 end// alu wont matter;
            ADD:cuif.ALUctr = ALU_ADD; // add sign extender??
            ADDU:cuif.ALUctr = ALU_ADD;
            SUB:cuif.ALUctr = ALU_SUB;
            SUBU:cuif.ALUctr = ALU_SUB;
            AND:cuif.ALUctr = ALU_AND;
            OR:cuif.ALUctr = ALU_OR;
            XOR:cuif.ALUctr = ALU_XOR;
            NOR:cuif.ALUctr = ALU_NOR;
            SLT:cuif.ALUctr=ALU_SLT;
            SLTU:cuif.ALUctr=ALU_SLTU; 
        endcase
        end
    J:  begin
        //cuif.PCsrc= 'b10;
        cuif.RegWr='b0;
        cuif.MemWr='b0;
        cuif.jump_s='b1;
        end
    JAL: begin
        //ask in lab
        //cuif.PCsrc= 'b10; //??
        cuif.RegWr='b1;
        cuif.MemWr='b0;
        cuif.jal_s='b1;
        cuif.RegDst='b1;end
    //JR: 
      //  cuif.PCsrc= 'b11;
    BEQ: begin
        //if(aluif.flagZero)
          //  cuif.PCsrc='b01;
        //else cuif.PCsrc='b00;
        cuif.beq_s='b1;
        cuif.RegWr='b0;
        cuif.RegDst='b0;
        cuif.ALUSrc='b0;
        cuif.ALUctr=ALU_SUB;
        cuif.MemWr='b0;
        cuif.ExtOp='b1;
         end
    BNE:  begin
        //if(aluif.flagZero)
          //  cuif.PCsrc='b00;
        //else cuif.PCsrc='b01;
        //cuif.PCsrc='b01;
        cuif.bne_s='b1;
        cuif.RegWr='b0;
        cuif.RegDst='b0;
        cuif.ALUSrc='b0;
        cuif.ALUctr=ALU_SUB;
        cuif.MemWr='b0;
        cuif.ExtOp='b1;
    end
    ADDI: begin
        //cuif.PCsrc= 'b00;
        cuif.RegWr='b1;
        cuif.RegDst='b0;
        cuif.ExtOp='b1; //signed
        cuif.ALUSrc='b1;
        cuif.ALUctr= ALU_ADD;
        cuif.MemWr='b0;
        cuif.MemtoReg='b0;
    end
    ADDIU: begin
        //cuif.PCsrc= 'b00;
        cuif.RegWr='b1;
        cuif.RegDst='b0;
        cuif.ExtOp='b1; //unsigned - zero extension
        cuif.ALUSrc='b1;
        cuif.ALUctr= ALU_ADD;
        cuif.MemWr='b0;
        cuif.MemtoReg='b0;
    end
    SLTI:begin
        //cuif.PCsrc= 'b00;
        cuif.RegWr='b1;
        cuif.RegDst='b0;
        cuif.ExtOp='b1; //signed ..??
        cuif.ALUSrc='b1;
        cuif.ALUctr= ALU_SLT;
        cuif.MemWr='b0;
        cuif.MemtoReg='b0;
    end
    SLTIU:begin
        //cuif.PCsrc= 'b00;
        cuif.RegWr='b1;
        cuif.RegDst='b0;
        cuif.ExtOp='b1; //signed ..??
        cuif.ALUSrc='b1;
        cuif.ALUctr= ALU_SLTU;
        cuif.MemWr='b0;
        cuif.MemtoReg='b0;
    end
    ANDI:begin
        //cuif.PCsrc= 'b00;
        cuif.RegWr='b1;
        cuif.RegDst='b0;
        cuif.ExtOp='b0; //signed ..??
        cuif.ALUSrc='b1;
        cuif.ALUctr= ALU_AND;
        cuif.MemWr='b0;
        cuif.MemtoReg='b0;
    end
    ORI:begin
        //cuif.PCsrc= 'b00;
        cuif.RegWr='b1;
        cuif.RegDst='b0;
        cuif.ExtOp='b0; //signed ..??
        cuif.ALUSrc='b1;
        cuif.ALUctr= ALU_OR;
        cuif.MemWr='b0;
        cuif.MemtoReg='b0;
    end
    XORI:begin
        //cuif.PCsrc= 'b00;
        cuif.RegWr='b1;
        cuif.RegDst='b0;
        cuif.ExtOp='b0; //signed ..??
        cuif.ALUSrc='b1;
        cuif.ALUctr= ALU_XOR;
        cuif.MemWr='b0;
        cuif.MemtoReg='b0;
    end
    LUI:begin
        cuif.RegDst='b0;
        cuif.RegWr='b1;
        //cuif.ExtOp='b0;
        cuif.lui='b1;
    end
    LW:begin
        //cuif.PCsrc= 'b00;
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
        //cuif.PCsrc= 'b00;
        cuif.RegWr='b0;
        cuif.ExtOp='b1; //signed ..??
        cuif.ALUSrc='b1;
        cuif.ALUctr= ALU_ADD;
        cuif.MemWr='b1;
        //cuif.PCen='b0;
        cuif.dWEN='b1;
        //cuif.iREN='b0;
        end
    
    HALT: begin
        //cuif.PCen='b0;
        cuif.halt='b1;
        //sysif.halt = 'b1;
        end

    endcase
  end
endmodule
