module clock(

input clk_50M,	//50 MHz clock
	output clk		//UART transmit output
);

reg [9:0] counter_out = 0 ;



reg val = 0;

//integer counter1 = 0;
//reg [7:0] counter2 = 0;
//reg out;
//
//reg [10:0] S = "01100101011";
//reg [10:0] M = "01011001011";
//reg [10:0] zero = "00000000011";
//reg [10:0] two = "00100000011";


always @ (posedge clk_50M)
begin
 
	if (counter_out < 433  & val == 1) begin
	counter_out <= counter_out + 1;
	end
	
	else 
	begin counter_out <= 0; end

	
val <= 1;
end

assign clk  = (counter_out < 232 ) ? 1:0;

endmodule
