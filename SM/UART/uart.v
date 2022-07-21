// SM : Task 2 B : UART
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design UART Transmitter.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//UART Transmitter design
//Input   : clk_50M : 50 MHz clock
//Output  : tx : UART transmit output

//////////////////DO NOT MAKE ANY CHANGES IN MODULE//////////////////
module uart(
	input clk_50M,	//50 MHz clock
	output tx		//UART transmit output
);
////////////////////////WRITE YOUR CODE FROM HERE////////////////////

wire clk;
clock clk1(clk_50M, clk);



parameter  idle=4'b0000, 
  start=4'b0001,
  
  d1  =4'b0010,
  d2 = 4'b0011,
  d3 = 4'b0100,
  d4 = 4'b0101,
  d5 = 4'b0110,
  d6 = 4'b0111,
  d7 = 4'b1000,
  d8 = 4'b1001;
    
parameter s1 = 4'b1010, s2 = 4'b1011;
reg [3:0] c_state = 0, n_state = 0; 
 // to store a copy of input data

reg out;

assign tx = out;

reg [7:0] S = 8'b01010011;
reg [7:0] M = 8'b01001101;
reg [7:0] zero = 8'b00110000;
reg [7:0] two = 8'b00110010;

reg [7:0] counter = 0;

reg [7:0] count = 0;

always @(posedge clk)
begin

 c_state <= n_state; // otherwise, next state
end 

always @(c_state)
begin
	case (c_state)
		default : begin
		c_state <=idle;
		n_state <= idle;
		end
		
		idle : begin
		out <= 1;
		if (count < 4) begin
		n_state <= start; end
		end
		
		start: begin
		if (count < 4 ) begin
		out <= 0; 
		n_state <= d1; end
		
		end
		
		d1 : begin
		if (count == 0) begin out <= S[0]; end
	   if (count == 1) begin out <= M[0]; end
		if (count == 2) begin out <= zero[0]; end
		if (count == 3) begin out <= two[0]; end	
		
		 n_state <= d2;
      end
		
		d2 : begin
		 if (count == 0) begin out <= S[1]; end
	   if (count == 1) begin out <= M[1]; end
		if (count == 2) begin out <= zero[1]; end
		if (count == 3) begin out <= two[1]; end	
		 n_state <= d3;
      end
		
		d3 : begin
		 if (count == 0) begin out <= S[2]; end
	   if (count == 1) begin out <= M[2]; end
		if (count == 2) begin out <= zero[2]; end
		if (count == 3) begin out <= two[2]; end	
		 n_state <= d4;
      end
		
		d4 : begin
		 if (count == 0) begin out <= S[3]; end
	   if (count == 1) begin out <= M[3]; end
		if (count == 2) begin out <= zero[3]; end
		if (count == 3) begin out <= two[3]; end	
		 n_state <= d5;
      end
		
		d5 : begin
		 if (count == 0) begin out <= S[4]; end
	   if (count == 1) begin out <= M[4]; end
		if (count == 2) begin out <= zero[4]; end
		if (count == 3) begin out <= two[4]; end	
		 n_state <= d6;
      end
		
		d6 : begin
		 if (count == 0) begin out <= S[5]; end
	   if (count == 1) begin out <= M[5]; end
		if (count == 2) begin out <= zero[5]; end
		if (count == 3) begin out <= two[5]; end	
		 n_state <= d7;
      end
		
		d7 : begin
		 if (count == 0) begin out <= S[6]; end
	   if (count == 1) begin out <= M[6]; end
		if (count == 2) begin out <= zero[6]; end
		if (count == 3) begin out <= two[6]; end	
		 n_state <= d8;
      end
		
		d8 : begin
		 if (count == 0) begin out <= S[7]; end
	   if (count == 1) begin out <= M[7]; end
		if (count == 2) begin out <= zero[7]; end
		if (count == 3) begin out <= two[7]; end	
		 n_state <= s1;
      end
		
		s1: begin
		out <= 1;
		n_state <= s2;
		
		end
		
		s2: begin
		out <= 1;
		
		if(count < 4) begin
		count <= count + 1;
		n_state <= start;
		end
		if(count == 4) begin
		n_state <= idle;
		end
		end
		
	endcase
	
	
end





////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////