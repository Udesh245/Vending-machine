module machine(cancel,sel,productout,change,coin,clk);
input clk,cancel,coin;
input [1:0]sel;
output reg[1:0] productout;
output reg[2:0] change;

parameter change1=3'b001, change2=3'b010, change3=3'b100, nochange=3'b000;
parameter productA=2'b00, productB=2'b01, productC=2'b10, productD=2'b11;
parameter coin5=1'b0, coin10=1'b1;
parameter five=4'b1010, ten=4'b0001, fifteen=4'b0010, twenty=4'b1101;
parameter product1A=4'b0000, product1B=4'b0100, product1C=4'b1000, product1D=4'b0110,
          product2A=4'b1111, product2B=4'b0011, product2C=4'b1001, product3A=4'b1100,
          product3B=4'b1110, product4A=4'b0111, idle=4'b0101;

reg[3:0] state,next_state;

always @(posedge clk or posedge cancel)
begin
    if (cancel==1'b1)
    state<=idle;
    else
    state<=next_state;
end

//next_statelogic

always @(*)
begin
    if (state==product1A) next_state=idle;
    if (state==product1B) next_state=idle;
    if (state==product1C) next_state=idle;
    if (state==product1D) next_state=idle;
    
    if (state==product2A) next_state=idle;
    if (state==product2B) next_state=idle;
    if (state==product2C) next_state=idle;
    
    if (state==product3A) next_state=idle;
    if (state==product3B) next_state=idle;
    
    if (state==product4A) next_state=idle;
    

    if (state==five)
        begin
            if (sel==2'b00)  next_state=product1A;
            else if (cancel==1'b1) next_state=idle; 
            else if (coin==coin10) next_state=fifteen;
            else if (coin==coin5) next_state=ten; 
            else if (((coin==coin5) || (coin==coin10)) && (sel==00)) next_state=product1A;
            else next_state=five;
        end

     if (state==ten)
        begin
            if (sel==2'b01) next_state=product2A;
            else if (sel==2'b00) next_state=product1B;
            else if (cancel==1'b1) next_state=idle; 
            else if (coin==coin10) next_state=twenty;
            else if (coin==coin5) next_state=fifteen;
            else if (((coin==coin5) || (coin==coin10)) && (sel==00)) next_state=product1B;
            else if (((coin==coin5) || (coin==coin10)) && (sel==01)) next_state=product2A; 
            else next_state=ten;
        end

      if (state==fifteen)
        begin
            if (sel==2'b00) next_state=product1C;
            else if (sel==2'b01) next_state=product2B;
            else if (sel==2'b10) next_state=product3A;
            else if (cancel==1'b1) next_state=idle; 
            else if (coin==coin10) next_state=twenty;
            else if (coin==coin5) next_state=twenty;
            else if (((coin==coin5) || (coin==coin10)) && (sel==00)) next_state=product1C;
            else if (((coin==coin5) || (coin==coin10)) && (sel==01)) next_state=product2B;
            else if (((coin==coin5) || (coin==coin10)) && (sel==10)) next_state=product3A;
            else next_state=fifteen;
        end

      if (state==twenty)
        begin
            if (sel==2'b00) next_state=product1D;
            else if (sel==2'b01) next_state=product2C;
            else if (sel==2'b10) next_state=product3B;
            else if (sel==2'b11) next_state=product4A;
            else if (cancel==1'b1) next_state=idle; 
            else if (coin==coin10) next_state=twenty;
            else if (coin==coin5) next_state=twenty;
            else if (((coin==coin5) || (coin==coin10)) && (sel==00)) next_state=product1D;
            else if (((coin==coin5) || (coin==coin10)) && (sel==01)) next_state=product2C;
            else if (((coin==coin5) || (coin==coin10)) && (sel==10)) next_state=product3B;
            else if (((coin==coin5) || (coin==coin10)) && (sel==11)) next_state=product4A;
            else next_state=twenty;
        end

       if (state==idle)
        begin
            if (coin==coin5) next_state=five;
            else if (coin==coin10) next_state=ten;
            else next_state=idle;
        end
        
        
    end

///outputlogic

always @(*)
begin
        
        if (state==product1A)
        begin productout=productA; change=nochange; end
        
        if (state==product1B)
        begin productout=productA; change=change1; end
        
        if (state==product1C)
        begin productout=productA; change=change2; end
        
        if (state==product1D)
        begin productout=productA; change=change3; end  
        
        if (state==product2A)
        begin productout=productB; change=nochange; end  
        
        if (state==product2B)
        begin productout=productB; change=change1; end  
        
        if (state==product2C)
        begin productout=productB; change=change2; end  
        
        if (state==product3A)
        begin productout=productC; change=nochange; end  
        
        if (state==product3B)
        begin productout=productC; change=change1; end
        
        if (state==product4A)
        begin productout=productD; change=nochange; end
        
        if (state==idle)
        begin productout=2'bxx; change=3'bxxx; end
        
        if (state==five)
        begin productout=2'bxx; change=3'bxxx; end
        
        if (state==ten)
        begin productout=2'bxx; change=3'bxxx; end
        
        if (state==fifteen)
        begin productout=2'bxx; change=3'bxxx; end
        
        if (state==twenty)
        begin productout=2'bxx; change=3'bxxx; end
               
    end

endmodule