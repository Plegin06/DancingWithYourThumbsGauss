module tug_input (clk, in, out);
	input logic clk;
	input logic in;
	output logic out;
	
	logic FF1, FF2;
	
	always @(posedge clk) begin
		FF1 <= in;
		FF2 <= FF1;
	end
	
	assign out = FF2;
		
endmodule

module tug_input_testbench();
	logic clk, in, out;
	
	tug_input dut (.clk, .in, .out);
	
	parameter CLOCK_PERIOD=100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
		end
		
		// Set up the inputs to the design. Each line is a clock cycle.
		initial begin
					@(posedge clk);
			//test in and out off without rapid input (catchup time)
			in <= 1; repeat(3) @(posedge clk);
			in <= 0; repeat(3) @(posedge clk);
			//rapid on off
			in <= 1; @(posedge clk);
			in <= 0; @(posedge clk);
					repeat(2) @(posedge clk);
			//rapid on off on off
			in <= 1; @(posedge clk);
			in <= 0; @(posedge clk);
			in <= 1; @(posedge clk);
			in <= 0; @(posedge clk);
					repeat(2) @(posedge clk)
			
			$stop;
		end
endmodule
