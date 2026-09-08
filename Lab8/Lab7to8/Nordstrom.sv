module Nordstrom (LEDR, SW);
	output logic [9:0] LEDR;
	input logic [9:0] SW;
	
	// Logic to determine if the stolen light or discount light should be on.
	// U = SW[9] P = SW[8] C = SW[7] Mark = SW[0]
	// LEDR0 will be the stolen light
	// LEDR4 will be the discount light
	assign LEDR[0] = ~(SW[9] | SW[8] | SW[7] | SW[0]) | (SW[8] & SW[7] & ~SW[0]);
	assign LEDR[4] = ~SW[8];
	
	
endmodule

module Nordstrom_testbench();
	logic [9:0] LEDR;
	logic [9:0] SW;
	Nordstrom dut (.LEDR, .SW);
		// Try all combinations of inputs.
	integer i;
	initial begin
		SW[1] = 1'b0;
		SW[2] = 1'b0;
		SW[3] = 1'b0;
		SW[4] = 1'b0;
		SW[5] = 1'b0;
		SW[6] = 1'b0;
		SW[0] = 1'b0;
		for(i = 0; i <8; i++) begin
			SW[9:7] = i; #10;
		end
		SW[0] = 1'b1;
		for(i = 0; i <8; i++) begin
			SW[9:7] = i; #10;
		end
	end
endmodule