module normalLight (clk, reset, L, R, LN, RN, lightOn);
	input logic clk, reset;
	
	input logic L, R, LN, RN;
	output logic lightOn;
	
	enum { off, on } ps, ns;
	
	//state encoding
	always_comb begin
	
		if (reset) ns = off;
		else begin
			case (ps)
				on: if (L ^ R) ns = off;
					else ns = on;
				off: if ((RN & L & ~R) || (LN & R & ~L)) ns = on;
					else ns = off;
						
			endcase
		end
	end
	
	//output
	always_comb begin
		case (ps)
			on: lightOn = 1;
			off: lightOn = 0;
		endcase
	end
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset)
			ps <= off;
		else
			ps <= ns;
	end
endmodule


module normalLight_testbench();
	logic clk, reset, L, R, LN, RN, lightOn;
	
	normalLight dut (.clk, .reset, .L, .R, .LN, .RN, .lightOn);
	parameter CLOCK_PERIOD=100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
		end
		
		// Set up the inputs to the design. Each line is a clock cycle.
		initial begin
							@(posedge clk);
		//reset and set all to 0
		reset <= 1; L <= 0; R <= 0; RN <= 0; LN <= 0; repeat(3) @(posedge clk); 
		reset <= 0; repeat(3) @(posedge clk);
		//No movement if L is true in off state
		L <= 1; 			@(posedge clk);
		L <= 0; 			@(posedge clk);
		// Move on with L + RN
		RN <= 1; 		@(posedge clk);
		L <= 1;			@(posedge clk);
		L <= 0;			repeat(3) @(posedge clk);
		RN <= 0;			@(posedge clk);
		//Move off with L
		L <= 1;			@(posedge clk);
		//Nothing with R on
		R <= 1;			@(posedge clk);
		R <= 0;	L <= 0;		@(posedge clk);
		//Move on with R + LN
		LN <= 1; 		repeat(2) @(posedge clk);
		R <= 1;			@(posedge clk);
		R <= 0; LN <= 0;	repeat(3) @(posedge clk);
		//Reset keeps it on off state
		reset <= 1;	@(posedge clk);
		RN <= 1;			@(posedge clk);
		L <= 1;			repeat(2) @(posedge clk);
		L <= 0; RN <= 0;	@(posedge clk);
		reset <= 0; 	@(posedge clk);
		//Does not turn on when L or R do not match with RN or LN
		L <= 1; LN <= 1; repeat(2) @(posedge clk);
		L <= 0; LN <= 0; @(posedge clk);
		R <= 1; RN <= 1; repeat(2) @(posedge clk);
		R <= 0; RN <= 0; @(posedge clk);
		
		//L and R don't do anything in off state when alone
		L <= 1; repeat(2) @(posedge clk);
		L <= 0; @(posedge clk);
		R <= 1; repeat(2) @(posedge clk);
		R <= 0; @(posedge clk);
		
		//Simultaneous clicks do nothing when light on
		RN <= 1; L <= 1; @(posedge clk);
		L <= 1; R <= 1; repeat(3) @(posedge clk);
		
		$stop; // End the simulation.
	end
endmodule
