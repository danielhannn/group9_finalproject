//do not modify this module

module clk_div(
input clk,
input reborn,
output reg clk_div
);

reg [25:0] cnt;

always@(posedge clk or posedge reborn) 
begin
	if (reborn) 
		cnt<=26'd0;
	else if(cnt==62500000-1)
		cnt<=26'd0;
	else	
		cnt<=cnt+1;
end

always@(posedge clk or posedge reborn)
begin
	if(reborn)
		clk_div<=1'b0;
	else if(cnt==31250000-1)
		clk_div<=~clk_div;
end

endmodule
