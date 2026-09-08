// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
    output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output logic [9:0]  LEDR;
    input  logic [3:0]  KEY;
    input  logic [9:0]  SW;
    output logic [35:0] GPIO_1;
    input logic CLOCK_50;

	 // Turn off HEX displays
	 //Later will need a hex driver to count score, likely to double digits --- 99 meaning an 8 bit hex counter
//    assign HEX0 = '1;
//    assign HEX1 = '1;
//    assign HEX2 = '1;
//    assign HEX3 = '1;
//    assign HEX4 = '1;
//    assign HEX5 = '1;
//	 
	 
	 logic reset;        
	 assign reset = SW[9];
	 
	 
	 /* Set up system base clock to 3052 Hz (50 MHz / 2**(13+1))
	    ===========================================================*/
	 logic [31:0] div_clk;
	
	parameter whichClock = 13;
	clock_divider cdiv (.clock(CLOCK_50),
		.divided_clocks(div_clk));
		
		
	// Clock selection; allows for easy switching between sim and board clocks
	logic SYSTEM_CLOCK;
	
	// Detect when we're in Quartus and use the divided clock,
	// otherwise assume we're in ModelSim and use the fast clock
	`ifdef ALTERA_RESERVED_QIS
		assign SYSTEM_CLOCK = div_clk[whichClock]; // for board
	`else
		assign SYSTEM_CLOCK = CLOCK_50; // for simulation
	`endif
	
	 
	 /* Set up LED board driver
	    ================================================================== */
	 logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs
    logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
	 
	 /* Standard LED Driver instantiation - set once and 'forget it'. 
	    See LEDDriver.sv for more info. Do not modify unless you know what you are doing! */
		 //leave as
	 LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST(reset), .EnableCount(1'b1), .RedPixels, .GrnPixels, .GPIO_1);
	 
	
	 
	 //input validator circuits
	 logic in0raw, in1raw, in2raw, in3raw;
	 tug_input meta_input3 (.clk(SYSTEM_CLOCK), .in(~KEY[3]), .out(in3raw));
	 tug_input meta_input2 (.clk(SYSTEM_CLOCK), .in(~KEY[2]), .out(in2raw));
	 tug_input meta_input1 (.clk(SYSTEM_CLOCK), .in(~KEY[1]), .out(in1raw));
	 tug_input meta_input0 (.clk(SYSTEM_CLOCK), .in(~KEY[0]), .out(in0raw));
	 
	 logic in0, in1, in2, in3;
	 input_validator valid_in3 (.clk(SYSTEM_CLOCK), .reset(SW[9]), .in(in3raw), .out(in3));
	 input_validator valid_in2 (.clk(SYSTEM_CLOCK), .reset(SW[9]), .in(in2raw), .out(in2));
	 input_validator valid_in1 (.clk(SYSTEM_CLOCK), .reset(SW[9]), .in(in1raw), .out(in1));
	 input_validator valid_in0 (.clk(SYSTEM_CLOCK), .reset(SW[9]), .in(in0raw), .out(in0));
	 //holding handler - no need, input attempt handles held inputs by only taking first clock cycle as the scoring opportunity
	 
	 //input attempt circuit -- implemented
	 //each col
	 logic [1:0] col_1_score, col_2_score, col_3_score, col_4_score;
	 //indicator that an input was made and a score was chosen
	 logic [3:0] indicator1, indicator2, indicator3, indicator4;
	 //Board indicator that perfect input can occur
	 //LED[6:3] 6 is for column 3. 3 is for colum 1
	 //col1
	 input_attempt col_1_input (.reset(reset), .clk(SYSTEM_CLOCK), .player_in(in0), 
						.light_top(RedPixels[0][0]), .light_high(RedPixels[13][0]), .light_mark(RedPixels[14][0]), 
						.light_low(RedPixels[15][0]), .score(col_1_score), .input_indicator(indicator1), .LED(LEDR[3]));
	 //col2
	 input_attempt col_2_input (.reset(reset), .clk(SYSTEM_CLOCK), .player_in(in1), 
						.light_top(RedPixels[0][4]), .light_high(RedPixels[13][4]), .light_mark(RedPixels[14][4]), 
						.light_low(RedPixels[15][4]), .score(col_2_score), .input_indicator(indicator2), .LED(LEDR[4]));
	 //col3
	 input_attempt col_3_input (.reset(reset), .clk(SYSTEM_CLOCK), .player_in(in2), 
						.light_top(RedPixels[0][8]), .light_high(RedPixels[13][8]), .light_mark(RedPixels[14][8]), 
						.light_low(RedPixels[15][8]), .score(col_3_score), .input_indicator(indicator3), .LED(LEDR[5]));
	 //col4
	 input_attempt col_4_input (.reset(reset), .clk(SYSTEM_CLOCK), .player_in(in3), 
						.light_top(RedPixels[0][12]), .light_high(RedPixels[13][12]), .light_mark(RedPixels[14][12]), 
						.light_low(RedPixels[15][12]), .score(col_4_score), .input_indicator(indicator4), .LED(LEDR[6]));

	 
	 //enable signal for slower clock, shift signal for slower clock on LFSR
	 //LFSR shifter is half as fast as clock counter so that pulses don't get shot out right after another
	 logic enable, shift;
	 clock_counter slow_clock (.reset(reset), .clk(SYSTEM_CLOCK), .counter_control(SW[3:0]), .enable(enable));
	 LFSR_counter LFSR_clock (.reset(reset), .clk(SYSTEM_CLOCK), .counter_control(SW[3:0]), .enable(shift));
	 
	 //LFSR for random release on columns -- adapt LFSR 10?
	 logic [23:0] LFSRoutput;
	 LFSR_twentyfour pseudo_pulse (.shift(shift), .clk(SYSTEM_CLOCK), .reset(reset), .bitout(LFSRoutput));
	 
	 //may need to update to change randomness and frequency
	 logic [5:0] LFSRbank1, LFSRbank2, LFSRbank3, LFSRbank4;
	 always_comb begin
		LFSRbank1 = LFSRoutput[5:0];
		LFSRbank3 = LFSRoutput[11:6];
		LFSRbank2 = LFSRoutput[17:12];
		LFSRbank4 = LFSRoutput[23:18];
	 end 
	 
	 logic pulse1, pulse2, pulse3, pulse4;
	 
	 pulse_verifier pulse_col1 (.reset(reset), .clk(SYSTEM_CLOCK), .difficulty(SW[8:4]), .LFSR_input(LFSRbank1), .bank(pulse1));
	 pulse_verifier pulse_col2 (.reset(reset), .clk(SYSTEM_CLOCK), .difficulty(SW[8:4]), .LFSR_input(LFSRbank2), .bank(pulse2));
	 pulse_verifier pulse_col3 (.reset(reset), .clk(SYSTEM_CLOCK), .difficulty(SW[8:4]), .LFSR_input(LFSRbank3), .bank(pulse3));
	 pulse_verifier pulse_col4 (.reset(reset), .clk(SYSTEM_CLOCK), .difficulty(SW[8:4]), .LFSR_input(LFSRbank4), .bank(pulse4));
	 
	  
	 
	 
	 //RedPixels Division into light banks
	 logic [15:0][3:0] bank1, bank2, bank3, bank4; 
	 
	 //cascade modules -- implemented
	 //col1
	LED_cascade col_1_cascade (.reset(reset), .clk(SYSTEM_CLOCK), .enable(enable), .pulse(pulse1), .pixels_col(bank1));
	 //col2
	LED_cascade col_2_cascade (.reset(reset), .clk(SYSTEM_CLOCK), .enable(enable), .pulse(pulse2), .pixels_col(bank2));
	 //col3
	LED_cascade col_3_cascade (.reset(reset), .clk(SYSTEM_CLOCK), .enable(enable), .pulse(pulse3), .pixels_col(bank3));
	 //col4
	LED_cascade col_4_cascade (.reset(reset), .clk(SYSTEM_CLOCK), .enable(enable), .pulse(pulse4), .pixels_col(bank4));
	
	//note. Need to make decision about what to do when misinput has occurred. Delete light? let it go? any sort of indicator that input went? Maybe green flash at top of screen, or bottom?
	logic [15:0][3:0] redcol_freeze1, redcol_freeze2, redcol_freeze3, redcol_freeze4;
	logic [15:0][3:0] grncol_freeze1, grncol_freeze2, grncol_freeze3, grncol_freeze4;
	//reassmble pixels given the banks vs freezing columbs - red
	
	
	 //point counter + display -- NEEDED
	logic [7:0] col1_points, col2_points, col3_points, col4_points;
	point_adder points_col1 (.clk(SYSTEM_CLOCK), .reset(reset), .score(col_1_score), .total(col1_points));
	point_adder points_col2 (.clk(SYSTEM_CLOCK), .reset(reset), .score(col_2_score), .total(col2_points));
	point_adder points_col3 (.clk(SYSTEM_CLOCK), .reset(reset), .score(col_3_score), .total(col3_points));
	point_adder points_col4 (.clk(SYSTEM_CLOCK), .reset(reset), .score(col_4_score), .total(col4_points));
	
	//col freezer at max points - turn page entire column orange and prevent any change in points from that column
	//Need to OR RedPixels from cascade with RedPixels here to drive a RedPixels that is used for the driver
	//need to somehow stop point loss. With whole column being marked as red, points can only go up from input.. which they are at max so that's fine. Great!
	//Also green out whole row, might need an or for the top indicator?
	col_freezer win_col1 (.score(col1_points), .greenOut(grncol_freeze1), .redOut(redcol_freeze1));
	col_freezer win_col2 (.score(col2_points), .greenOut(grncol_freeze2), .redOut(redcol_freeze2));
	col_freezer win_col3 (.score(col3_points), .greenOut(grncol_freeze3), .redOut(redcol_freeze3));
	col_freezer win_col4 (.score(col4_points), .greenOut(grncol_freeze4), .redOut(redcol_freeze4));
	
	always_comb begin
		for (int i = 0; i < 16; i++) begin
			RedPixels[i][3:0] = bank1[i] | redcol_freeze1[i];
			RedPixels[i][7:4] = bank2[i] | redcol_freeze2[i];
			RedPixels[i][11:8] = bank3[i] | redcol_freeze3[i];
			RedPixels[i][15:12] = bank4[i] | redcol_freeze4[i];
		end
	end
	
	//green light information indicators
	//Green bar is target
	always_comb begin
		GrnPixels[0][3:0] = indicator1 | grncol_freeze1[0];
		GrnPixels[0][7:4] = indicator2 | grncol_freeze2[0];
		GrnPixels[0][11:8] = indicator3 | grncol_freeze3[0];
		GrnPixels[0][15:12] = indicator4 | grncol_freeze4[0];
		
		for (int i = 1; i < 14; i++) begin
			GrnPixels[i][3:0] = grncol_freeze1[i];
			GrnPixels[i][7:4] = grncol_freeze2[i];
			GrnPixels[i][11:8] = grncol_freeze3[i];
			GrnPixels[i][15:12] = grncol_freeze4[i];
		end
		
		GrnPixels[14] = '1;
		GrnPixels[15][3:0] = grncol_freeze1[15];
		GrnPixels[15][7:4] = grncol_freeze2[15];
		GrnPixels[15][11:8] = grncol_freeze3[15];
		GrnPixels[15][15:12] = grncol_freeze4[15];
	end
	
	
	//total adder
	logic [11:0] total_points;
	total_adder point_total (.in1(col1_points), .in2(col2_points), .in3(col3_points), .in4(col4_points), .out(total_points));
	
	//total adder drives display values
	 //likely two circuits
	 point_displayer display_drive (.in(total_points), .HEXSIGN(HEX3), .HEXHunds(HEX2), .HEXTens(HEX1), .HEXOnes(HEX0), .HEXbonus(HEX4), .HEXbonus2(HEX5));
	 
endmodule

module DE1_SoC_testbench ();
	logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0]  LEDR;
	logic [3:0]  KEY;
	logic [9:0]  SW;
	logic [35:0] GPIO_1;
	logic clk;
	
	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .SW, .LEDR, .GPIO_1, .CLOCK_50(clk));
	
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		//test
		SW[9] <= 1; KEY[3:0] <= 4'b1111; @(posedge clk);
				repeat(5) @(posedge clk);
		SW[9] <= 0; @(posedge clk);
		SW[8:4] <= 5'b00111; @(posedge clk);
		//let game run
		//observe varying clock speeds changing how quickly lights move
		//slow
		SW[3:0] <= 4'b0001; @(posedge clk);
				repeat(100000) @(posedge clk);
		//Medium
		SW[3:0] <= 4'b0011; @(posedge clk);
				repeat(100000) @(posedge clk);
		//Faster
		SW[3:0] <= 4'b0111; @(posedge clk);
				repeat(100000) @(posedge clk);
		//Fastest
		SW[3:0] <= 4'b1111; @(posedge clk);
				repeat(100000) @(posedge clk);
		
		//observe varying difficulty changes how often pulses are sent
		//hard (often)
		SW[8:4] <= 5'b11111; @(posedge clk);
				repeat(100000) @(posedge clk);
		SW[8:4] <= 5'b01111; @(posedge clk);
				repeat(100000) @(posedge clk);
		//very little
		SW[8:4] <= 5'b00001; @(posedge clk);
				repeat(100000) @(posedge clk);		
		//none at all
		SW[8:4] <= 5'b00000; @(posedge clk);
				repeat(100000) @(posedge clk);
		//Throughout, watch point penalty. Reach minimum and stay
		
		//reset and test some inputs and scoring
		SW[9] <= 1; @(posedge clk);
				repeat(10) @(posedge clk);
		SW[9] <= 0; @(posedge clk);
		//fastest LFSR and LED clock for easier simming
		SW[8:0] <=9'b111111111; @(posedge clk)
				repeat(3470) @(posedge clk);
		KEY[3] <= 0; KEY[2] <= 0; @(posedge clk); //col3 +2, col2 +2
				repeat(40) @(posedge clk); //like holding down
		KEY[3] <= 1; KEY[2] <= 1; @(posedge clk);
				repeat(722) @(posedge clk);
		KEY[1] <= 0; KEY[0] <= 0; @(posedge clk);//col1 +2, col0 +1 (late)
				repeat(40) @(posedge clk);
		KEY[1] <= 1; KEY[0] <= 1; @(posedge clk);
				repeat(2843) @(posedge clk);
		KEY[3] <= 0; @(posedge clk);				//col3 + 1 (late)
				repeat(40) @(posedge clk);
		KEY[3] <= 1; @(posedge clk);
				repeat(179) @(posedge clk);
		KEY[2] <= 0; @(posedge clk);				//col2 + 1 (late)
				repeat(40) @(posedge clk);
		KEY[2] <= 1; @(posedge clk);
				repeat(425) @(posedge clk);
		KEY[1] <= 0; KEY[0] <= 0; @(posedge clk); //col0 + 1, col1 + 1 (both early)
				repeat(40) @(posedge clk);
		KEY[1] <= 1; KEY[0] <= 1; @(posedge clk);
				repeat(2544) @(posedge clk);
		KEY[3] <= 0; KEY[2] <= 0; @(posedge clk); //col3 + 1, col2 + 1 (both early)
				repeat(40) @(posedge clk);
		KEY[3] <= 1; KEY[2] <= 1; @(posedge clk); 
				repeat(1292) @(posedge clk);
		KEY[1] <= 0; @(posedge clk); 					//col1 + 1 (late)
				repeat(40) @(posedge clk);
		KEY[1] <= 1; @(posedge clk);
				repeat(1055) @(posedge clk);
		KEY[0] <= 0; @(posedge clk);					//col0 + 2
				repeat(40) @(posedge clk);
		KEY[0] <= 1; @(posedge clk);
		
		
			//All adding options are tested above.
			//try four inputs all at once.
			//here is 3 penalty and a +1 (total -5)
				repeat(1896) @(posedge clk);
		KEY[3:0] <= 4'b0000; @(posedge clk);
				repeat(40) @(posedge clk);
		KEY[3:0] <= 4'b1111; @(posedge clk);
		
		
		//Now observe penalty out to some deepish negative.
				repeat(10462) @(posedge clk);
				repeat(233) @(posedge clk);
		//adding to negative cases
		KEY[1] <= 0; @(posedge clk);				//col1 + 2
				repeat(40) @(posedge clk);
		KEY[1] <= 1; @(posedge clk);
				repeat(409) @(posedge clk);
		KEY[2] <= 0; @(posedge clk);				//col2 + 2
				repeat(40) @(posedge clk);
		KEY[2] <= 1; @(posedge clk);
				repeat(839) @(posedge clk);
		KEY[0] <= 0; @(posedge clk);				//col0 + 2
				repeat(40) @(posedge clk);
		KEY[0] <= 1; @(posedge clk);
				repeat(1266) @(posedge clk);		
		KEY[3] <= 0; @(posedge clk);				//col3 + 2
				repeat(40) @(posedge clk);
		KEY[3] <= 1; @(posedge clk);
				repeat(1070) @(posedge clk);
		KEY[2:1] <= 2'b00; @(posedge clk);		//col1,2 + 1 (late, early) respectively
				repeat(40) @(posedge clk);
		KEY[2:1] <= 2'b11; @(posedge clk);
				repeat(1277) @(posedge clk);
		KEY[0] <= 0; @(posedge clk);				//col0 + 1 (late)
				repeat(40) @(posedge clk);
		KEY[0] <= 1; @(posedge clk);
				repeat(841) @(posedge clk);
		KEY[3] <= 0; @(posedge clk);				//col3 + 1 (early)
				repeat(40) @(posedge clk);
		KEY[3] <= 1; @(posedge clk);
				
		//finish out -- Try to get to max positive
		for (int i = 0; i < 200000; i++) begin
			if (LEDR[6]) begin
				KEY[3] <= 0; @(posedge clk);
					repeat(10) @(posedge clk);
				KEY[3] <= 1; @(posedge clk);
			end
			if (LEDR[5]) begin
				KEY[2] <= 0; @(posedge clk);
					repeat(10) @(posedge clk);
				KEY[2] <= 1; @(posedge clk);
			end 
			if (LEDR[4]) begin
				KEY[1] <= 0; @(posedge clk);
					repeat(10) @(posedge clk);
				KEY[1] <= 1; @(posedge clk);
			end 
			if (LEDR[3]) begin
				KEY[0] <= 0; @(posedge clk);
					repeat(10) @(posedge clk);
				KEY[0] <= 1; @(posedge clk);
			end
			@(posedge clk);
		end
		
		//let run to max negative
		SW[9] <= 1; @(posedge clk);
		SW[9] <= 0; @(posedge clk);
		
		repeat(250000) @(posedge clk);
		$stop;
		
	end

endmodule