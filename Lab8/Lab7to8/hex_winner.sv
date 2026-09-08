module hex_winner (win1, win2, HEX);
	input logic win1, win2;
	output logic [6:0] HEX;
	
	always_comb begin
		if (win1 == 1) HEX = 7'b1111001;
		else if (win2 == 1) HEX = 7'b0100100;
		else HEX = 7'b1111111;
	end
	
endmodule

module hex_winner_testbench();
	logic win1, win2;
	logic [6:0] HEX;
	
	hex_winner dut (.win1, .win2, .HEX);
	
	initial begin
		win1 = 0;
		win2 = 0;
		win1 = 1; #10;
		win1 = 0; #10;
		win2 = 1; #10;
		win2 = 0; #10;
		win1 = 1; win2 = 1; #10;
	end
endmodule
