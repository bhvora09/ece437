`include "cache_control_if.vh"  
`include "cpu_ram_if.vh"
`include "cpu_types_pkg.vh"

module bus_controller(
    input CLK, nRST,
    cache_control_if.cc ccif
);

    import cpu_types_pkg::*;
    parameter CPUS = 2;


    typedef enum logic [3:0] {IDLE, CHECK1, WB1, WB2, RD1, RD2, WAIT, IREAD1, IREAD2, CHECK2, SNOOP} states;
    
    states s;
    states nS;
    logic trans0,trans_from0; 
    logic trans1,trans_from1;
    logic write0,write_from0;
    logic write1,write_from1;

    always_ff @(posedge CLK, negedge nRST ) begin:FLIPFLOP
        if(!nRST) begin
            s <= IDLE;
            trans0 <= 0;
            trans1 <= 0;
            write0 <= 0;
            write1 <= 0;
        end
        else begin
            s <= nS;
            trans0 <= trans_from0;
            trans1 <= trans_from1;
            write0 <= write_from0;
            write1 <= write_from1;
        end

    end
    

    always_comb begin : STATE_LOG
        nS = s;
        casez (s)
            IDLE: begin
                //data read request
                //if((ccif.dREN[1] & trans1 & ~write1)| (ccif.dREN[0] & trans0 & ~write0)) nS= IDLE;
                if((ccif.dREN[0] & ~trans0)|(ccif.dREN[1] & ~trans1)) nS = SNOOP;  //checked
                else if((ccif.dREN[0] & trans0 & write0)|(ccif.dREN[1] & trans1 & write1)) nS = WB1;
                
                //data write request
                //else if((ccif.dWEN[0] & ~trans0)| (ccif.dWEN[1] & ~trans1)) nS= SNOOP;
                else if((ccif.dWEN[0] & trans0 & write0)|(ccif.dWEN[1] & trans1 & write1)) nS = WB1;
                else if((ccif.dWEN[0] & trans0 & ~write1) | (ccif.dWEN[1] & trans1 & ~write0)) nS= IDLE;
                

                //instr read
                else if(ccif.iREN[0]) nS = IREAD1;
                else if(ccif.iREN[1]) nS= IREAD2;

                else nS = IDLE;
                
            end
            SNOOP: begin
                if((ccif.dREN[0]) & ~trans0) begin
                    nS = CHECK1;
                end
                else if((ccif.dREN[1]) & ~trans1) begin
                    nS = CHECK1;
                    
                end
            end
            CHECK1: begin
                if(~trans0 & ~write0 & ccif.dREN[0]) begin
                    if((write1 & trans1 & ccif.dREN[0]) | (write0 & trans0 & ccif.dREN[1])) nS = WB1;
                    else if((write1 & ~trans1 & ccif.dREN[0])|(write0 & ~trans0 & ccif.dREN[1])) nS = RD1;
                    else if((~write1 & trans1  & ccif.dREN[0])|(~write0 & trans0  & ccif.dREN[1])) nS = RD1;
                    else nS = RD1;
                    end
                else if(~write1 & ~trans1 & ccif.dREN[1]) begin
                    if(write0 & trans0 & ccif.dREN[1]) nS = WB1;
                    else if(write0 & ~trans0 & ccif.dREN[1]) nS = RD1;
                    else if(~write0 & trans0 & ccif.dREN[1]) nS = RD1;
                    else nS = RD1;
                    end
            end
            WB1: begin
                if(ccif.ramstate == ACCESS) nS = CHECK2;
                else nS = WB1;
            end
            CHECK2: begin
                nS = WB2;
            end
            WB2: begin
                if(ccif.ramstate == ACCESS) nS = RD1;
                else nS = WB2;
            end
            RD1: begin
                if(ccif.ramstate == ACCESS) nS = RD2;
                else nS = RD1;
            end
            RD2: begin
                if(ccif.ramstate == ACCESS) nS = IDLE;
                else nS = RD2;
            end
            IREAD1:begin
                if(ccif.ramstate!=ACCESS) nS = IREAD1;
                else if(ccif.iREN[1]) nS=IREAD2;
                else nS= IDLE;
            end
            IREAD2:begin
                if(ccif.ramstate!=ACCESS) nS = IREAD2;
                else nS= IDLE;
                
            end
        endcase
        
    end

    always_comb begin : OUT_LOG
        ccif.iload[0] = '0;
        ccif.iwait[0] = '0;
        //ccif.dload[0] = '0;
        ccif.dwait[0] = '0;
        ccif.ccwait[0] = '0;
        ccif.ccinv[0] = '0;
        ccif.ccsnoopaddr[0] = '0;
        // ccif.iload[1] = '0;
        ccif.iwait[1] = '0;

        //ccif.dload[1] = '0;
        ccif.dwait[1] = '0;
        ccif.ccwait[1] = '0;
        ccif.ccinv[1] = '0;
        ccif.ccsnoopaddr[1] = '0;
        trans_from0 = trans0;
        trans_from1 = trans1;
        write_from0 = write0;
        write_from1 = write1;

        ccif.ramREN = 0;
        ccif.ramWEN = 0;
        // ccif.ramstore = 0;

        casez (s)
            IDLE: begin
                // if(ccif.ramstate == ACCESS) begin
                ccif.ccwait[0] = '0;
                ccif.ccwait[1] = '0;
                trans_from0 = ccif.cctrans[0];
                trans_from1 = ccif.cctrans[1];
                write_from0 = ccif.ccwrite[0];
                write_from1 = ccif.ccwrite[1];
                // end
            end
            SNOOP: begin
                if(ccif.dREN[0]) begin
                    ccif.ccwait[1] = 1;
                    ccif.ccwait[0] = 0;
                    ccif.ccsnoopaddr[1] = ccif.daddr[0];
                    end
                else if(ccif.dREN[1]) begin
                    ccif.ccwait[0] = 1;
                    ccif.ccwait[1] = 0;
                    ccif.ccsnoopaddr[0] = ccif.daddr[1]; 
                    end

            end
            CHECK1: begin
                if(ccif.dREN[0]) begin
                    ccif.ccwait[1] = 1;
                    ccif.ccwait[0] = 0;
                    ccif.ccsnoopaddr[1] = ccif.daddr[0];
                    trans_from1 = ccif.cctrans[1];
                    write_from1 = ccif.ccwrite[1]; 
                    end
                else if(ccif.dREN[1]) begin
                    ccif.ccwait[0] = 1;
                    ccif.ccwait[1] = 0;
                    ccif.ccsnoopaddr[0] = ccif.daddr[1]; 
                    trans_from0 =  ccif.cctrans[0];
                    write_from0 = ccif.ccwrite[0];
                    end

            end
            WB1: begin
                //dren from idle
                if((trans0 & write0) & ccif.dREN[0])begin
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[0];
                    ccif.ramstore = ccif.dstore[0];
                    ccif.iwait[0]=1;
                    ccif.iwait[1]=1;
                    ccif.dwait[0]=(ccif.ramstate != ACCESS);
                    ccif.dwait[1]=1;  
                    end
                else if((trans1 & write1) & ccif.dREN[1])begin
                    ccif.ccwait[1]=1;
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[1];
                    ccif.ramstore = ccif.dstore[1];
                    ccif.iwait[0]=1;
                    ccif.iwait[1]=1;
                    ccif.dwait[0]=1;
                    ccif.dwait[1]=(ccif.ramstate != ACCESS);  
                    end
                
                //dren from check1
                else if(write1 & trans1 & ccif.dREN[0]) begin   
                    ccif.ccwait[1]=1;
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[1];
                    ccif.ramstore = ccif.dstore[1];
                    ccif.iwait[0]=1;
                    ccif.iwait[1]=1;
                    ccif.dwait[0]=1;
                    ccif.dwait[1]=(ccif.ramstate != ACCESS);  
                    end
                else if(write0 & trans0 & ccif.dREN[1]) begin   
                    ccif.ccwait[0]=1;
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[0];
                    ccif.ramstore = ccif.dstore[0];
                    ccif.iwait[0]=1;
                    ccif.iwait[1]=1;
                    ccif.dwait[0]=(ccif.ramstate != ACCESS);
                    ccif.dwait[1]=1; 
                    end
                
                //dwen from idle
                else if(write0 & trans0 & ccif.dWEN[0]) begin   
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[0];
                    ccif.ramstore = ccif.dstore[0];
                    ccif.iwait[0]=1;
                    ccif.iwait[1]=1;
                    ccif.dwait[0]=(ccif.ramstate != ACCESS);
                    ccif.dwait[1]=1;  
                    end
                else if(write1 & trans1 & ccif.dWEN[1]) begin   
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[1];
                    ccif.ramstore = ccif.dstore[1];
                    ccif.iwait[0]=1;
                    ccif.iwait[1]=1;
                    ccif.dwait[0]=1;
                    ccif.dwait[1]=(ccif.ramstate != ACCESS); 
                    end
                end
            CHECK2: begin
                //dren from idle
                if((trans0 & write0) & ccif.dREN[0])begin
                    if(ccif.daddr[0][2]==0)
                        ccif.ccsnoopaddr[0] = ccif.daddr[0] +4;
                    else 
                        ccif.ccsnoopaddr[0] = ccif.daddr[0] - 4; end
                else if((trans1 & write1) & ccif.dREN[1])begin
                    if(ccif.daddr[1][2]==0)
                        ccif.ccsnoopaddr[1] = ccif.daddr[1] +4;
                    else 
                        ccif.ccsnoopaddr[1] = ccif.daddr[0] - 4; end
                
                //dren from check1
                else if(write1 & trans1 & ccif.dREN[0]) begin   
                    ccif.ccwait[1]=1;
                    if(ccif.daddr[1][2]==0)
                        ccif.ccsnoopaddr[1] = ccif.daddr[1] +4;
                    else 
                        ccif.ccsnoopaddr[1] = ccif.daddr[0] - 4; end
                else if(write0 & trans0 & ccif.dREN[1]) begin   
                    ccif.ccwait[0]=1;
                   if(ccif.daddr[0][2]==0)
                        ccif.ccsnoopaddr[0] = ccif.daddr[0] +4;
                    else 
                        ccif.ccsnoopaddr[0] = ccif.daddr[0] - 4; end

                 //dwen from idle
                else if(write0 & trans0 & ccif.dWEN[0]) begin   
                    if(ccif.daddr[0][2]==0)
                        ccif.ccsnoopaddr[0] = ccif.daddr[0] +4;
                    else 
                        ccif.ccsnoopaddr[0] = ccif.daddr[0] - 4; end
                else if(write1 & trans1 & ccif.dWEN[1]) begin   
                    if(ccif.daddr[1][2]==0)
                        ccif.ccsnoopaddr[1] = ccif.daddr[1] +4;
                    else 
                        ccif.ccsnoopaddr[1] = ccif.daddr[0] - 4; end
            end
            WB2: begin
                //dren from idle
                if(trans0 & write0 & ccif.dREN[0])begin
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[0];
                    ccif.ramstore = ccif.dstore[0];
                    ccif.iwait[0]=1;
                    ccif.iwait[1]=1;
                    ccif.dwait[0]=(ccif.ramstate != ACCESS);
                    ccif.dwait[1]=1;  
                    ccif.ccinv[0]=1;    end
                else if(trans1 & write1 & ccif.dREN[1])begin
                    ccif.ccwait[1]=1;
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[1];
                    ccif.ramstore = ccif.dstore[1];
                    ccif.iwait[0]=1;
                    ccif.iwait[1]=1;
                    ccif.dwait[0]=1;
                    ccif.dwait[1]=(ccif.ramstate != ACCESS);
                    ccif.ccinv[1]=1; end
                
                //dren from check1
                else if(write1 & trans1 & ccif.dREN[0]) begin   
                    ccif.ccwait[1]=1;
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[1];
                    ccif.ramstore = ccif.dstore[1];
                    ccif.iwait[0]=1;
                    ccif.iwait[1]=1;
                    ccif.dwait[0]=1;
                    ccif.dwait[1]=(ccif.ramstate != ACCESS);
                    ccif.ccinv[1] = 1; end
                else if(write0 & trans0 & ccif.dREN[1]) begin   
                    ccif.ccwait[0]=1;
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[0];
                    ccif.ramstore = ccif.dstore[0];
                    ccif.iwait[0]=1;
                    ccif.iwait[1]=1;
                    ccif.dwait[0]=(ccif.ramstate != ACCESS);
                    ccif.dwait[1]=1;
                    ccif.ccinv[0]=1;  end
                
                //dwen from idle
                else if(write0 & trans0 & ccif.dWEN[0]) begin   
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[0];
                    ccif.ramstore = ccif.dstore[0];
                    ccif.iwait[0]=1;
                    ccif.iwait[1]=1;
                    ccif.dwait[0]=(ccif.ramstate != ACCESS);
                    ccif.dwait[1]=1;
                    ccif.ccinv[0]=1;  end
                else if(write1 & trans1 & ccif.dWEN[1]) begin   
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[1];
                    ccif.ramstore = ccif.dstore[1]; 
                    ccif.iwait[0]=1;
                    ccif.iwait[1]=1;
                    ccif.dwait[0]=1;
                    ccif.dwait[1]=(ccif.ramstate != ACCESS);
                    ccif.ccinv[1] = 1;end
                end
            RD1: begin
                //dren/dwen from idle same cache
                if(trans0 & write0 & (ccif.dREN[0] | ccif.dWEN[0]))begin
                    ccif.ramREN = 1;
                    ccif.ramaddr = ccif.daddr[0];
                    ccif.iwait[0]=1;
                    ccif.iwait[1]=1;
                    ccif.dwait[0]=(ccif.ramstate != ACCESS);
                    ccif.dwait[1]=1;
                    ccif.ccinv[1] = 1;
                    ccif.dload[0]=ccif.ramload;   
                    end
                else if((trans1 & write1) &(ccif.dREN[1] | ccif.dWEN[1]))begin
                    ccif.ramREN = 1;
                    ccif.ramaddr = ccif.daddr[1];
                    ccif.iwait[0]=1;
                    ccif.iwait[1]=1;
                    ccif.dwait[0]=1;
                    ccif.dwait[1]=(ccif.ramstate != ACCESS);
                    ccif.dload[1]=ccif.ramload;  
                    end
                
                 //dren from check1
                else if(~write1 & ~trans1 & ccif.dREN[0]) begin   
                    // ccif.ccwait[1]=1;
                    ccif.ramREN = 1;
                    ccif.ramaddr = ccif.daddr[0];
                    ccif.dload[0]=ccif.ramload;  
                    ccif.ccsnoopaddr = ccif.daddr[0];
                    ccif.iwait[0]=1;
                    ccif.iwait[1]=1;
                    ccif.dwait[0]=(ccif.ramstate != ACCESS);
                    ccif.dwait[1]=1; end
                else if(~write0 & ~trans0 & ccif.dREN[1]) begin   
                    // ccif.ccwait[0]=1;
                    ccif.ramREN = 1;
                    ccif.ramaddr = ccif.daddr[1];
                    ccif.dload[1]=ccif.ramload; 
                    ccif.ccsnoopaddr = ccif.daddr[1]; 
                    ccif.iwait[0]=1;
                    ccif.iwait[1]=1;
                    ccif.dwait[0]=1;
                    ccif.dwait[1]=(ccif.ramstate != ACCESS);end
                // else if((write1 & ~trans1 & ccif.dREN[0]) begin
                    
                // end
                
                // else if(write0 & ~trans0 & ccif.dREN[1])
            end
            RD2: begin
                if(~write1 & ~trans1 & ccif.dREN[0]) begin  
                    ccif.ramREN = 1;
                    ccif.iwait[0]=1;
                    ccif.iwait[1]=1;
                    ccif.dwait[0]=(ccif.ramstate != ACCESS);
                    ccif.dwait[1]=1;
                    if(ccif.daddr[0][2])
                        ccif.ramaddr = ccif.daddr[0] - 4;
                    else 
                        ccif.ramaddr = ccif.daddr[0] + 4;
                    ccif.dload[0] = ccif.ramload;
                end
                else if(~write0 & ~trans0 & ccif.dREN[1]) begin  
                    ccif.ramREN = 1;
                    ccif.iwait[0]=1;
                    ccif.iwait[1]=1;
                    ccif.dwait[0]=1;
                    ccif.dwait[1]=(ccif.ramstate != ACCESS);
                    if(ccif.daddr[1][2])
                        ccif.ramaddr = ccif.daddr[1] - 4;
                    else 
                        ccif.ramaddr = ccif.daddr[1] + 4;
                    ccif.dload[0] = ccif.ramload;
                end
            end
            IREAD1:begin
                ccif.ramREN =1;
                ccif.ramaddr = ccif.iaddr[0];
                ccif.iload[0] = ccif.ramload;
                ccif.iwait[0]=(ccif.ramstate != ACCESS);
                ccif.iwait[1]=1;
                ccif.dwait[0]=1;
                ccif.dwait[1]=1;      
            end
            IREAD2:begin
                ccif.ramREN =1;
                ccif.ramaddr = ccif.iaddr[1];
                ccif.iload[1] = ccif.ramload;
                ccif.iwait[0]=1;
                ccif.iwait[1]=(ccif.ramstate != ACCESS);
                ccif.dwait[0]=1;
                ccif.dwait[1]=1;
            end

        endcase
    end

endmodule