module uart1(

input clk,
output tx);

parameter  idle=3'b000, 
  start=3'b001,
  
  d1 = 3'b010;
    
parameter s1 = 3'b011;
reg [2:0] c_state = 0, n_state = 0; 
 // to store a copy of input data

reg out;

assign tx = out;

reg [7:0] S = 8'b11001010;
reg [7:0] M = 8'b10110010;
reg [7:0] zero = 8'b00000000;
reg [7:0] two = 8'b01000000;

reg [7:0] counter = 0;
reg [2:0] bitIdx = 0;
reg [2:0] idx;

assign idx = bitIdx;

always @(posedge clk)
begin

 c_state <= n_state; // otherwise, next state
end 

always @(posedge clk, c_state)
begin
	case (c_state)
		default : begin
		n_state <= idle;
		end
		
		idle : begin
		out <= 1'b1;
		n_state <= start;
		end
		
		start: begin
		out <= 1'b0;
		n_state <= d1;
		
		end
		
		d1 : begin
		 out <= S[idx];
                if (&bitIdx) begin
                    bitIdx  <= 3'b0;
                    state   <= s1 ;
                end else begin
                    bitIdx  <= bitIdx + 1'b1;
                end
		
      end
		
		s1: begin
		out <= 1;
		if(counter < 2 ) begin
		counter <= counter + 1;
		n_state <= s1; end
		if(counter == 2) begin 
		counter <= 0;
		n_state <= idle; end
		end
		
	endcase
	
	
end

endmodule
