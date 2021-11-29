`include "caches_if.vh"
`include "datapath_cache_if.vh"
`include "cpu_types_pkg.vh"

module dcache(
    input logic CLK,nRST,
    datapath_cache_if.dcache dcif,
    caches_if.dcache cdif
    //cache_control_if.cc ccif
);
  // type import
import cpu_types_pkg::*;

//structs
//dcache_frame - [valid,dirty,tag, data[1:0]]
dcache_frame [7:0] table1,temptable1;
dcache_frame [7:0] table2,temptable2;
logic  [7:0] LRU;
logic [7:0] nLRU;
word_t dload1,dload2,dstore10,dstore11,dstore20,dstore21;
logic [26:0] tag1,tag2;
logic [2:0] index;
int a,b;
int i, ni;
word_t hit_count,hit_count_next;
word_t ndaddr;
logic trans, write;

typedef enum logic [3:0]{
  TAG = 4'b000,
  WB1 = 4'b001,
  WB2 = 4'b010,
  AL1 = 4'b011,
  AL2 = 4'b100,
  HALT = 4'b101,
  HALTWB1 = 4'b110,
  HALTWB2 = 4'b111,
  FLUSH = 4'b1000,
  HIT = 4'b1001,
  SNOOP = 4'b1010,
  SWB1 = 4'b1011,
  SWB2 = 4'b1100
} s;
s state;
s next_state;

//dcache_t -  [tag-26, index-3, blkoff-1, bytoff-2]
dcachef_t daddr;
assign daddr.tag =cdif.ccwait? cdif.ccsnoopaddr: dcif.dmemaddr[31:6];
assign daddr.idx =cdif.ccwait? cdif.ccsnoopaddr: dcif.dmemaddr[5:3];
assign daddr.blkoff = cdif.ccwait? cdif.ccsnoopaddr: dcif.dmemaddr[2];
assign daddr.bytoff = cdif.ccwait? cdif.ccsnoopaddr: dcif.dmemaddr[1:0];

//Snoop addresss
dcachef_t saddr;
assign saddr.tag = cdif.ccsnoopaddr[31:6];
assign saddr.idx = cdif.ccsnoopaddr[5:3];
assign saddr.blkoff = cdif.ccsnoopaddr[2];
assign saddr.bytoff = cdif.ccsnoopaddr[1:0];

//dstore10, dstore20, dstore11, dstore21. first num is the table second number is the word block
assign dload1 = table1[daddr.idx].data[daddr.blkoff];
assign dload2 = table2[daddr.idx].data[daddr.blkoff];
assign dstore10 = table1[daddr.idx].data[0];
assign dstore20 = table2[daddr.idx].data[0];
assign tag1 = table1[daddr.idx].tag;
assign tag2 = table2[daddr.idx].tag;
assign dstore11 = table1[daddr.idx].data[1];
assign dstore21 = table2[daddr.idx].data[1];
assign index = daddr.idx;

assign cdif.cctrans  = trans;
assign cdif.ccwrite = write;
// assign write = LRU[daddr.idx] ? table1[daddr.idx].valid : table2[daddr.idx].valid ;
// assign trans = LRU[daddr.idx] ? table1[daddr.idx].dirty : table2[daddr.idx].dirty;

always_ff @(posedge CLK or negedge nRST) begin
  if(!nRST) begin
    table1 <= 0;
    table2 <= 0;
    state <= TAG;
    // hit_count <= 0;
    i <=0;
    LRU <= 0;
    cdif.daddr <= 0;
    // cdif.cctrans<=0;
    // cdif.ccwrite<=0;
  end
  else begin
    table1 <= temptable1;
    table2 <= temptable2;
    state<=next_state;
    // hit_count <= hit_count_next;
    i<= ni;
    LRU <= nLRU;
    cdif.daddr <= ndaddr;
    // cdif.cctrans <= trans;
    // cdif.ccwrite <= write;  
  end
end

always_comb begin
  temptable1 = table1;
  temptable2 = table2;
  cdif.dREN=1'b0;
  cdif.dWEN =1'b0;
  dcif.dhit = 1'b0;
  dcif.dmemload = 32'b0;
  dcif.flushed =1'b0;
  next_state = state;
  // hit_count_next = hit_count;
  cdif.dstore = '0;
  ni = i;
  nLRU = LRU;
  ndaddr = cdif.daddr;
  write = 0;
  trans = 0;

  case (state) 
    TAG: begin
      ndaddr=32'b0;
      cdif.dstore=32'b0;
      if (dcif.halt) begin
        next_state = HALT;
        ni=0;
      end
      else if(dcif.dmemREN & (table1[daddr.idx].tag ==daddr.tag) & (table1[daddr.idx].valid)) begin
        dcif.dhit =1'b1;
        dcif.dmemload = dload1;
        next_state = TAG; 
        nLRU[daddr.idx]=1'b0;
      end
      else if(dcif.dmemREN & (table2[daddr.idx].tag==daddr.tag) & (table2[daddr.idx].valid)) begin
        dcif.dhit =1'b1;
        dcif.dmemload = dload2; 
        next_state = TAG; 
        nLRU[daddr.idx] =1'b1; 
      end
      else if (dcif.dmemWEN & (table1[daddr.idx].tag ==daddr.tag))begin
        if(!(table1[daddr.idx].dirty))begin
          if(daddr.blkoff==0) begin
            temptable1[daddr.idx].data[0] = dcif.dmemstore;
            temptable1[daddr.idx].valid = 1'b1;
            temptable1[daddr.idx].dirty =1'b1;
            trans=1;
            write=1;
            dcif.dhit=1'b1;
            next_state = TAG;
          end
          else if(daddr.blkoff==1) begin
            temptable1[daddr.idx].data[1] = dcif.dmemstore;
            temptable1[daddr.idx].valid = 1'b1;
            temptable1[daddr.idx].dirty =1'b1;
            trans=1;
            write=1;
            dcif.dhit=1'b1;
            next_state = TAG;
          end
        end
        else begin
          next_state = WB1;
          ndaddr = {tag1,index,1'b0,2'b00};
        end
      end
      else if(dcif.dmemWEN & (table2[daddr.idx].tag==daddr.tag)) begin
        if (!(table2[daddr.idx].dirty)) begin
          if (daddr.blkoff==0) begin
            temptable2[daddr.idx].data[0] = dcif.dmemstore;
            temptable2[daddr.idx].valid = 1'b1;
            temptable2[daddr.idx].dirty =1'b1;
            trans=1;
            write=1;
            dcif.dhit=1'b1;
            next_state = TAG;
          end
          else if (daddr.blkoff==1) begin
            temptable2[daddr.idx].data[1] = dcif.dmemstore;
            temptable2[daddr.idx].valid = 1'b1;
            temptable2[daddr.idx].dirty =1'b1;
            trans=1;
            write=1;
            dcif.dhit=1'b1;
            next_state = TAG;
          end
        end
        else begin  
          next_state = WB1;
          ndaddr = {tag2,index,1'b0,2'b00};
        end
      end
      else if((dcif.dmemWEN | dcif.dmemREN) & (LRU[daddr.idx]) & table1[daddr.idx].dirty) begin
        next_state= WB1;
        ndaddr = {tag1,index,1'b0,2'b00};
        // hit_count_next = hit_count -1; 
      end
      else if ((dcif.dmemWEN | dcif.dmemREN) & !(LRU[daddr.idx]) & table2[daddr.idx].dirty) begin
        next_state=WB1;
        ndaddr = {tag2,index,1'b0,2'b00};
        // hit_count_next = hit_count -1; 
      end
      else if ((dcif.dmemWEN | dcif.dmemREN) & (LRU[daddr.idx]) & !(table1[daddr.idx].dirty)) begin
        next_state=AL1;
        // hit_count_next = hit_count -1; 
      end
      else if ((dcif.dmemWEN | dcif.dmemREN) & !(LRU[daddr.idx]) & !(table2[daddr.idx].dirty)) begin
        next_state=AL1;
        // hit_count_next = hit_count -1; 
      end
      else if((saddr !='b0) & ((table1[saddr.idx].tag == saddr.tag) | (table2[saddr.idx] == saddr.tag))) begin
        next_state = SNOOP;
      end
      else begin 
        next_state =TAG;
      end
      if(next_state == AL1) begin
        if(daddr.blkoff == 0)
          ndaddr = daddr;
        else
          ndaddr = daddr - 3'b100;
      end
    end

    WB1: begin
      if((table1[daddr.idx].tag ==daddr.tag) & table1[daddr.idx].dirty & (cdif.dwait==0)) begin
        cdif.dstore = dstore10;
        // trans = 1;
        // write = 1;
        cdif.dWEN = 1'b1;
        next_state = WB2;
        ndaddr = {tag1,index,1'b1,2'b00};
      end
      else if( (table2[daddr.idx].tag==daddr.tag) & table2[daddr.idx].dirty & (cdif.dwait==0)) begin
        cdif.dstore = dstore20;
        // trans = 1;
        // write = 1;
        cdif.dWEN = 1'b1;
        next_state =  WB2; 
        ndaddr = {tag2,index,1'b1,2'b00};
      end
      else if((LRU[daddr.idx]) & table1[daddr.idx].dirty & (cdif.dwait==0)) begin
        cdif.dstore = dstore10;
        // trans = 1;
        // write = 1;
        cdif.dWEN = 1'b1;
        next_state = WB2;
        ndaddr = {tag1,index,1'b1,2'b00};
      end
      else if(!(LRU[daddr.idx]) & table2[daddr.idx].dirty & (cdif.dwait==0)) begin
        cdif.dstore = dstore20;
        // trans = 1;
        // write = 1;
        cdif.dWEN = 1'b1;
        next_state =  WB2; 
        ndaddr = {tag2,index,1'b1,2'b00};
      end
      else if (cdif.dwait) begin
        next_state = WB1;
        cdif.dWEN = 1'b1; 
      end
    end
    WB2:begin
      if((table1[daddr.idx].tag ==daddr.tag) & table1[daddr.idx].dirty & (cdif.dwait==0)) begin
        cdif.dstore = dstore11;
        cdif.dWEN = 1'b1;
        temptable1[daddr.idx].valid = 1'b0;
        temptable1[daddr.idx].dirty = 1'b0;
        trans = 0;
        write = 0;
        next_state = AL1; 
      end
      else if((table2[daddr.idx].tag==daddr.tag) & table2[daddr.idx].dirty & (cdif.dwait==0)) begin
        cdif.dstore = dstore21;
        trans = 0;
        write = 0;
        cdif.dWEN = 1'b1;
        temptable2[daddr.idx].valid = 1'b0;
        temptable2[daddr.idx].dirty = 1'b0;
        next_state = AL1; 
      end
      else if((LRU[daddr.idx]) & table1[daddr.idx].dirty & (cdif.dwait==0)) begin
        cdif.dstore = dstore11;
        trans = 0;
        write = 0;
        cdif.dWEN = 1'b1;
        temptable1[daddr.idx].valid = 1'b0;
        temptable1[daddr.idx].dirty = 1'b0;
        next_state = AL1; 
      end
      else if(!(LRU[daddr.idx]) & table2[daddr.idx].dirty & (cdif.dwait==0)) begin
        cdif.dstore = dstore21;
        trans = 0;
        write = 0;
        cdif.dWEN = 1'b1;
        temptable2[daddr.idx].valid = 1'b0;
        temptable2[daddr.idx].dirty = 1'b0;
        next_state = AL1; 
      end
      else if (cdif.dwait) begin
        next_state = WB2;
        cdif.dWEN = 1'b1; 
      end
      if(next_state == AL1) begin
        if(daddr.blkoff == 0)
          ndaddr = daddr;
        else
          ndaddr = daddr - 3'b100;
      end
    end
    AL1:begin
      if((table1[daddr.idx].tag ==daddr.tag) & !(table1[daddr.idx].dirty) & (cdif.dwait==0) )begin
        cdif.dREN = 1'b1;
        temptable1[daddr.idx].tag = daddr.tag;
        temptable1[daddr.idx].data[0] = cdif.dload;
        // trans = 0;
        // write = 0;
        next_state = AL2;
      end
      else if((table2[daddr.idx].tag==daddr.tag) & !(table2[daddr.idx].dirty) & (cdif.dwait==0))begin
        cdif.dREN = 1'b1;
        temptable2[daddr.idx].tag = daddr.tag;
        temptable2[daddr.idx].data[0] = cdif.dload;
        // trans = 0;
        // write = 0;
        next_state = AL2;
      end
      else if((LRU[daddr.idx]) & !(table1[daddr.idx].dirty) & (cdif.dwait==0))begin
        cdif.dREN = 1'b1;
        temptable1[daddr.idx].tag = daddr.tag;
        temptable1[daddr.idx].data[0] = cdif.dload;
        // trans = 0;
        // write = 0;
        next_state = AL2;
      end
      else if(!(LRU[daddr.idx]) & !(table2[daddr.idx].dirty) & (cdif.dwait==0))begin
        cdif.dREN = 1'b1;
        temptable2[daddr.idx].tag = daddr.tag;
        temptable2[daddr.idx].data[0] = cdif.dload;
        // trans = 0;
        // write = 0;
        next_state = AL2;
      end
      else if (cdif.dwait) begin
        next_state = AL1;
        cdif.dREN =1'b1; 
      end
      if(next_state == AL1) begin
        if(daddr.blkoff == 0)
          ndaddr = daddr;
        else
          ndaddr = daddr - 3'b100;
      end
      if (next_state == AL2) begin
        if(daddr.blkoff == 0)
          ndaddr = daddr+ 3'b100;
        else
          ndaddr = daddr ;
      end
      if(dcif.dmemWEN) begin
        trans=0;
        write=1;
        end
    end

    AL2:begin
      if((table1[daddr.idx].tag ==daddr.tag) & !(table1[daddr.idx].dirty) & (cdif.dwait==0))begin
        cdif.dREN = 1'b1;
        temptable1[daddr.idx].tag = daddr.tag;
        temptable1[daddr.idx].data[1] = cdif.dload;
        trans = 1;
        // write = 0;
        temptable1[daddr.idx].valid = 1'b1;
        next_state = TAG;
      end
      else if((table2[daddr.idx].tag==daddr.tag)  & !(table2[daddr.idx].dirty) & (cdif.dwait==0))begin
        cdif.dREN = 1'b1;
        temptable2[daddr.idx].tag = daddr.tag;
        temptable2[daddr.idx].data[1] = cdif.dload;
        trans = 1;
        // write = 0;
        temptable2[daddr.idx].valid = 1'b1;
        next_state = TAG;
      end
      else if((LRU[daddr.idx]) & !(table1[daddr.idx].dirty) & (cdif.dwait==0))begin
        cdif.dREN = 1'b1;
        temptable1[daddr.idx].tag = daddr.tag;
        temptable1[daddr.idx].data[1] = cdif.dload;
        trans = 1;
        // write = 0;
        temptable1[daddr.idx].valid = 1'b1;
        next_state = TAG;
      end
      else if(!(LRU[daddr.idx]) & !(table2[daddr.idx].dirty) & (cdif.dwait==0))begin
        cdif.dREN = 1'b1;
        temptable2[daddr.idx].tag = daddr.tag;
        temptable2[daddr.idx].data[1] = cdif.dload;
        trans = 1;
        // write = 0;
        temptable2[daddr.idx].valid = 1'b1;
        next_state = TAG;
      end
      else if (cdif.dwait) begin
        next_state = AL2;
        cdif.dREN =1'b1; 
      end
      if (next_state == AL2) begin
        if(daddr.blkoff == 0)
          ndaddr = daddr+ 3'b100;
        else
          ndaddr = daddr ;
      end
      if(dcif.dmemWEN) begin
        trans=0;
        write=1;
        end
    end
    HALT:begin
      if(i<8) begin
        if((table1[i].dirty == 1) & (cdif.dwait==0)) begin
          next_state = HALTWB1;
          trans = table1[i].valid;
          write = table1[i].dirty;
        end
        else if((table2[i].dirty == 1) & (cdif.dwait==0)) begin
          next_state = HALTWB1;
          trans = table2[i].valid;
          write = table2[i].dirty;
        end
        else
          ni = i+1;
        if((table1[i].dirty == 0) & (table2[i].dirty == 0) & (cdif.dwait==0)) begin
          temptable1[i] = 'b0;
          temptable2[i] = 'b0; 
        end
      end     
      if(i==8 & (cdif.dwait==0)) begin
        //next_state = HIT;
        next_state = HALT;
        dcif.flushed = 1'b1;
        // ndaddr= 32'h3100;
      end
      else if(cdif.dwait) begin
        next_state = HALT; 
      end

      if(next_state == HALTWB1) begin
        if ((table1[i].dirty == 1)) begin
          ndaddr = {table1[i].tag,3'(i),1'b0,2'b00};
        end
        else if((table2[i].dirty == 1)) begin
          ndaddr = {table2[i].tag,3'(i),1'b0,2'b00};
        end
      end            
    end
    HALTWB1: begin
      if ((table1[i].dirty == 1) & (cdif.dwait==0)) begin
        cdif.dstore = table1[i].data[0];
        trans = table1[i].valid;
        write = table1[i].dirty;
        cdif.dWEN = 1'b1;
        next_state = HALTWB2;
      end
      else if((table2[i].dirty == 1) & (cdif.dwait==0)) begin
        cdif.dstore = table2[i].data[0];
        trans = table2[i].valid;
        write = table2[i].dirty;
        cdif.dWEN = 1'b1;
        next_state = HALTWB2;
      end
      else if (cdif.dwait) begin
        next_state = HALTWB1;
        cdif.dWEN = 1'b1;
        if (table1[i].dirty == 1) 
          cdif.dstore = table1[i].data[0];
        else if (table2[i].dirty == 1)
          cdif.dstore = table2[i].data[0];
      end

      if(next_state == HALTWB1) begin
        if ((table1[i].dirty == 1)) begin
          ndaddr = {table1[i].tag,3'(i),1'b0,2'b00};
          trans = table1[i].valid;
          write = table1[i].dirty;
        end
        else if((table2[i].dirty == 1)) begin
          ndaddr = {table2[i].tag,3'(i),1'b0,2'b00};
          trans = table2[i].valid;
          write = table2[i].dirty;
        end
      end

      if(next_state == HALTWB2) begin
        if ((table1[i].dirty == 1) & (cdif.dwait==0)) begin
          ndaddr = {table1[i].tag,3'(i),1'b1,2'b00};
        end
        else if ((table2[i].dirty == 1 )& (cdif.dwait==0)) begin
          ndaddr = {table2[i].tag,3'(i),1'b1,2'b00};
        end
      end

    end
    HALTWB2: begin
      if ((table1[i].dirty == 1) & (cdif.dwait==0)) begin
        cdif.dstore = table1[i].data[1];
        trans = table1[i].valid;
        write = table1[i].dirty;
        cdif.dWEN = 1'b1;
        temptable1[daddr.idx].valid = 1'b0;
        temptable1[i].dirty = 1'b0;
        next_state = HALT;
      end
      else if ((table2[i].dirty == 1 )& (cdif.dwait==0)) begin
        cdif.dstore = table2[i].data[1];
        trans = table2[i].valid;
        write = table2[i].dirty;
        cdif.dWEN = 1'b1;
        temptable2[daddr.idx].valid = 1'b0;
        temptable2[i].dirty = 1'b0;
        next_state = HALT;
      end
      else if (cdif.dwait) begin
        next_state = HALTWB2;
        cdif.dWEN = 1'b1;
        if (table1[i].dirty == 1) begin
          trans = table1[i].valid;
          write = table1[i].dirty;
          cdif.dstore = table1[i].data[1];end
        else if (table2[i].dirty == 1) begin
          cdif.dstore = table2[i].data[1];
          trans = table2[i].valid;
          write = table2[i].dirty; end
      end
      if(next_state == HALTWB2) begin
        if ((table1[i].dirty == 1) & (cdif.dwait==0)) begin
          ndaddr = {table1[i].tag,3'(i),1'b1,2'b00};
          trans = table1[i].valid;
          write = table1[i].dirty;
        end
        else if ((table2[i].dirty == 1 )& (cdif.dwait==0)) begin
          ndaddr = {table2[i].tag,3'(i),1'b1,2'b00};
          trans = table2[i].valid;
          write = table2[i].dirty;
        end
      end
    end
    // HIT: begin
    //   cdif.dWEN = 1'b1;
    //   cdif.dstore = hit_count;
    //   if(cdif.dwait==0) begin
    //     next_state = FLUSH;end
    //   else if(cdif.dwait)
    //     next_state = HIT;
    //   end
    // FLUSH: begin
    //   if(cdif.daddr == 32'h3100 & (cdif.dwait==0)) begin
    //     temptable1 = 'b0;
    //     temptable2 = 'b0;
    //     dcif.flushed = 1'b1; end
    //   else if(cdif.dwait)
    //     next_state = FLUSH;
    // end
    SNOOP: begin//add - check for ccwait
      if(ccif.ccwait) begin
        if(table1[saddr.idx].tag ==saddr.tag) begin
          trans = table1[saddr.idx].valid;
          write = table1[saddr.idx].dirty;
          end
        else if(table2[saddr.idx].tag ==saddr.tag) begin
          trans = table2[saddr.idx].valid;
          write = table2[saddr.idx].dirty;
          end
      end
      
      //invalidate if tag matches and ccinv =1
      if(ccif.ccinv ==1)begin
        if((table1[saddr.idx].tag == saddr.tag)) begin
          temptable1[saddr.idx].valid = 0;
          temptable1[saddr.idx].dirty = 0;
          trans=0;
          write=0;
        end
        else if((table2[saddr.idx].tag == saddr.tag)) begin
          temptable2[saddr.idx].valid = 0;
          temptable2[saddr.idx].dirty = 0;
          trans=0;
          write=0;
        end
        next_state = TAG;
      end

      //if dirty go to writeback to memory
      else if(table1[saddr.idx].dirty | table2[saddr.idx].dirty) begin
        next_state = SWB1;
        ndaddr = {saddr.tag,saddr.idx,1'b0,2'b00};end
      else begin
        next_state = TAG;
      end

    end
    
    SWB1: begin
      if((table1[saddr.idx].tag ==saddr.tag) & table1[saddr.idx].dirty & table1[saddr.idx].valid & (cdif.dwait==0)) begin
        cdif.dstore = table1[saddr.idx].data[0];
        trans = table1[saddr.idx].valid;
        write =  table1[saddr.idx].dirty;
        cdif.dWEN = 1'b1;
        next_state = SWB2;
        ndaddr = {saddr.tag,saddr.idx,1'b0,2'b00};
      end
      else if((table2[saddr.idx].tag==saddr.tag) & table2[saddr.idx].dirty & table2[saddr.idx].valid & (cdif.dwait==0)) begin
        cdif.dstore = table2[saddr.idx].data[0];
        trans = table2[saddr.idx].valid;
        write =  table2[saddr.idx].dirty;
        cdif.dWEN = 1'b1;
        next_state =  SWB2; 
        ndaddr = {saddr.tag,saddr.idx,1'b0,2'b00};
      end
      else if(cdif.dwait)begin
        cdif.dWEN=1;
        next_state = SWB1;
        if((table1[saddr.idx].tag ==saddr.tag) & table1[saddr.idx].dirty & table1[saddr.idx].valid) begin
          cdif.dstore = table1[saddr.idx].data[0];
          trans = table1[saddr.idx].valid;
          write =  table1[saddr.idx].dirty;end
        else if((table2[saddr.idx].tag==saddr.tag) & table2[saddr.idx].dirty & table2[saddr.idx].valid ) begin
          cdif.dstore = table2[saddr.idx].data[0];
          trans = table2[saddr.idx].valid;
          write =  table2[saddr.idx].dirty;end
        ndaddr = {saddr.tag,saddr.idx,1'b0,2'b00};
      end
    end
    SWB2: begin
      if((table1[saddr.idx].tag ==saddr.tag) & table1[saddr.idx].dirty &(cdif.dwait==0)) begin
        cdif.dstore = table1[saddr.idx].data[1];
        trans = table1[saddr.idx].valid;
        write = table1[saddr.idx].dirty;
        cdif.dWEN = 1'b1;
        next_state = TAG;
        temptable1[saddr.idx].dirty = 1'b0;
        ndaddr = {saddr.tag,saddr.idx,1'b1,2'b00};
      end
      else if((table2[saddr.idx].tag==saddr.tag) & table2[saddr.idx].dirty & (cdif.dwait==0)) begin
        cdif.dstore = table2[saddr.idx].data[1];
        trans = table2[saddr.idx].valid;
        write = table2[saddr.idx].dirty;
        cdif.dWEN = 1'b1;
        next_state =  TAG; 
        temptable2[saddr.idx].dirty = 1'b0;
        ndaddr = {saddr.tag,saddr.idx,1'b1,2'b00};
      end
      else if (cdif.dwait)begin
        cdif.dWEN=1;
        next_state = SWB2;
        if((table1[saddr.idx].tag ==saddr.tag) & table1[saddr.idx].dirty)begin
          cdif.dstore = table1[saddr.idx].data[1];
          trans = table1[saddr.idx].valid;
          write =  table1[saddr.idx].dirty;
          ndaddr = {saddr.tag,saddr.idx,1'b1,2'b00};
          end
        else if((table2[saddr.idx].tag==saddr.tag) & table2[saddr.idx].dirty) begin
          cdif.dstore = table2[saddr.idx].data[1];
          trans = table2[saddr.idx].valid;
          write =  table2[saddr.idx].dirty;
          ndaddr = {saddr.tag,saddr.idx,1'b1,2'b00};end
      end
    end
  endcase
  //add - ccwait logic
  //if snoopaddr !=0 tag matching and ccwait =1
  if(cdif.ccwait) begin
    if((saddr !='b0) & (table1[saddr.idx].tag == saddr.tag) & (next_state != SNOOP) & (next_state != SWB1) & (next_state != SWB2))begin
      next_state = SNOOP;
      trans = table1[saddr.idx].valid;
      write = table1[saddr.idx].dirty;
    end
    else if((saddr !='b0) & (table2[saddr.idx].tag == saddr.tag) & (next_state != SNOOP) & (next_state != SWB1) & (next_state != SWB2))begin
      next_state = SNOOP;
      trans = table2[saddr.idx].valid;
      write = table2[saddr.idx].dirty;
    end
    //if snoopaddr != 0, tag  not matching cctrans and ccwrite =0
    else if((saddr !='b0) & ((table1[saddr.idx].tag != saddr.tag)| (table2[saddr.idx].tag != saddr.tag))  & (next_state != SNOOP) & (next_state != SWB1) & (next_state != SWB2)) begin
      next_state = TAG;
      trans = 'b0;
      write = 'b0;
    end
  end
  // if(dcif.dhit == 1'b1)
  //   hit_count_next = hit_count+1;
  end

endmodule