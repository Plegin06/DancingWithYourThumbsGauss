module point_adder (clk, reset, score, total);
	input logic clk, reset;
	input logic [1:0] score;
	output logic [7:0] total; //in twos comp
	
	always_ff @(posedge clk) begin
		if(reset) begin
			total <= '0;
		end else begin
		//twos comp addition in comfortable cases
			if (score == 2'b01 && total != 8'b01111111) begin
				total <= total + 8'b00000001;
			end else if (score == 2'b10 && (total != 8'b01111110 && total != 8'b01111111)) begin
				total <= total + 8'b00000010;
			end else if (score == 2'b11 && (total != 8'b10000001 && total != 8'b10000000)) begin
				total <= total + 8'b11111110;
			end 
		//twos comp addition at edges
			else if (score == 2'b01 && total == 8'b01111111) begin
				total <= 8'b01111111;
			end else if (score == 2'b10 && (total == 8'b01111110 || total == 8'b01111111)) begin
				total <= 8'b01111111;
			end else if (score == 2'b11 && (total == 8'b1000001 || total == 8'b10000000)) begin
				total <= 8'b10000000;
			end
			else begin
				total <= total;
			end 
		end
	end
	
endmodule

module point_adder_testbench ();
	logic clk, reset;
	logic [1:0] score;
	logic [7:0] total;
	
	point_adder dut (.clk, .reset, .score, .total);
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
		
		//check adding rules
		score <= 2'b01; @(posedge clk);
				repeat(20) @(posedge clk);
		//observe overflow protection
		score <= 2'b10; @(posedge clk);
				repeat(100) @(posedge clk);
		//subtract from maximum... then observe overflow protection
		score <= 2'b11; @(posedge clk);
				repeat(200) @(posedge clk);
		//add to negative
		score <= 2'b10; @(posedge clk);
				repeat(40) @(posedge clk);
		score <= 2'b01; @(posedge clk);
				repeat(40) @(posedge clk);
				
		$stop;
	end

endmodule
