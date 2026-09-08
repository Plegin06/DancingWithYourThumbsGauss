module LFSR_twentyfour (shift, clk, reset, bitout);
	input logic shift, clk, reset;
	output logic [23:0] bitout;
	
	
	//xnor
	logic feedback;
	assign feedback = ~ (bitout[23] ^ bitout[22] ^ bitout[21] ^ bitout[16]);

	
	always_ff @(posedge clk) begin
		if (reset) bitout <= 24'b001001110101001010111011;
		else if (shift) bitout <= { bitout[22:0], feedback };
	end
	
endmodule

module LFSR_twentyfour_testbench ();
	logic clk, reset;
	logic [23:0] bitout;
	
	LFSR_twentyfour dut (.clk(clk), .reset(reset), .bitout(bitout));
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
				repeat(100000) @(posedge clk);
		$stop;
	end

endmodule 