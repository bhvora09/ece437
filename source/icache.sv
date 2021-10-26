`include "datapath_cache_if.vh"
`include "cache_control_if.vh"
`include "caches_if.vh"
`include "cpu_types_pkg.vh"

module icache(
    input CLK, nRST,
    caches_if.icache ccif,
    datapath_cache_if.icache dcif
);

import cpu_types_pkg::*;

logic hit;
word_t data;
icachef_t addr;
icache_frame [15:0] frames;
icache_frame [15:0] n_frames;
icache_frame frame;
logic valid;
logic iwait;

//states
typedef enum logic {IDLE, ALLOCATE} states;
states s;
states nS;

//Datapath Signals
assign valid = dcif.imemREN;
assign addr.tag = dcif.imemaddr[31:6];
assign addr.idx = dcif.imemaddr[5:2];
assign addr.bytoff = dcif.imemaddr[1:0];
assign dcif.ihit = hit;
assign dcif.imemload = data;

//CacheControl Signals
//iRen and iaddr not included
assign iwait = ccif.iwait;

always_ff @(posedge CLK, negedge nRST) begin : STATES
    if (!nRST) begin
        frames <=0;
        s <= IDLE;
    end
    else begin
        s <= nS;
        frames <= n_frames;
    end
end

always_comb begin : NSTATES
    nS = s;
    casez(s) 
        IDLE: begin
            if(hit==0) nS = ALLOCATE;
            else nS = IDLE;
        end

        ALLOCATE: begin
            if(iwait == 0) nS = IDLE;
            else nS = ALLOCATE;
        end
    endcase
end

always_comb begin
    hit = 0;
    n_frames = frames;
    frame = 0;
    ccif.iREN = 0;
    ccif.iaddr = 0;
    data = 0;

    casez(s)
        IDLE: begin
            if(dcif.imemREN)begin 
                frame = frames[addr.idx];
                if((frame.tag == addr.tag) && frame.valid) begin
                    hit = 1;
                end

                data = frame.data;
            end
        end
        ALLOCATE: begin
            ccif.iREN = 1;
            ccif.iaddr = dcif.imemaddr;
            frame.data = ccif.iload;
            frame.tag = addr.tag;
            frame.valid =1;
            n_frames[addr.idx] = frame;
        end
    endcase
end
    
endmodule