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

//assign wires
assign rfif.rdat1=regfile[rfif.rsel1];
assign rfif.rdat2=regfile[rfif.rsel2];


//comb block
//keeping wdat ready by next clock cycle
always_comb begin
    if(!nRST) 
        regfile_next='b0;
    else begin
        regfile_next=regfile;
        if(rfif.wsel=='b0)
            regfile_next[0]='b0;
        else if (rfif.wsel != 'b0)
            regfile_next[rfif.wsel]= rfif.wdat;
    end
end
//write at next clock cycle
always_ff @ (negedge CLK or negedge nRST)
begin
    if (!nRST)
        regfile='b0;
    else if (rfif.WEN)
        regfile<=regfile_next;
   
end

endmodule