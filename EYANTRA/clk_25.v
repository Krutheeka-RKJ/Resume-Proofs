module clk_25(
input clk,
output clk_25M);

reg [9:0] counter_out = 0 ;

reg val = 0;

always @(negedge clk)
begin
	if (counter_out < 19 & val == 1) begin
	counter_out <= counter_out + 1;
	end
	
	else begin
	counter_out <= 0;
	end
	val <= 1;
end

assign clk_25M = (counter_out < 10 ) ? 0:1;

endmodule
