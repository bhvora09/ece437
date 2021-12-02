`include "cache_control_if.vh"  
`include "cpu_ram_if.vh"
`include "cpu_types_pkg.vh"

module bus_controller(
    input CLK, nRST,
    cache_control_if.cc ccif
);

    import cpu_types_pkg::*;
    parameter CPUS = 2;
   


    typedef enum logic [3:0] {IDLE, CHECK1, WB1, WB2, RD1, RD2,INV, IREAD1, IREAD2, CHECK2, SNOOP, HALTWB1, HALTWB2} states;
    
    states s;
    states nS;
    logic trans0,trans_from0; 
    logic trans1,trans_from1;
    logic write0,write_from0;
    logic write1,write_from1;
    logic busread0, busrd0;
    logic busread1, busrd1;
    logic buswrite0, buswr0;
    logic buswrite1, buswr1;
    always_ff @(posedge CLK, negedge nRST ) begin:FLIPFLOP
        if(!nRST) begin
            s <= IDLE;
            trans0 <= 0;
            trans1 <= 0;
            write0 <= 0;
            write1 <= 0;
            busrd0 <=0;
            busrd1 <=0;
            buswr0 <=0;
            buswr1 <=0;
        end
        else begin
            s <= nS;
            trans0 <= trans_from0;
            trans1 <= trans_from1;
            write0 <= write_from0;
            write1 <= write_from1;
            busrd0 <= busread0;
            busrd1 <= busread1;
            buswr0 <= buswrite0;
            buswr1 <= buswrite1;
        
        end

    end

    // assign ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]) ? ((ccif.ramstate!=ACCESS)? 1:((s==INV) ||(s==IREAD1) || (s==IREAD2))): 0;
    // assign ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1] ) ? ((ccif.dREN[0]  || ccif.dWEN[0] || ccif.ramstate!=ACCESS)? 1:((s==INV) ||(s==IREAD1) || (s==IREAD2))) :0 ;
    // assign ccif.iwait[0] = (ccif.iREN[0]) ? ((ccif.dREN[0] || ccif.dWEN[0] || ccif.dREN[1] || ccif.dWEN[1] ||(ccif.ramstate!=ACCESS))? 1:((s==INV)|| (s==IREAD2))): 0 ;
    // assign ccif.iwait[1] = (ccif.iREN[1]) ? ((ccif.iREN[0] || ccif.dREN[1] || ccif.dWEN[1] || ccif.dREN[0]  || ccif.dWEN[0] || (ccif.ramstate!=ACCESS)) ? 1: (s==INV)) :0;


    always_comb begin : STATE_LOG
        nS = s;
        busread0 = busrd0;
        busread1 = busrd1;
        buswrite0= buswr0;
        buswrite1= buswr1;
        casez (s)
            IDLE: begin
                //data read request on dren miss
                if(ccif.dREN[0] & ~ccif.cctrans[0] & ~ccif.ccwrite[0]) begin
                    nS = SNOOP;
                    busread0 = ccif.dREN[0];
                    busread1 = 0;
                    buswrite0 = 0;
                    buswrite1 = 0;
                end
                else if(ccif.dREN[0] & ccif.cctrans[0]) begin
                    nS= IDLE;
                    busread0 = ccif.dREN[0];
                    busread1 = 0;
                    buswrite0 =0;
                    buswrite1 =0;
                    end
                //write from cpu
                else if(ccif.dREN[0] & ~ccif.cctrans[0] & ccif.ccwrite[0]) begin
                    nS= SNOOP;
                    busread0 = ccif.dREN[0];
                    busread1 = 0;
                    buswrite0 =0;
                    buswrite1 =0;
                end
                else if(ccif.dREN[1] & ~ccif.cctrans[1] & ~ccif.ccwrite[1]) begin
                    nS = SNOOP;
                    busread0 = 0;
                    busread1 = ccif.dREN[1];
                    buswrite0 =0;
                    buswrite1 =0;
                end
                else if(ccif.dREN[1] & ccif.cctrans[1]) begin
                    nS= IDLE;
                    busread0 = 0;
                    busread1 = ccif.dREN[1];
                    buswrite0 = 0;
                    buswrite1 =  0;
                end
                else if(ccif.dREN[1] & ~ccif.cctrans[1] & ccif.ccwrite[1]) begin
                    nS= SNOOP;
                    busread0 = 0;
                    busread1 = ccif.dREN[1];
                    buswrite0 =0;
                    buswrite1 =0;
                end
                else if(ccif.dWEN[0] & ~ccif.cctrans[0] & ~ccif.ccwrite[0]) begin
                    nS= SNOOP;
                    busread0 =0;
                    busread1 =0;
                    buswrite0 = ccif.dWEN[0];
                    buswrite1 = 0;
                end
                else if(ccif.dWEN[0] & ccif.cctrans[0] & ~ccif.ccwrite[0]) begin
                    nS= HALTWB1;
                    busread0 = 0;
                    busread1 = 0;
                    buswrite0 = ccif.dWEN[0];
                    buswrite1 =  0;
                end
                else if(ccif.dWEN[0] & ccif.cctrans[0] & ccif.ccwrite[0]) begin
                    nS = HALTWB1;
                    busread0 =0;
                    busread1 = 0;
                    buswrite0 = ccif.dWEN[0];
                    buswrite1 =0;
                end
                
                else if(ccif.dWEN[1] & ~ccif.cctrans[1] & ~ccif.ccwrite[1]) begin
                    nS= SNOOP;
                    busread0 =0;
                    busread1 =0;
                    buswrite0 = 0;
                    buswrite1 =  ccif.dWEN[1];
                end
                else if(ccif.dWEN[1] & ccif.cctrans[1] & ~ccif.ccwrite[1]) begin
                    nS= HALTWB1;
                    busread0 = 0;
                    busread1 = 0;
                    buswrite0 = 0;
                    buswrite1 =  ccif.dWEN[1];
                end
                else if(ccif.dWEN[1] & ccif.cctrans[1] & ccif.ccwrite[1]) begin
                    nS = HALTWB1;
                    busread0 = 0;
                    busread1 =0;
                    buswrite0 = 0;
                    buswrite1 =  ccif.dWEN[1];
                end

                else if(ccif.iREN[0]) begin
                    nS = IREAD1;
                    busread0 = 0;
                    busread1 =0;
                    buswrite0 = 0;
                    buswrite1 = 0;
                    end
                else if(ccif.iREN[1]) begin
                    nS= IREAD2;
                    busread0 = 0;
                    busread1 =0;
                    buswrite0 = 0;
                    buswrite1 = 0;
                    end


                else nS = IDLE;//end   
            end
            SNOOP: begin
                //dren and I state
                if((busrd0 & ~trans0 & ~write0)|(busrd1 & ~trans1 & ~write1)) nS = CHECK1;
                if((busrd0 & ~trans0 & write0)|(busrd1 & ~trans1 & write1)) nS = CHECK1;
                //dwen and I state
                else if((buswr0 & ~trans0 & ~write0)| (buswr1 & ~trans1 & ~write1)) nS= CHECK1;     
                end

            CHECK1: begin
                //dren and c1- I state
                if(~trans0 & ~write0 & busrd0) begin
                    //c2 - M state
                    if((write1 & trans1)) nS = WB1;
                    //c2 - S/I state
                    else if(~write1) nS = RD1;
                    else nS = CHECK1;
                    end
                //write from cache0 leading to read from ram
                else if(~trans0 & write0 & busrd0) begin
                    //c2 - M state
                    if((write1 & trans1)) nS = WB1;
                    //c2 - I state
                    else if(~trans1 & ~write1) nS = RD1;
                    //c2- S state
                    else if(~trans1 & write1) nS = IDLE;
                    else nS = CHECK1;
                    end
                else if(~trans1 & ~write1 & busrd1) begin
                    //c2 - M state
                    if((write0 & trans0)) nS = WB1;
                    //c2 - S/I state
                    else if(~write0) nS = RD1;
                    else nS = CHECK1;
                    end
                //write from cache0 leading to read from ram
                else if(~trans1 & write1 & busrd1) begin
                    //c2 - M state
                    if((write0 & trans0)) nS = WB1;
                    //c2 - I state
                    else if(~trans0 & ~write0) nS = RD1;
                    //c2- S state
                    else if(~trans0 & write0) nS = IDLE;
                    else nS = CHECK1;
                    end
                
                //dwen and c1-I/S state
                else if(~write0 & buswr0) begin
                    //c2 - M state
                    if((write1 & trans1)) nS = WB1;
                    //c2 - S/I state
                    else if(~write1) nS = RD1;
                    else nS = CHECK1;
                    end
                else if(~write1 & buswr1) begin
                    //c2 - M state
                    if((write0 & trans0)) nS = WB1;
                    //c2 - S/I state
                    else if(~write0) nS = RD1;
                    else nS = CHECK1;
                    end
                end
            WB1: begin
                if(ccif.ramstate != ACCESS) nS = WB1;
                else nS = CHECK2;
            end
            CHECK2: begin
                nS = WB2;
            end
            WB2: begin
                if(ccif.ramstate != ACCESS) nS = WB2;
                else nS = INV;
            end
            INV: nS = RD1;
            RD1: begin
                if(ccif.ramstate != ACCESS) nS = RD1;
                else nS = RD2;
            end
            RD2: begin
                if(ccif.ramstate != ACCESS) nS = RD2;
                else nS = IDLE;
            end
            IREAD1:begin
                if(ccif.ramstate!=ACCESS) nS = IREAD1;
                else nS= IDLE;
            end
            IREAD2:begin
                if(ccif.ramstate!=ACCESS) nS = IREAD2;
                else nS= IDLE;
            end
            HALTWB1: begin
                if(ccif.ramstate != ACCESS) nS = HALTWB1;
                else nS = HALTWB2;   
            end
            HALTWB2: begin
                if(ccif.ramstate != ACCESS) nS = HALTWB2;
                else nS = IDLE;   
            end
        endcase
        
    end

    always_comb begin : OUT_LOG
        ccif.iload[0] = '0;
        ccif.dload[0] = '0;
        ccif.ccwait[0] = '0;
        ccif.ccinv[0] = '0;
        ccif.ccsnoopaddr[0] = '0;
        
        ccif.iload[1] = '0;
        ccif.dload[1] = '0;
        ccif.ccwait[1] = '0;
        ccif.ccinv[1] = '0;
        ccif.ccsnoopaddr[1] = '0;
        
        trans_from0 = trans0;
        trans_from1 = trans1;
        write_from0 = write0;
        write_from1 = write1;

        ccif.ramREN = 0;
        ccif.ramWEN = 0;
        ccif.ramstore = 'b0;
        ccif.ramaddr = 'b0;

        ccif.dwait[0] = 0;
        ccif.dwait[1] = 0;
        ccif.iwait[0] = 0;
        ccif.iwait[1] = 0;

        casez (s)
            IDLE: begin
                ccif.ccwait[0] = '0;
                ccif.ccwait[1] = '0;
                trans_from0 = ccif.cctrans[0];
                trans_from1 = ccif.cctrans[1];
                write_from0 = ccif.ccwrite[0];
                write_from1 = ccif.ccwrite[1];
                ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]) && (ccif.ramstate!=ACCESS);
                ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1] ) && (ccif.dREN[0]  || ccif.dWEN[0] || (ccif.ramstate!=ACCESS));
                ccif.iwait[0] = (ccif.iREN[0]) && (ccif.dREN[0] || ccif.dWEN[0] || ccif.dREN[1] || ccif.dWEN[1] ||(ccif.ramstate!=ACCESS));
                ccif.iwait[1] = (ccif.iREN[1]) && (ccif.iREN[0] || ccif.dREN[1] || ccif.dWEN[1] || ccif.dREN[0]  || ccif.dWEN[0] || (ccif.ramstate!=ACCESS));
                end
            SNOOP: begin
                //dren and i state  
                if(busrd0) begin
                    ccif.ccwait[1] = 1;
                    ccif.ccwait[0] = 0;
                    ccif.ccsnoopaddr[1] = ccif.daddr[0];
                    trans_from1 = ccif.cctrans[1];
                    write_from1 = ccif.ccwrite[1];
                    ccif.dwait[0]= (ccif.dREN[0] || ccif.dWEN[0]);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1] ) && ((ccif.ramstate!=ACCESS));
                    if(~trans0 & write0) begin
                        if(trans1 & ~write1)
                            ccif.ccinv[1]=1;
                        end
                    end
                else if(busrd1) begin
                    ccif.ccwait[0] = 1;
                    ccif.ccwait[1] = 0;
                    ccif.ccsnoopaddr[0] = ccif.daddr[1];
                    trans_from0 =  ccif.cctrans[0];
                    write_from0 = ccif.ccwrite[0];
                    ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]) && (ccif.ramstate!=ACCESS);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]);
                    if(~trans1 & write1) begin
                        if(trans0 & ~write0)
                            ccif.ccinv[0]=1;
                        end
                    end
                
                //dwen and i state
                else if(buswr0) begin
                    ccif.ccwait[1] = 1;
                    ccif.ccwait[0] = 0;
                    ccif.ccsnoopaddr[1] = ccif.daddr[0];
                    trans_from1 = ccif.cctrans[1];
                    write_from1 = ccif.ccwrite[1];
                    ccif.dwait[0]= (ccif.dREN[0] || ccif.dWEN[0]);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1] ) && (ccif.ramstate!=ACCESS);
                    end
                else if(buswr1) begin
                    ccif.ccwait[0] = 1;
                    ccif.ccwait[1] = 0;
                    ccif.ccsnoopaddr[0] = ccif.daddr[1];
                    trans_from0 =  ccif.cctrans[0];
                    write_from0 = ccif.ccwrite[0];
                    ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]) && (ccif.ramstate!=ACCESS);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]); 
                    end
                ccif.iwait[0] = (ccif.iREN[0]) && (ccif.dREN[0] || ccif.dWEN[0] || ccif.dREN[1] || ccif.dWEN[1] ||(ccif.ramstate!=ACCESS));
                ccif.iwait[1] = (ccif.iREN[1]) && (ccif.iREN[0] || ccif.dREN[1] || ccif.dWEN[1] || ccif.dREN[0]  || ccif.dWEN[0] || (ccif.ramstate!=ACCESS));
                end

            CHECK1: begin
                ccif.iwait[0] = (ccif.iREN[0]) && (ccif.dREN[0] || ccif.dWEN[0] || ccif.dREN[1] || ccif.dWEN[1] ||(ccif.ramstate!=ACCESS));
                ccif.iwait[1] = (ccif.iREN[1]) && (ccif.iREN[0] || ccif.dREN[1] || ccif.dWEN[1] || ccif.dREN[0]  || ccif.dWEN[0] || (ccif.ramstate!=ACCESS));
                //dREN and c1- I state
                if(busrd0) begin
                    ccif.ccwait[1] = 1;
                    ccif.ccwait[0] = 0;
                    ccif.ccsnoopaddr[1] = ccif.daddr[0];
                    trans_from1 = ccif.cctrans[1];
                    write_from1 = ccif.ccwrite[1];
                    ccif.dwait[0]= (ccif.dREN[0] || ccif.dWEN[0]);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1] ) && (ccif.ramstate!=ACCESS);
                    if(~trans0 & write0) begin
                        if(trans1 & ~write1)
                            ccif.ccinv[1]=1;
                        end
                    end
                //dREN and c2- I state
                else if(busrd1) begin
                    ccif.ccwait[0] = 1;
                    ccif.ccwait[1] = 0;
                    ccif.ccsnoopaddr[0] = ccif.daddr[1]; 
                    trans_from0 =  ccif.cctrans[0];
                    write_from0 = ccif.ccwrite[0];
                    ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]) && (ccif.ramstate!=ACCESS);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]); 
                    if(~trans1 & write1) begin
                        if(trans0 & ~write0)
                            ccif.ccinv[0]=1;
                        end
                    end
                //dWEN and c1- I/S state
                else if(buswr0) begin
                    ccif.ccwait[1] = 1;
                    ccif.ccwait[0] = 0;
                    ccif.ccsnoopaddr[1] = ccif.daddr[0];
                    trans_from1 = ccif.cctrans[1];
                    write_from1 = ccif.ccwrite[1];
                    ccif.dwait[0]= (ccif.dREN[0] || ccif.dWEN[0]);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1] ) && (ccif.ramstate!=ACCESS); 
                    end
                //dWEN and c2- I/S state
                else if(buswr1) begin
                    ccif.ccwait[0] = 1;
                    ccif.ccwait[1] = 0;
                    ccif.ccsnoopaddr[0] = ccif.daddr[1]; 
                    trans_from0 =  ccif.cctrans[0];
                    write_from0 = ccif.ccwrite[0];
                    ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]) && (ccif.ramstate!=ACCESS);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]); 
                    end
                end

            WB1: begin
                ccif.iwait[0] = (ccif.iREN[0]) && (ccif.dREN[0] || ccif.dWEN[0] || ccif.dREN[1] || ccif.dWEN[1] ||(ccif.ramstate!=ACCESS));
                ccif.iwait[1] = (ccif.iREN[1]) && (ccif.iREN[0] || ccif.dREN[1] || ccif.dWEN[1] || ccif.dREN[0]  || ccif.dWEN[0] || (ccif.ramstate!=ACCESS));
                //dren - c1-I c2-M 
                if(write1 & trans1 & busrd0) begin   
                    ccif.ccwait[1]=1;
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[1];
                    ccif.ramstore = ccif.dstore[1];
                    ccif.ccsnoopaddr[1] = ccif.daddr[0];
                    ccif.dwait[0]= (ccif.dREN[0] || ccif.dWEN[0]);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1] ) && (ccif.ramstate!=ACCESS);   
                    end
                else if(write0 & trans0 & busrd1) begin   
                    ccif.ccwait[0]=1;
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[0];
                    ccif.ramstore = ccif.dstore[0];
                    ccif.ccsnoopaddr[0] = ccif.daddr[1];
                    ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]) && (ccif.ramstate!=ACCESS);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]);  
                    end
                
                //dwen - C1-I c2-M
                else if(write1 & trans1 & buswr0) begin   
                    ccif.ccwait[1]=1;
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[1];
                    ccif.ramstore = ccif.dstore[1];
                    ccif.ccsnoopaddr[1] = ccif.daddr[0];
                    ccif.dwait[0]= (ccif.dREN[0] || ccif.dWEN[0]);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1] ) && (ccif.ramstate!=ACCESS);   
                    end
                else if(write0 & trans0 & buswr1) begin           
                    ccif.ccwait[0]=1;
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[0];
                    ccif.ramstore = ccif.dstore[0];
                    ccif.ccsnoopaddr[0] = ccif.daddr[1];
                    ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]) && (ccif.ramstate!=ACCESS);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]);  
                    end
                end
            CHECK2: begin
                ccif.iwait[0] = (ccif.iREN[0]) && (ccif.dREN[0] || ccif.dWEN[0] || ccif.dREN[1] || ccif.dWEN[1] ||(ccif.ramstate!=ACCESS));
                ccif.iwait[1] = (ccif.iREN[1]) && (ccif.iREN[0] || ccif.dREN[1] || ccif.dWEN[1] || ccif.dREN[0]  || ccif.dWEN[0] || (ccif.ramstate!=ACCESS));
                //dren - c1-I c2-M 
                if(write1 & trans1 & busrd0) begin   
                    ccif.ccwait[1]=1;
                    ccif.dwait[0]=(ccif.dREN[0] || ccif.dWEN[0]);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1] ) && (ccif.ramstate!=ACCESS);
                    if(ccif.daddr[1][2]==0)
                        ccif.ccsnoopaddr[1] = ccif.daddr[1] +4;
                    else 
                        ccif.ccsnoopaddr[1] = ccif.daddr[1] - 4; 
                    end
                else if(write0 & trans0 & busrd1) begin   
                    ccif.ccwait[0]=1;
                    ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]) && (ccif.ramstate!=ACCESS);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]);
                    if(ccif.daddr[0][2]==0)
                        ccif.ccsnoopaddr[0] = ccif.daddr[0] +4;
                    else 
                        ccif.ccsnoopaddr[0] = ccif.daddr[0] - 4; 
                    end
                
                //dwen - c1-I c2-M 
                else if(write1 & trans1 & buswr0) begin   
                    ccif.ccwait[1]=1;
                    ccif.dwait[0]=(ccif.dREN[0] || ccif.dWEN[0]);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1] ) && (ccif.ramstate!=ACCESS);
                    if(ccif.daddr[1][2]==0)
                        ccif.ccsnoopaddr[1] = ccif.daddr[1] + 4;
                    else 
                        ccif.ccsnoopaddr[1] = ccif.daddr[1] - 4; 
                    end
                else if(write0 & trans0 & buswr1) begin   
                    ccif.ccwait[0]=1;
                    ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]) && (ccif.ramstate!=ACCESS);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]);
                    if(ccif.daddr[0][2]==0)
                        ccif.ccsnoopaddr[0] = ccif.daddr[0] +4;
                    else 
                        ccif.ccsnoopaddr[0] = ccif.daddr[0] - 4; 
                    end            
            end
            WB2: begin
                ccif.iwait[0] = (ccif.iREN[0]) && (ccif.dREN[0] || ccif.dWEN[0] || ccif.dREN[1] || ccif.dWEN[1] ||(ccif.ramstate!=ACCESS));
                ccif.iwait[1] = (ccif.iREN[1]) && (ccif.iREN[0] || ccif.dREN[1] || ccif.dWEN[1] || ccif.dREN[0]  || ccif.dWEN[0] || (ccif.ramstate!=ACCESS));
                //dren - c1-I c2-M 
                if(write1 & trans1 & busrd0) begin   
                    ccif.ccwait[1]=1;
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[1];
                    ccif.ramstore = ccif.dstore[1];
                    ccif.dwait[0]=(ccif.dREN[0] || ccif.dWEN[0]);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1] ) && (ccif.ramstate!=ACCESS);
                    if(ccif.daddr[1][2]==0)
                        ccif.ccsnoopaddr[1] = ccif.daddr[1] +4;
                    else 
                        ccif.ccsnoopaddr[1] = ccif.daddr[1] - 4; 
                    ccif.ccinv[1] =1;
                    end
                else if(write0 & trans0 & busrd1) begin   
                    ccif.ccwait[0]=1;
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[0];
                    ccif.ramstore = ccif.dstore[0];
                    ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]) && (ccif.ramstate!=ACCESS);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]);
                    if(ccif.daddr[0][2]==0)
                        ccif.ccsnoopaddr[0] = ccif.daddr[0] +4;
                    else 
                        ccif.ccsnoopaddr[0] = ccif.daddr[0] - 4;                     
                    ccif.ccinv[0] =1;
                    end
                
                //dwen - C1-I/S c2-M
                else if(write1 & trans1 & buswr0) begin   
                    ccif.ccwait[1]=1;
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[1];
                    ccif.ramstore = ccif.dstore[1];
                    ccif.dwait[0]=(ccif.dREN[0] || ccif.dWEN[0]);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1] ) && (ccif.ramstate!=ACCESS);
                    if(ccif.daddr[1][2]==0)
                        ccif.ccsnoopaddr[1] = ccif.daddr[1] +4;
                    else 
                        ccif.ccsnoopaddr[1] = ccif.daddr[1] - 4;
                    ccif.ccinv[1] =1;
                    end
                else if(write0 & trans0 & buswr1) begin           
                    ccif.ccwait[0]=1;
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[0];
                    ccif.ramstore = ccif.dstore[0];
                    ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]) && (ccif.ramstate!=ACCESS);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]);
                    if(ccif.daddr[0][2]==0)
                        ccif.ccsnoopaddr[0] = ccif.daddr[0] +4;
                    else 
                        ccif.ccsnoopaddr[0] = ccif.daddr[0] - 4;   
                    ccif.ccinv[0] =1;
                    end
                end
            INV: begin
                ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]);
                ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]);
                ccif.iwait[0] = (ccif.iREN[0]);
                ccif.iwait[1] = (ccif.iREN[1]);
                trans_from0 = ccif.cctrans[0];
                trans_from1 = ccif.cctrans[1];
                write_from0 = ccif.ccwrite[0];
                write_from1 = ccif.ccwrite[1];
                end
            RD1: begin
                ccif.iwait[0] = (ccif.iREN[0]) && (ccif.dREN[0] || ccif.dWEN[0] || ccif.dREN[1] || ccif.dWEN[1] ||(ccif.ramstate!=ACCESS));
                ccif.iwait[1] = (ccif.iREN[1]) && (ccif.iREN[0] || ccif.dREN[1] || ccif.dWEN[1] || ccif.dREN[0]  || ccif.dWEN[0] || (ccif.ramstate!=ACCESS));
                //dren adn C2 - I/S
                if(~write1 & busrd0) begin 
                    ccif.ramREN = 1;
                    ccif.ramaddr = ccif.daddr[0];
                    ccif.dload[0]=ccif.ramload;
                    ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]) && (ccif.ramstate!=ACCESS);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]);  
                    end
                else if(~write0 & busrd1) begin
                    ccif.ramREN = 1;
                    ccif.ramaddr = ccif.daddr[1];
                    ccif.dload[1]=ccif.ramload;
                    ccif.dwait[0]=(ccif.dREN[0] || ccif.dWEN[0]);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1] ) && (ccif.ramstate!=ACCESS);
                    
                    end
                //dwen and c2 - I/S
                else if(~write1 & buswr0) begin 
                    ccif.ramREN = 1;
                    ccif.ramaddr = ccif.daddr[0];
                    ccif.dload[0]=ccif.ramload;  
                    ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]) && (ccif.ramstate!=ACCESS);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]); 
                    end
                else if(~write0 & buswr1) begin
                    ccif.ramREN = 1;
                    ccif.ramaddr = ccif.daddr[1];
                    ccif.dload[1]=ccif.ramload;
                    ccif.dwait[0]=(ccif.dREN[0] || ccif.dWEN[0]);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1] ) && (ccif.ramstate!=ACCESS);
                    
                    end
                end
            RD2: begin
                ccif.iwait[0] = (ccif.iREN[0]) && (ccif.dREN[0] || ccif.dWEN[0] || ccif.dREN[1] || ccif.dWEN[1] ||(ccif.ramstate!=ACCESS));
                ccif.iwait[1] = (ccif.iREN[1]) && (ccif.iREN[0] || ccif.dREN[1] || ccif.dWEN[1] || ccif.dREN[0]  || ccif.dWEN[0] || (ccif.ramstate!=ACCESS));
                if(~write1 & busrd0) begin  
                    ccif.ramREN = 1;
                    ccif.ramaddr = ccif.daddr[0];
                    ccif.dload[0] = ccif.ramload;
                    ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]) && (ccif.ramstate!=ACCESS);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]);
                    end
                else if(~write0 & busrd1) begin
                    ccif.ramREN = 1;
                    ccif.ramaddr = ccif.daddr[1];
                    ccif.dload[1] = ccif.ramload;
                    ccif.dwait[0]=(ccif.dREN[0] || ccif.dWEN[0]);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1] ) && (ccif.ramstate!=ACCESS);
                  
                    end
                else if(~write1 & buswr0) begin  
                    ccif.ramREN = 1;
                    ccif.ramaddr = ccif.daddr[0];
                    ccif.dload[0] = ccif.ramload;
                    ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]) && (ccif.ramstate!=ACCESS);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]);
                    end
                else if(~write0 & buswr1) begin
                    ccif.ramREN = 1;
                    ccif.ramaddr = ccif.daddr[1];
                    ccif.dload[1] = ccif.ramload;
                    ccif.dwait[0]=(ccif.dREN[0] || ccif.dWEN[0]);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1] ) && (ccif.ramstate!=ACCESS);
                    end
                if(buswr0) begin 
                    ccif.ccinv[1]=1;
                    ccif.ccwait[1]=1;
                end
                else if(buswr1) begin
                    ccif.ccinv[0]=1;
                    ccif.ccwait[0]=1;
                end
            end
            IREAD1:begin
                ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]);
                ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]);
                ccif.iwait[0] = (ccif.iREN[0]) && (ccif.ramstate!=ACCESS);
                ccif.iwait[1] = (ccif.iREN[1]);
                ccif.ramREN =1;
                ccif.ramaddr = ccif.iaddr[0];
                ccif.iload[0] = ccif.ramload;
                end
            IREAD2:begin
                ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]);
                ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]);
                ccif.iwait[0] = (ccif.iREN[0]);
                ccif.iwait[1] = (ccif.iREN[1]) && (ccif.ramstate!=ACCESS);
                ccif.ramREN =1;
                ccif.ramaddr = ccif.iaddr[1];
                ccif.iload[1] = ccif.ramload;
                end
            HALTWB1: begin
                ccif.iwait[0] = (ccif.iREN[0]) && (ccif.dREN[0] || ccif.dWEN[0] || ccif.dREN[1] || ccif.dWEN[1] ||(ccif.ramstate!=ACCESS));
                ccif.iwait[1] = (ccif.iREN[1]) && (ccif.iREN[0] || ccif.dREN[1] || ccif.dWEN[1] || ccif.dREN[0]  || ccif.dWEN[0] || (ccif.ramstate!=ACCESS));
                ccif.ramREN = 0;
                if(~write0 & trans0 & buswr0) begin   
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[0];
                    ccif.ramstore = ccif.dstore[0];
                    ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]) && (ccif.ramstate!=ACCESS);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]);
                    end
                    //dwen - C1-M or c2-M
                else if(write0 & trans0 & buswr0) begin   
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[0];
                    ccif.ramstore = ccif.dstore[0];
                    ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]) && (ccif.ramstate!=ACCESS);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]);
                    end 
                else if(~write1 & trans1 & buswr1) begin   
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[1];
                    ccif.ramstore = ccif.dstore[1];
                    ccif.dwait[0]=(ccif.dREN[0] || ccif.dWEN[0]);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1] ) && (ccif.ramstate!=ACCESS);
                    
                    end
                else if(write1 & trans1 & buswr1) begin
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[1];
                    ccif.ramstore = ccif.dstore[1];
                    ccif.dwait[0]=(ccif.dREN[0] || ccif.dWEN[0]);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1] ) && (ccif.ramstate!=ACCESS);
                    end
                end
            HALTWB2: begin
                ccif.iwait[0] = (ccif.iREN[0]) && (ccif.dREN[0] || ccif.dWEN[0] || ccif.dREN[1] || ccif.dWEN[1] ||(ccif.ramstate!=ACCESS));
                ccif.iwait[1] = (ccif.iREN[1]) && (ccif.iREN[0] || ccif.dREN[1] || ccif.dWEN[1] || ccif.dREN[0]  || ccif.dWEN[0] || (ccif.ramstate!=ACCESS));
                ccif.ramREN = 0;
                if(~write0 & trans0 & buswr0) begin   
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[0];
                    ccif.ramstore = ccif.dstore[0];
                    ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]) && (ccif.ramstate!=ACCESS);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]);                    
                    end
                else if(write0 & trans0 & buswr0) begin   
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[0];
                    ccif.ramstore = ccif.dstore[0];
                    ccif.dwait[0] = (ccif.dREN[0] || ccif.dWEN[0]) && (ccif.ramstate!=ACCESS);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1]);                   
                    end
                else if(~write1 & trans1 & buswr1) begin  
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[1];
                    ccif.ramstore = ccif.dstore[1];
                    ccif.dwait[0]=(ccif.dREN[0] || ccif.dWEN[0]);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1] ) && (ccif.ramstate!=ACCESS);
                     
                    end
                
                else if(write1 & trans1 & buswr1) begin  
                    ccif.ramWEN = 1;
                    ccif.ramaddr = ccif.daddr[1];
                    ccif.ramstore = ccif.dstore[1]; 
                    ccif.dwait[0]=(ccif.dREN[0] || ccif.dWEN[0]);
                    ccif.dwait[1] = (ccif.dREN[1] || ccif.dWEN[1] ) && (ccif.ramstate!=ACCESS);
                    
                    end
                end

            endcase
        end

    endmodule