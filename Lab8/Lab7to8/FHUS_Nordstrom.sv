module FHUS_Nordstrom (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR, SW);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [9:0] SW;
	
	logic [2:0] UPC;
	assign UPC[2:0] = SW[9:7];
	
	Nordstrom stolen_discount (.LEDR, .SW);
	FHUS display (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .UPC);
endmodule

module FHUS_Nordstrom_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	
	FHUS_Nordstrom dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .LEDR,
	.SW);
	
	integer i;
	initial begin
		for(i = 0; i <16; i++) begin
			{SW[9:7], SW[0]} = i; #10;
		end
	end
	
endmodule

	