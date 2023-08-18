module vendingmachine(clk,coin1,coin2,select,buy,load,money,products,outofstock);


input clk; input coin1; //25 cents
input coin2; //1 dollar (100 cents)
input [3:0] select; input buy; input [3:0] load;
output reg [11:0] money=0; output reg [3:0] products=0;
output reg [3:0] outofstock=0;
reg coin1_prev=0,coin2_prev=0; reg buy_prev=0;
reg [3:0] stock1=4'b1010; reg [3:0] stock2=4'b1010;
reg [3:0] stock3=4'b1010; reg [3:0] stock4=4'b1010;


always @ (posedge clk) begin
coin1_prev <= coin1; coin2_prev <= coin2; buy_prev <= buy;
if (coin1_prev == 1'b0 && coin1 == 1'b1) money <= money + 12'd25;
else if (coin2_prev == 1'b0 && coin2 == 1'b1) money <= money + 12'd100;
else if (buy_prev == 1'b0 && buy == 1'b1) begin
case (select)
4'b0001: if (money >= 12'd25 && stock1 > 0) begin
products[0] <= 1'b1; stock1 <= stock1 - 1'b1; money <= money - 12'd25;
end
4'b0010: if (money >= 12'd75 && stock2 > 0) begin
products[1] <= 1'b1; stock2 <= stock2 - 1'b1; money <= money - 12'd75;
end
4'b0100: if (money >= 12'd150 && stock3 > 0) begin products[2] <= 1'b1; stock3 <= stock3 - 1'b1; money <= money -
12'd150; end
4'b1000: if (money >= 12'd200 && stock4 > 0) begin products[3] <= 1'b1; stock4 <= stock4 - 1'b1; money <= money -
12'd200; end
endcase
end
else if (buy_prev == 1'b1 && buy == 1'b0 || buy_prev == 1'b1 && buy == 1'b1 || buy_prev == 1'b0 && buy == 1'b0 ) begin products[0] <= 1'b0; products[1] <= 1'b0; products[2] <= 1'b0; 
products[3] <= 1'b0; end
else begin
if (stock1 == 4'b0) outofstock[0] <= 1'b1; else outofstock[0] <= 1'b0;
if (stock2 == 4'b0) outofstock[1] <= 1'b1; else outofstock[1] <= 1'b0;
if (stock3 == 4'b0) outofstock[2] <= 1'b1; else outofstock[2] <= 1'b0;
if (stock4 == 4'b0) outofstock[3] <= 1'b1; else outofstock[3] <= 1'b0;


case (load)
4'b0001: stock1 <= 4'b1111;
4'b0010: stock2 <= 4'b1111;
4'b0100: stock3 <= 4'b1111;
4'b1000: stock4 <= 4'b1111;
endcase
end
end
endmodule