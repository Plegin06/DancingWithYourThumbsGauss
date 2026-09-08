module hex_counter (p1count, p2count, HEXp1, HEXp2);
	input logic [2:0] p1count, p2count;
	output logic [6:0] HEXp1, HEXp2;
	
	always_comb begin
		case (p1count)
			0: HEXp1 = 7'b1000000;
			1:	HEXp1 = 7'b1111001;
			2: HEXp1 = 7'b0100100;
			3: HEXp1 = 7'b0110000;
			4: HEXp1 = 7'b0011001;
			5: HEXp1 = 7'b0010010;
			6: HEXp1 = 7'b0000011;
			7: HEXp1 = 7'b1111000;
		endcase
		
		case (p2count)
			0: HEXp2 = 7'b1000000;
			1:	HEXp2 = 7'b1111001;
			2: HEXp2 = 7'b0100100;
			3: HEXp2 = 7'b0110000;
			4: HEXp2 = 7'b0011001;
			5: HEXp2 = 7'b0010010;
			6: HEXp2 = 7'b0000011;
			7: HEXp2 = 7'b1111000;
		endcase
	end

endmodule


module hex_counter_testbench();
	logic [2:0] p1count, p2count;
	logic [6:0] HEXp1, HEXp2;
	
	hex_counter dut (.p1count, .p2count, .HEXp1, .HEXp2);
	
	integer i;
	initial begin
		for (i = 0; i < 8; i++) begin
			p1count = i; p2count = i; #10;
		end
	end
endmodule
