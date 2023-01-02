module machinetb();
reg CLK,CANCEL,COIN;
reg [1:0]SEL;
wire [1:0]PRODUCTOUT;
wire [2:0]CHANGE;

machine dut(.clk(CLK),.cancel(CANCEL),.sel(SEL),.productout(PRODUCTOUT),.change(CHANGE),.coin(COIN));
initial
begin
CLK=0;
forever CLK=#5~CLK;
end
initial
begin
#5 
CANCEL=0; COIN=0; SEL=00;
#5
CANCEL=0; COIN=1; SEL=00;
#5
$stop;
end
endmodule
