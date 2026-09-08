module input_validator (clk, reset, in, out);
	input logic clk, reset;
	input logic in;
	output logic out;
	
	enum { no_press, press } ps, ns;
	
	always_comb begin
		if (reset) ns = no_press;
		else begin
			case (ps)
				no_press: if (in == 1) ns = press;
					else ns = no_press;
				press: if (in == 0) ns = no_press;
					else ns = press;
			endcase
		end
	end
	
	always_comb begin
		case (ps)
			no_press: if (in == 1) out = 1;
				else out = 0;
			press: out = 0;
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= no_press;
		else ps <= ns;
	end
endmodule

module input_validator_testbench ();
	logic clk, reset, in, out;
	
	input_validator dut (.clk, .reset, .in, .out);
	parameter CLOCK_PERIOD=100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; 
		end
		
		initial begin
		//testing reset
				@(posedge clk);
		reset <= 1; @(posedge clk);
		in <= 1; @(posedge clk);
		reset <= 0; in <= 0; @(posedge clk);
		//hold presses
		in <= 1; repeat(3) @(posedge clk);
		in <= 0; reset <= 0; @(posedge clk);
		//only one valid input per hold
		in <= 1; repeat(4) @(posedge clk);
		//rapid on off translates accordingly
		in <= 0; @(posedge clk);
		in <= 1; @(posedge clk);
		in <= 0; @(posedge clk);
		in <= 1; @(posedge clk);
		in <= 0; @(posedge clk);
		in <= 1; @(posedge clk);
		in <= 0; @(posedge clk);	
		
		$stop;
	end
endmodule
