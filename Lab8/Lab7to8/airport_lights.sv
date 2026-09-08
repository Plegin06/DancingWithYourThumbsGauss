module airport_lights (clk, reset, inputs, LEDR);
	input logic clk, reset;
	input logic [1:0] inputs;
	output logic [2:0] LEDR; //[2:0] outputs
	
	//logic [2:0] light_assignment;
	
	enum { calm, left, center, right } ps, ns;
	//Calm states for 2 LED active. Left to Right
	// versus Right to left are same states, backwards

	//code states
	//inputs[1:0] == 1 is right to left
	//inputs[1:0] == 2 is left to right
	//inputs[1:0] == 0 is calm winds
	//calm state is the two led state
	always_comb begin
		case (ps)
			calm: ns = center;
			left: if (inputs[1:0] == 1) ns = right;
				else ns = center;
			center: if (inputs[1:0] == 1) ns = left;
				else if (inputs[1:0] == 2) ns = right;
				else ns = calm;
			right: if (inputs[1:0] == 1) ns = center;
				else if (inputs[1:0] == 0) ns = calm;
				else ns = left;
		endcase
	end
	
	//outputs are lights based on the previous state
	always_comb begin
		case (ps)
			calm: LEDR[2:0] = 3'b101;
			left: LEDR[2:0] = 3'b100;
			center: LEDR[2:0] = 3'b010;
			right: LEDR[2:0] = 3'b001;
			default: LEDR[2:0] = 3'b111;
		endcase
	end
	
	
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset)
			ps <= center;
		else
			ps <= ns;
	end
endmodule

module airport_lights_testbench ();
	logic clk, reset;
	logic [1:0] inputs;
	logic [2:0] LEDR;
	
	airport_lights dut (.clk, .reset, .inputs, .LEDR);
	
	parameter CLOCK_PERIOD=100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
		end
		
		// Set up the inputs to the design. Each line is a clock cycle.
		initial begin
				inputs[1:0] <= 0; @(posedge clk);
		reset <= 1; 		  @(posedge clk); // Always reset FSMs at start
		reset <= 0;			  @(posedge clk);
				@(posedge clk);
				@(posedge clk);
				@(posedge clk);
				@(posedge clk);
				@(posedge clk);
				inputs[1:0] <= 1; @(posedge clk);
				@(posedge clk);
				@(posedge clk);
				@(posedge clk);
				@(posedge clk);
				@(posedge clk);
				inputs[1:0] <= 2; @(posedge clk);
				@(posedge clk);
				@(posedge clk);
				@(posedge clk);
				@(posedge clk);
				@(posedge clk);
				@(posedge clk);
				inputs[1:0] <= 0; @(posedge clk);
				@(posedge clk);
				@(posedge clk);
				@(posedge clk);
		$stop; // End the simulation.
	end
endmodule
