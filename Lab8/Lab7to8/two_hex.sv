module two_hex (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, SW);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input logic [9:0] SW;
	
	logic [6:0] out_hex0, out_hex1;
	
	assign HEX2[6:0] = 7'b1111111;
	assign HEX3[6:0] = 7'b1111111;
	assign HEX4[6:0] = 7'b1111111;
	assign HEX5[6:0] = 7'b1111111;
	seg7 display0 (.bcd(SW[3:0]), .leds(out_hex0[6:0]));
	seg7 display1 (.bcd(SW[7:4]), .leds(out_hex1[6:0]));
	
	assign HEX0 = ~out_hex0;
	assign HEX1 = ~out_hex1;
endmodule

module two_hex_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] SW;
	
	logic [6:0] out_hex0, out_hex1;
	
	two_hex dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .SW);
	
	integer i;
	initial begin
		SW[9:0] = 10'b0000000000;
		for(i = 0; i <16; i++) begin
			SW[3:0] = i; #10;
		end
		SW[3:0] = 4'b0000;
		for(i = 0; i <16; i++) begin
			SW[7:4] = i; #10;
		end
	end
	
endmodule

