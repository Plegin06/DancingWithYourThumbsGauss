module clock_counter (reset, clk, counter_control, enable);
	input logic reset, clk;
	input logic [3:0] counter_control;
	output logic enable;
	
	logic [11:0] counter, compare;
	
	always_comb begin
		case (counter_control)
		  4'b0000: compare = 12'd4069; // 0.75 Hz
		  4'b0001: compare = 12'd3052; // 1.00 Hz
		  4'b0010: compare = 12'd2035; // 1.50 Hz
		  4'b0011: compare = 12'd1526; // 2.00 Hz
		  
		  4'b0100: compare = 12'd1017; // 3.00 Hz
		  4'b0101: compare = 12'd763;  // 4.00 Hz
		  4'b0110: compare = 12'd610;  // 5.00 Hz
		  4'b0111: compare = 12'd509;  // 6.00 Hz
		  
		  4'b1000: compare = 12'd436;  // 7.00 Hz
		  4'b1001: compare = 12'd382;  // 8.00 Hz
		  4'b1010: compare = 12'd339;  // 9.00 Hz
		  4'b1011: compare = 12'd305;  // 10.0 Hz
		  
		  4'b1100: compare = 12'd277;  // 11.0 Hz
		  4'b1101: compare = 12'd254;  // 12.0 Hz
		  4'b1110: compare = 12'd235;  // 13.0 Hz
		  4'b1111: compare = 12'd218;  // 14.0 Hz
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (reset) begin
			counter <= 0;
			enable <= 0;
		end else begin
			if (counter >= compare) begin
				counter <= 0;
				enable <= 1;
			end else begin
				counter <= counter + 1'b1;
				enable <= 0;
			end
		end
	end
endmodule

module clock_counter_testbench ();
	logic reset, clk;
	logic [3:0] counter_control;
	logic enable;
	
	clock_counter dut (.reset, .clk, .counter_control, .enable);
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	integer i;
	initial begin
		reset <= 1; counter_control <= 4'b0000; @(posedge clk);
		reset <= 0; @(posedge clk);
		
		// testing different speeds - requires VERY large amounts of clock edges.
		for (i = 0; i < 16; i++) begin
			repeat(6000) @(posedge clk);
			counter_control <= counter_control + 1'b1;
		end
		repeat(6000) @(posedge clk);
		$stop;
	end
endmodule
