module testbench;
reg coin1,coin2,buy,clk;
reg [3:0] select;
reg [3:0]load;
wire [11:0] money;
wire [3:0] products;
wire [3:0] outofstock;

initial
clk=1'b0;
always 
#5 clk=~clk;

vendingmachine dut(clk,coin1,coin2,select,buy,load,money,products,outofstock);

initial
begin
coin1=0;
coin2=0;select=4'd0;buy=0;load=4'd0;
end
initial 
begin

$monitor("coin1=%b,coin2=%b,select=%h,buy=%b,load=%h,money=%h,products=%h,outofstck=%h", coin1,coin2,select,buy,load,money,products,outofstock );
#5 coin1=1'b1;
#3 coin1=1'b0;
#5 coin2=1'b1;
#3 coin2=1'b0;
#3 select=4'd4;
#5 coin1=1'b1;
#3 coin1 =1'b0;
#7 coin2=1'b1;

#3 coin2=1'b0;
#5 buy=1'b1;
#6 select = 4'd2;
#6 buy = 1'b1;


 
end

initial 
#10000 $finish;
endmodule