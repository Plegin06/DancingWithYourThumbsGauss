module centerLight (clk, reset, L, R, LN, RN, lightOn);
	input logic clk, reset;
	
	
	input logic L, R, LN, RN;
	output logic lightOn;
	
	enum { on, off } ps, ns;
	
	//state encoding
	always_comb begin
		case (ps)
			on: if ((L ^ R) && ~reset) ns = off;
				else ns = on;
			off: if ((RN & L & ~R) || (LN & R & ~L)) ns = on;
				else ns = off;
					
		endcase
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
			ps <= on;
		else
			ps <= ns;
	end
endmodule

module centerLight_testbench();
	logic clk, reset, L, R, LN, RN, lightOn;
	
	centerLight dut (.clk, .reset, .L, .R, .LN, .RN, .lightOn);
	parameter CLOCK_PERIOD=100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
		end
		
		initial begin
		// Set up the inputs to the design. Each line is a clock cycle.
		//reset and set all to 0
			@(posedge clk);
		reset <= 1; L <= 0; R <= 0; RN <= 0; LN <= 0; repeat(3) @(posedge clk); 
		reset <= 0; repeat(3) @(posedge clk);
		//Turn off light, then no movement with L
		L <= 1; 			repeat(3) @(posedge clk);
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
		//Reset holds on state
		reset <= 1;	@(posedge clk);
		L <= 1;			repeat(2) @(posedge clk);
		R <= 1;			repeat(2) @(posedge clk);
		R <= 0; L <= 0; @(posedge clk);
		reset <= 0; 	@(posedge clk);
		//turn light off
		R <= 1; @(posedge clk);
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
		
		//Simultaneous click do nothing
		L <= 1; R<= 1; repeat(3) @(posedge clk);
		
		$stop; // End the simulation.
	end
endmodule
