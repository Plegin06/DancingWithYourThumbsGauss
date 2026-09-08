module col_freezer (score, greenOut, redOut);
	input logic [7:0] score;
	output logic [15:0][3:0] greenOut, redOut;
	
	always_comb begin
		if(score == 8'b01111111) begin
			greenOut <= '1;
			redOut <= '1;
		end else begin
			greenOut <= '0;
			redOut <= '0;
		end
	end
endmodule

module col_freezer_testbench ();
	logic [7:0] score;
	logic [15:0][3:0] greenOut, redOut;
	
	col_freezer dut (.score, .greenOut, .redOut);
	
	initial begin
		score <= 8'b00001111; #10;
		score <= 8'b01111111; #10;
		score <= 8'b10000000; #10;
	end

endmodule
