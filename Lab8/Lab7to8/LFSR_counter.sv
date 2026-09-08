module LFSR_counter (reset, clk, counter_control, enable);
	input logic reset, clk;
	input logic [3:0] counter_control;
	output logic enable;
	
	logic [12:0] counter, compare;
	
	always_comb begin
	//halved from the clock that runs the leds
		case (counter_control)
		  4'b0000: compare = 13'd8138; // 0.375 Hz 
        4'b0001: compare = 13'd6104; // 0.50 Hz  
        4'b0010: compare = 13'd4070; // 0.75 Hz  
        4'b0011: compare = 13'd3104; // 1.00 Hz  
        
        4'b0100: compare = 13'd2034; // 1.50 Hz  
        4'b0101: compare = 13'd1526; // 2.00 Hz  
        4'b0110: compare = 13'd1220; // 2.50 Hz  
        4'b0111: compare = 13'd1018; // 3.00 Hz  
        
        4'b1000: compare = 13'd872;  // 3.50 Hz  
        4'b1001: compare = 13'd764;  // 4.00 Hz  
        4'b1010: compare = 13'd678;  // 4.50 Hz  
        4'b1011: compare = 13'd610;  // 5.00 Hz     

        4'b1100: compare = 13'd554;  // 5.50 Hz  
        4'b1101: compare = 13'd508;  // 6.00 Hz  
        4'b1110: compare = 13'd470;  // 6.50 Hz  
        4'b1111: compare = 13'd436;  // 7.00 Hz  
        
        default: compare = 13'd8138;
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (reset) begin
			counter <= 0;
			enable <= 0;
		end else begin
			if (counter >= compare) begin
				counter <= 0;
				enable <= 1;
			end else begin
				counter <= counter + 1'b1;
				enable <= 0;
			end
		end
	end
endmodule

module LFSR_counter_testbench ();
	logic reset, clk;
	logic [3:0] counter_control;
	logic enable;
	
	clock_counter dut (.reset, .clk, .counter_control, .enable);
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	integer i;
	initial begin
		reset <= 1; counter_control <= 4'b0000; @(posedge clk);
		reset <= 0; @(posedge clk);
		
		// testing different speeds - requires VERY large amounts of clock edges.
		for (i = 0; i < 16; i++) begin
			repeat(10000) @(posedge clk);
			counter_control <= counter_control + 1'b1;
		end
		repeat(10000) @(posedge clk);
		$stop;
	end
endmodule
