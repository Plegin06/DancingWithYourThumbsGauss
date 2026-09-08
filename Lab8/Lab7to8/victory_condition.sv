module victory_condition (clk, reset, boundary, winning_input, counter_win, reset_field);
	input logic clk, reset;
	input logic boundary, winning_input;
	output logic [2:0] counter_win;
	output logic reset_field;
	//logic player_win;
	
	enum { not_win, win } ps, ns;
	
	always_comb begin
		if (reset) begin
			ns = not_win;
		end
		else begin
			case (ps)
				win: ns = not_win;
				not_win: if (winning_input == 1 && boundary == 1) ns = win;
					else ns = not_win;
			endcase
		end
	end
	
	always_comb begin
		case (ps)
			win: reset_field = 1;
			not_win: reset_field = 0;
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= not_win;
			counter_win <= 3'b000;
		end else begin
			ps <= ns;
		end
		if (ns == win)
			counter_win <= counter_win + 3'b001;
	end
	
endmodule

module victory_condition_testbench();
	logic clk, reset, boundary, winning_input;
	logic [2:0] counter_win;
	
	victory_condition dut (.clk, .reset, .boundary, .winning_input, .counter_win);
	parameter CLOCK_PERIOD=100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; 
		end
			
		initial begin
				@(posedge clk);
			//reset signal sets and holds
			reset <= 1; @(posedge clk);
			boundary <= 1; winning_input <= 1; repeat(2) @(posedge clk);
			boundary <= 0; winning_input <= 0; reset <= 0; @(posedge clk);
			
			//win and win every other cycle due to switching but
			boundary <= 1; @(posedge clk);
			winning_input <= 1; repeat(3) @(posedge clk);
			
			//reset to not win and no counters
			reset <= 1; repeat(3) @(posedge clk);
			
			//win beyond 7 bits overflows to 000
			reset <= 0; repeat(18) @(posedge clk);
		
		$stop;
	end
endmodule
