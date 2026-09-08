//This module sends a single pulse down a specified column with a specific single color led array.
//The enable signal is from a counter, effectively dividing the clock to a playable and viewable rate
module LED_cascade(reset, clk, enable, pulse,/* column,*/ pixels_col);
	input logic               reset, clk, enable, pulse;
	output logic [15:0][3:0] pixels_col;
	//input logic		  [1:0] column;
	//logic [15:0][3:0] pixel_div;
	
	logic [3:0] current_row;
	logic pulse_in;
	
	always_comb begin
		
		//pixels_col = '0;
		
//		for (int i = 0; i < 16; i++) begin
//			pixels[i][ (column * 4) +: 4] = {4{pixel_div[i][column]}};
//		end
		
	end
	 
	 always_ff @(posedge clk) begin
		if (pulse) begin
			pulse_in <= 1;
		end
		if (reset) begin
			//pixel_div <= '0;
			pixels_col <= '0;
			current_row <= '0;
			pulse_in <= 0;
		end
		else begin
			if (pulse_in) begin
				if (enable) begin
					if (current_row < 4'b1111) begin
						pixels_col[current_row] <= 4'b1111;
						pixels_col[current_row - 1'b1] <= 4'b0000;					
						current_row <= current_row + 1'b1;
					end
					else begin
						pixels_col[current_row] <= 4'b1111;
						pixels_col[current_row - 1'b1] <= 4'b0000;
						current_row <= current_row + 1'b1;
						pulse_in <= 0;
					end
				end
			end
			else if (enable) begin
				pixels_col <= '0;
			end
		end
	end

endmodule

module LED_cascade_testbench ();
	logic               reset, clk, enable, pulse;
	logic [15:0][3:0] pixels_col;
	
	LED_cascade dut (.reset, .clk, .enable, .pulse, .pixels_col);
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		//resets
		reset <= 1; enable <= 0; @(posedge clk);
		reset <= 0; @(posedge clk);
		//pulsed
		pulse <= 1; @(posedge clk);
		pulse <= 0; @(posedge clk)
		
		//cascade
		enable <= 1; @(posedge clk);
				repeat(20) @(posedge clk);
		pulse <= 0; @(posedge clk);
		//resets
		reset <= 1; enable <= 0; @(posedge clk);
		reset <= 0; @(posedge clk);
		
		//checking edges
		pulse <= 1; @(posedge clk);
		enable <= 1; @(posedge clk);
		//try pulse on off on off
		pulse <= 0; @(posedge clk);
		pulse <= 1; @(posedge clk);
		pulse <= 0; @(posedge clk);
		pulse <= 1; @(posedge clk);
		pulse <= 0; @(posedge clk);
		pulse <= 1; @(posedge clk);
		pulse <= 0; @(posedge clk);
				repeat(12) @(posedge clk);
		
		$stop;
	end
endmodule
