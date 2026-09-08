//this module checks if a player has clicked their button at the appropriate time for the position of the bar.
//A full success is 2 points, meaning the LED was on the spot when the player pressed
//A half success is 1 point, meaning the LED was one row away when the player pressed
//Missing is a penalty

//This should use tug_input and input_validator for the metastability solution and no-holding respectively.
// This also prevents massive point loss/gain by holding the button

//Light needs to turn off immediately when button is pressed at the right time. This prevents getting lots of points for clicking numerous times per bar.

//
module input_attempt (reset, clk, player_in, light_top, light_high, light_mark, light_low, score, input_indicator, LED);
	input logic reset, clk;
	input logic player_in, light_top, light_high, light_mark, light_low;
	output logic [1:0] score;
	output logic [3:0] input_indicator;
	output logic LED;
	
	logic can_score, scoring_zone;
	//00 is no score
	//01 is partial (1pt)
	//10 is full (2pt)
	//11 is failure (-2pt)
	
	//can_score means that no scoring choice has been made yet
	//scoring_zone is a flag that the scoring zone was entered
	
	always_comb begin
		if (light_mark) begin
			LED = 1;
		end else begin
			LED = 0;
		end
	end

	always_ff @(posedge clk) begin
		if (reset) begin
			score           <= 2'b00;
			can_score       <= 1'b0;
			scoring_zone    <= 1'b0;
			input_indicator <= 4'b1111;
		end 
		else begin
			if (light_top) begin
				can_score    <= 1'b1;
				scoring_zone <= 1'b0;
				score        <= 2'b00;
				input_indicator <= 4'b1111;
			end
			else if (light_high) begin
				scoring_zone <= 1'b1;
			end
		end


		if (!can_score && score != 2'b00) begin
			score <= 2'b00;
		end


		if (can_score) begin
			// Partial score
			if ((light_high || light_low) && player_in) begin
				score           <= 2'b01;
				can_score       <= 1'b0;
				input_indicator <= 4'b0000;
			end
			// Full score
			else if (light_mark && player_in) begin
				score           <= 2'b10;
				can_score       <= 1'b0; 
				input_indicator <= 4'b0000;
			end
			// penalty of bad input 
			else if (!(light_high || light_mark || light_low) && player_in) begin
				score           <= 2'b11;
				can_score       <= 1'b0;
				input_indicator <= 4'b0000;
			end
			// miss penalty
			else if (scoring_zone && !(light_high || light_mark || light_low)) begin
				score           <= 2'b11;
				can_score       <= 1'b0;
				scoring_zone    <= 1'b0;
				input_indicator <= 4'b0000;
			end
			//nothing happens for score 2'b00
		end
		else if (scoring_zone && !(light_high || light_mark || light_low)) begin
			scoring_zone    <= 1'b0;
		end
	end

endmodule

module input_attempt_testbench ();
	logic reset, clk;
	logic player_in, light_top, light_high, light_mark, light_low;
	logic [1:0] score;
	
	input_attempt dut (.reset, .clk, .player_in, .light_top, .light_high, .light_mark, .light_low, .score);
//							reset, clk, player_in, light_top, light_high, light_mark, light_low, score
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		//all values will be set long before this module can activate
		reset <= 1; player_in <= 0; light_top <= 0; light_high <= 0; light_mark <= 0; light_low <= 0; @(posedge clk);
		reset <= 0; @(posedge clk);
		//say a light pulse is sent:
		light_top <= 1; @(posedge clk);
		light_top <= 0; @(posedge clk);
				repeat(3) @(posedge clk);
		//high input
		light_high <= 1; @(posedge clk);
		player_in <= 1; @(posedge clk);
		player_in <= 0; @(posedge clk);
		//scored, so more presses don't score, score can't change
		light_high <= 0; light_mark <= 1; @(posedge clk);
		player_in <= 1; @(posedge clk);
		player_in <= 0; @(posedge clk);
		light_mark <= 0; light_low <= 1; @(posedge clk);
		light_low <= 0; @(posedge clk);
		// wait some time, say another impulse comes (only possible after a full impulse is known to have finished)
				repeat(3) @(posedge clk)
		light_top <= 1; @(posedge clk);
		light_top <= 0; @(posedge clk);
		//going for mark input
		light_high <= 1; @(posedge clk);
		light_high <= 0; light_mark <= 1; @(posedge clk);
		player_in <= 1; @(posedge clk);
		player_in <= 0; @(posedge clk);
		light_mark <= 0; light_low <= 1; @(posedge clk);
		light_low <= 0; @(posedge clk);
		// wait some time, say another impulse comes (only possible after a full impulse is known to have finished)
				repeat(3) @(posedge clk)
		light_top <= 1; @(posedge clk);
		light_top <= 0; @(posedge clk);
		//going for low input
		light_high <= 1; @(posedge clk);
		light_high <= 0; light_mark <= 1; @(posedge clk);
		light_mark <= 0; light_low <= 1; @(posedge clk);
		player_in <= 1; @(posedge clk);
		player_in <= 0; @(posedge clk);
		light_low <= 0; @(posedge clk);
		//reset
		reset <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
		//missing the light results in a deduction
		light_top <= 1; @(posedge clk);
		light_top <= 0; @(posedge clk);
		light_high <= 1; @(posedge clk);
		light_high <= 0; light_mark <= 1; @(posedge clk);
		light_mark <= 0; light_low <= 1; @(posedge clk);
		light_low <= 0; @(posedge clk);
	
		//reset
		reset <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
		//clicking before a pulse is ever sent does nothing
		player_in <= 1; @(posedge clk);
		player_in <= 0; @(posedge clk);
		//Holding button doesn't change score because first input is pressed. Button hold is illegal and impossible anyway
		light_top <= 1; @(posedge clk);
		light_top <= 0; @(posedge clk);
		light_high <= 1; player_in <= 1; @(posedge clk);
		light_high <= 0; light_mark <= 1; @(posedge clk);
		light_mark <= 0; light_low <= 1; @(posedge clk);
		light_low <= 0; @(posedge clk);
		player_in <= 0; @(posedge clk);
		
		$stop;
	end
endmodule
