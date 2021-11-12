i<=0;

if(dcif.halt & ~(dcif.flushed) & i<8) begin
      if((table1[i].dirty == 0) & (table2[i].dirty == 0))
        i<=i+1;

end

HALT:begin
        if(dcif.halt)begin
          if(i<8) begin
            // if((table1[i].dirty == 1)  | (table2[i].dirty == 1))
            // next_state = HALTWB1;
            if((table1[i].dirty == 0) & (table2[i].dirty == 0)) begin
              temptable1[i] = 'b0;
              temptable2[i] = 'b0;
              end
            else begin
              next_state = HALTWB1;
              break; 
            end
          end     
          else if(i==8) begin
            next_state = HIT;end 
          end            
        end