//make clean - command helps  clean prev make commands
`include "cpu_types_pkg.vh"
`include "register_file_if.vh"

//initialise module
module register_file(
    input CLK,
    input nRST,
    register_file_if.rf rfif
 );

//variables
import cpu_types_pkg::*;
word_t [31:0] regfile;
word_t [31:0] regfile_next;
//word_t [31:0] halt_reg;
//word_t [31:0] halt_reg_next;

//assign wires
assign rfif.rdat1=regfile[rfif.rsel1];
assign rfif.rdat2=regfile[rfif.rsel2];

//halt <= halt_next

//halt_next = cuif.halt | halt;

//comb block
always_ff @ (posedge CLK)
begin
    //if reset ON make registerfile values  0
    if (!nRST)
        regfile<='b0;
    else if (rfif.WEN)
        regfile<=regfile_next;

end
//to make wen synchrounous with register writing add an extra regfile
always_comb begin
    regfile_next=regfile;
    if(nRST && rfif.WEN && rfif.wsel=='b0)
        regfile_next[0]='b0;
    else if (nRST && rfif.WEN)
        regfile_next[rfif.wsel]= rfif.wdat;
end



endmodule
