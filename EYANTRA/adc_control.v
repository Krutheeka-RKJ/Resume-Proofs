// SM : Task 2 A : ADC
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design ADC Controller.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//ADC Controller design
//Inputs  : clk_50 : 50 MHz clock, dout : digital output from ADC128S022 (serial 12-bit)
//Output  : adc_cs_n : Chip Select, din : Ch. address input to ADC128S022, adc_sck : 2.5 MHz ADC clock,
//				d_out_ch5, d_out_ch6, d_out_ch7 : 12-bit output of ch. 5,6 & 7,
//				data_frame : To represent 16-cycle frame (optional)

//////////////////DO NOT MAKE ANY CHANGES IN MODULE//////////////////
module adc_control(
	input  clk_50,				//50 MHz clock
	input  dout,				//digital output from ADC128S022 (serial 12-bit)
	output adc_cs_n,			//ADC128S022 Chip Select
	output din,					//Ch. address input to ADC128S022 (serial)
	output adc_sck,			//2.5 MHz ADC clock
	output [11:0]d_out_ch5,	//12-bit output of ch. 5 (parallel)
	output [11:0]d_out_ch6,	//12-bit output of ch. 6 (parallel)
	output [11:0]d_out_ch7,	//12-bit output of ch. 7 (parallel)
	output [1:0]data_frame	//To represent 16-cycle frame (optional)
);
	
////////////////////////WRITE YOUR CODE FROM HERE////////////////////
wire clk;
clk_25 clk1(clk_50, clk);
/////////////////////////////// din ////////////////////////////
assign adc_sck = clk;
assign adc_cs_n = 0;
reg [7:0] counter = 0;
reg [7:0] count = 0;

parameter s1=4'b0000, 
  s2=4'b0001,
  bit1  =4'b0010,
  bit2 = 4'b0011,
  bit3 = 4'b0100,
  end1 = 4'b0101;
reg [3:0] state = 0; // n_state = 0;
reg out;

assign din = out;

always @(negedge clk)
begin
	case(state)
		default: begin
		
		state <=s1;
		
		out <= 0;
		
		end
		
		s1 : begin
		if(count < 3) begin
		out <=0;
		state <= s2;
		end
		
		else begin
		out<= 0;
		end
		
		end
		
		s2: begin
		out <= 0; 
		state <= bit1;
		end
		
		bit1: begin
		if (count == 0) begin out <= 1; end
		if (count == 1) begin out <= 1; end
		if (count == 2) begin out <= 1; end
		state <= bit2;
		end
		
		bit2: begin
		if (count == 0) begin out <= 0;  end
		if (count == 1) begin out <= 1;  end
		if (count == 2) begin out <= 1;  end
		state <= bit3;
		end
		
		bit3: begin 
		if (count == 0) begin out <= 1;  end
		if (count == 1) begin out <= 0;  end
		if (count == 2) begin out <= 1;  end
		state <= end1;
		end
		
		end1: begin
		if(counter < 10) begin
		counter <= counter + 1;
		out <= 0;
		state <= end1;
		end
		else begin 
		out <= 0;
		counter <=0;
		state <= s1;
		count <= count + 1;
		end
		end
		
		
		endcase
		end
		
///////////// data frame /////////////////

reg [1:0] data;

reg [7:0] count1 = 0;
assign data_frame = data;

always@(negedge clk)
begin

if (count1 < 16) begin
	count1 <= count1 + 1;
	data <= 00;
	
	end
if (count1 > 15 && count1 < 32 ) begin
	count1 <= count1 + 1;
	data <= 01;
	end
if (count1 >31 && count1 < 48) begin
	count1 <= count1 + 1;
	data <= 10;
	end
if (count1 >47) begin
data <= 11;
end

end

////////////doutchX//////////

reg [7:0] count2 = 0;
integer id1 = 0;
integer id2 = 0;
integer id3 = 0;
reg [11:0] doutch7_n;
reg [11:0] doutch7;
reg [11:0] doutch5_n;
reg [11:0] doutch5;
reg [11:0] doutch6_n;
reg [11:0] doutch6;

assign d_out_ch7 = doutch7;

assign d_out_ch6 = doutch6;

assign d_out_ch5 = doutch5;

always @(posedge clk) begin
	
	if(count2 < 16 ) begin
	count2 <= count2 + 1;
		if (count2 > 3) begin
			doutch7_n[11-id1] <= dout;
			
			id1 <=id1 + 1;
			end
		
		end
		
		if(count2 > 15 && count2 < 32) begin
		
		count2 <= count2 + 1;
		if(count2 > 19) begin
			doutch5_n[11-id2] <= dout;
			id2 <= id2 + 1;
			end
		
	end
		
	if (count2 >31 && count2 < 48) begin
		count2 <= count2 + 1;
		if(count2 > 35) begin
			doutch6_n[11-id3] <= dout;
			id3 <= id3 + 1;
			end
		
			
	end
	
end
reg [7:0] count3 = 0;
always @(negedge clk) begin

	if(count3 < 16) begin
	doutch7 <= 000000000000;
	doutch6 <= 000000000000;
	doutch5 <= 000000000000;
	count3 <= count3 + 1;
	end
	
	if(count3 < 32 && count3 > 15) begin
	doutch7 <= doutch7_n;
	doutch6 <= 000000000000;
	doutch5 <= 000000000000;
	count3 <= count3 + 1;
	end
	
	if(count3 > 31 && count3 < 48) begin
	doutch7 <= doutch7_n;
	doutch5 <= doutch5_n;
	doutch6 <= 000000000000;
	count3 <= count3 + 1;
	end
	
	if (count3 >47) begin
	doutch7 <= doutch7_n;
	doutch5 <= doutch5_n;
	doutch6 <= doutch6_n;
	count3 <= count3 + 1;
	end
	
end	

////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////