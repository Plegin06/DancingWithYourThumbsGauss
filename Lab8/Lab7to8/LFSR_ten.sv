module LFSR_ten (clk, reset, bitout);
	input logic clk, reset;
	output logic [9:0] bitout;
	
	
	//xnor
	logic feedback;
	assign feedback = ~ (bitout[9] ^ bitout[6]);

	
	always_ff @(posedge clk) begin
		if (reset) bitout <= 10'b0000000000;
		else bitout <= { bitout[8:0], feedback };
	end
	
endmodule

module LFSR_ten_testbench ();
	logic clk, reset;
	logic [9:0] bitout;
	
	LFSR_ten dut (.clk(clk), .reset(reset), .bitout(bitout));
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
				repeat(1000) @(posedge clk);
		$stop;
	end

endmodule 