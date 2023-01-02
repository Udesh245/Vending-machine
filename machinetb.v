module machinetb();
reg CLK,CANCEL,COIN;
reg [1:0]SEL;
wire [1:0]PRODUCTOUT;
wire [2:0]CHANGE;

machine dut(.cancel(CANCEL),.sel(SEL),.productout(PRODUCTOUT),.change(CHANGE),.coin(COIN),.clk(CLK));
initial
begin
CLK=0;
forever CLK=#5~CLK;
end
initial
begin
#3 COIN=1'b0; CANCEL=1'b1;
#1 CANCEL=1'b0;
#6 SEL=2'b00;
#10 SEL=2'bxx;
#10 COIN=1'b1;
#10 SEL=2'b00;
#10 SEL=2'bxx;
#20 COIN=1'b0;
#10 SEL=2'b01;
#10 SEL=2'bxx;
#10 COIN=1'b1;
#20 SEL=2'b10;
#10 SEL=2'bxx;
#10
$stop;
end
endmodule
