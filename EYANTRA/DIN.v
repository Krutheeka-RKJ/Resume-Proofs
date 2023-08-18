module DIN(
input clk_25M,
output Din);

reg [7:0] counter = 0;
reg [7:0] count = 0;

parameter bit1 = 3'b000, bit2 = 3'b001, bit3 = 3'b010, idle = 3'b011;
reg [2:0] c_state, n_state;
reg out;

assign Din = out;

always @(negedge clk_25M)
begin

 c_state <= n_state; // otherwise, next state
end 

always @(c_state)
begin
	case(c_state)
		default: begin
		
		c_state <=idle;
		n_state <= idle;
		out <= 0;
		
		end
		
		idle : begin
		if(count == 0) begin
		if (counter < 2) begin
			counter <= counter + 1;
			n_state <= idle;
		end
		else begin
			counter <= 0;
			n_state <= bit1;
		end
		end
		
		else begin
		out<= 0;
		end
		
		end
		
		bit1: begin
		out <= 1;
		n_state <= bit2;
		end
		
		bit2: begin
		out <= 0;
		n_state <= bit3;
		end
		
		bit3: begin 
		out <=1;
		count <= 1;
		n_state <= idle;
		end
		
		endcase
		end
		
endmodule
