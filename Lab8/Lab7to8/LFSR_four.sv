module LFSR_four (clk, reset, bitout);
	input logic clk, reset;
	output logic [3:0] bitout;
	
	
	//xnor
	logic feedback;
	assign feedback = ~ (bitout[3] ^ bitout[2]);

	
	always_ff @(posedge clk) begin
		if (reset) bitout <= 4'b0100;
		else bitout <= { bitout[2:0], feedback };
	end
	
endmodule

module LFSR_four_testbench ();
	logic clk, reset;
	logic [3:0] bitout;
	
	LFSR_four dut (.clk(clk), .reset(reset), .bitout(bitout));
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
				repeat(30) @(posedge clk);
		$stop;
	end

endmodule 