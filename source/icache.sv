`include "datapath_cache_if"
`include "cache_control_if"
`include "cpu_types_pkg.vh"

module icache(
    input CLK, nRST,
    cache_control_if.cc ccif,
    datapath_cache_if.icache dcif
);

logic hit;
word_t data;
icachef_t addr;
icache_frame [15:0] frames;
icache_frame frame;
logic valid;
logic iwait;

//Datapath Signals
assign valid = dcif.iRen;
assign addr = icachef_t' dcif.iaddr
assign dcif.ihit = hit;
assign dcif.inst = data;

//CacheControl Signals
//iRen and iaddr not included
assign iwait = ccif.iwait;

always_comb begin
    frame = frames[addr.idx];
    if(frame.tag == )
end

endmodule
