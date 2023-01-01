module machine(cancel,sel,productout,change,coin,clk);
input clk,cancel,coin;
input [1:0]sel;
  output reg[1:0] productout;
  output reg[2:0] change;

parameter change0=001, change1=010, change2=100;
parameter productA=00, productB=01, productC=10, productD=11;
parameter coin5=0, coin10=1;
parameter five=000, ten=001, fifteen=100, twenty=111;
parameter product1=000, product2=010, product3=100, product4=110, idle=011, ret=111;

reg[2:0] state,next_state;
reg [1:0]product;

always @(posedge clk)
begin
    if (cancel==1)
    state<=idle;
    else
    state<=next_state;
end


//next_statelogic


always @(*)
begin
    if (state==product1) next_state<=idle;
    if (state==product2) next_state<=idle;
    if (state==product3) next_state<=idle;
    if (state==product4) next_state<=idle;

    if (state==five)
        begin
            if (sel==00)  next_state<=product1;
            if (cancel==1) next_state<=ret; 
            if (coin==coin10) next_state<=fifteen;
            if (coin==coin5) next_state<=ten; 
        end

     if (state==ten)
        begin
            if (sel==01) next_state<=product2;
            if (sel==00) next_state<=product1;
            if (cancel==1) next_state<=ret; 
            if (coin==coin10) next_state<=twenty;
            if (coin==coin5) next_state<=fifteen;
        end

      if (state==fifteen)
        begin
            if (sel==00) next_state<=product1;
            if (sel==01) next_state<=product2;
            if (sel==10) next_state<=product3;
            if (cancel==1) next_state<=ret; 
            if (coin==coin10) next_state<=twenty;
            if (coin==coin5) next_state<=twenty;
        end

      if (state==twenty)
        begin
            if (sel==00) next_state<=product1;
            if (sel==01) next_state<=product2;
            if (sel==10) next_state<=product3;
            if (sel==11) next_state<=product4;
            if (cancel==1) next_state<=ret; 
            if (coin==coin10) next_state<=twenty;
            if (coin==coin5) next_state<=twenty;
        end

      if (state==ret)  next_state<=idle;

       if (state==idle)
        begin
            if (coin==coin5) next_state<=five;
            if (coin==coin10) next_state<=ten;
        end
    end

///outputlogic

always @(*)
begin
    if (state==five)
    begin
          if (sel==00) productout<=productA;
          end

        if (state==ten)
        begin
            if (sel==00) begin productout<=productA;  change<=change1; end
            if (sel==01) productout<=productB;
        end

        if (state==fifteen)
        begin
            if (sel==00) begin productout<=productA;  change<=change2; end
            if (sel==01) begin productout<=productB;  change<=change1; end
            if (sel==10) productout<=productC;
        end

        if (state==twenty)
        begin
            if (sel==00) begin productout<=productA;  change<=change2; end
            if (sel==01) begin productout<=productB;  change<=change1; end
            if (sel==10) begin productout<=productC;  change<=change0; end
            if (sel==11) productout<=productD;
        end
        
        if (state==idle) productout<=0;
    end

endmodule