module pulse_verifier (reset, clk, difficulty, LFSR_input, bank);
	input logic reset, clk;
	input logic [5:0] LFSR_input;
	input logic [4:0] difficulty; // switches
	
	output logic bank;
	
	logic [5:0] value_compare;
	
	always_comb begin
		value_compare = { 1'b0, difficulty };
	end
	
	always_ff @(posedge clk) begin
		if (reset) begin
			bank <= 0;
		end 
		else begin
			if (LFSR_input < value_compare) begin
				bank <= 1;
			end else begin
				bank <= 0;
			end
		end
	end

endmodule

module pulse_verifier_testbench ();
	logic reset, clk;
	logic [5:0] LFSR_input;
	logic [4:0] difficulty; // switches
	logic bank;
	
	pulse_verifier dut (.reset, .clk, .difficulty, .LFSR_input, .bank);
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
		
		//check comparator capability
		difficulty <= 5'b00111; @(posedge clk);
		//no bank
		LFSR_input <= 6'b000111; repeat(1) @(posedge clk);
		LFSR_input <= 6'b001111; repeat(1) @(posedge clk);
		LFSR_input <= 6'b111111; repeat(1) @(posedge clk);
		//yes bank
		LFSR_input <= 6'b000011; repeat(1) @(posedge clk);
		LFSR_input <= 6'b000001; repeat(1) @(posedge clk);
		LFSR_input <= 6'b000000; repeat(1) @(posedge clk);
		//back and forth
		LFSR_input <= 6'b000111; repeat(1) @(posedge clk);
		LFSR_input <= 6'b000011; repeat(1) @(posedge clk);
		LFSR_input <= 6'b001111; repeat(1) @(posedge clk);
		LFSR_input <= 6'b000001; repeat(1) @(posedge clk);
		LFSR_input <= 6'b111111; repeat(1) @(posedge clk);
		LFSR_input <= 6'b000000; repeat(1) @(posedge clk);
		
		//change difficulty
		
		difficulty <= 5'b11111; @(posedge clk);
		//no bank
		LFSR_input <= 6'b111111; repeat(1) @(posedge clk);
		//yes bank
		LFSR_input <= 6'b000111; repeat(1) @(posedge clk);
		LFSR_input <= 6'b001111; repeat(1) @(posedge clk);
		LFSR_input <= 6'b000011; repeat(1) @(posedge clk);
		LFSR_input <= 6'b000001; repeat(1) @(posedge clk);
		LFSR_input <= 6'b000000; repeat(1) @(posedge clk);
		//variety
		LFSR_input <= 6'b000111; repeat(1) @(posedge clk);
		LFSR_input <= 6'b000011; repeat(1) @(posedge clk);
		LFSR_input <= 6'b001111; repeat(1) @(posedge clk);
		LFSR_input <= 6'b000001; repeat(1) @(posedge clk);
		LFSR_input <= 6'b111111; repeat(1) @(posedge clk);
		LFSR_input <= 6'b000000; repeat(1) @(posedge clk);
		
		//change difficulty to freeze
		difficulty <= 5'b00000; @(posedge clk);
		// never bank
		LFSR_input <= 6'b111111; repeat(1) @(posedge clk);
		LFSR_input <= 6'b000111; repeat(1) @(posedge clk);
		LFSR_input <= 6'b001111; repeat(1) @(posedge clk);
		LFSR_input <= 6'b000011; repeat(1) @(posedge clk);
		LFSR_input <= 6'b000001; repeat(1) @(posedge clk);
		LFSR_input <= 6'b000000; repeat(1) @(posedge clk);
		LFSR_input <= 6'b000111; repeat(1) @(posedge clk);
		LFSR_input <= 6'b000011; repeat(1) @(posedge clk);
		LFSR_input <= 6'b001111; repeat(1) @(posedge clk);
		LFSR_input <= 6'b000001; repeat(1) @(posedge clk);
		LFSR_input <= 6'b111111; repeat(1) @(posedge clk);
		LFSR_input <= 6'b000000; repeat(1) @(posedge clk);
		$stop;
	end
	
	
endmodule
