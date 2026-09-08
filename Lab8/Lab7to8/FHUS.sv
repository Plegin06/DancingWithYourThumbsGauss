module FHUS (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, UPC);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input logic [2:0] UPC;
	
	always_comb begin
		case (UPC)
					  
			3'b000: begin //farm
				// Light: 6543210
				HEX5 = 7'b1111111;
				HEX4 = 7'b0001110;
				HEX3 = 7'b0001000;	
				HEX2 = 7'b1001110;
				HEX1 = 7'b0101011;
				HEX0 = 7'b0101011;
			end
			3'b001: begin //dart
				HEX5 = 7'b0100001;
				HEX4 = 7'b0001000;	
				HEX3 = 7'b1001110;
				HEX2 = 7'b0000111;
				HEX1 = 7'b1111111;
				HEX0 = 7'b1111111;
			end
			3'b010: begin //bloon
				HEX5 = 7'b0011100;
				HEX4 = 7'b0111011;
				HEX3 = 7'b1110111;
				HEX2 = 7'b1110111;
				HEX1 = 7'b1110111;
				HEX0 = 7'b1111111;
			end
			3'b011: begin //heli
				HEX5 = 7'b0001001;
				HEX4 = 7'b0000110;	
				HEX3 = 7'b1000111;
				HEX2 = 7'b1001111;
				HEX1 = 7'b1111111;
				HEX0 = 7'b1111111;
			end
			3'b100: begin //glue
				HEX5 = 7'b0010000;
				HEX4 = 7'b1000111;	
				HEX3 = 7'b1000001;
				HEX2 = 7'b0000110;
				HEX1 = 7'b1111111;
				HEX0 = 7'b1111111;
			end
			3'b111: begin //super
				HEX5 = 7'b0010010;
				HEX4 = 7'b1000001;	
				HEX3 = 7'b0001100;
				HEX2 = 7'b0000110;
				HEX1 = 7'b1001110;
				HEX0 = 7'b1111111;
			end
			default: begin //Don't care
				HEX5 = 7'bX;
				HEX4 = 7'bX;
				HEX3 = 7'bX;
				HEX2 = 7'bX;
				HEX1 = 7'bX;
				HEX0 = 7'bX;
			end
		endcase
	end
endmodule

module FHUS_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [2:0] UPC;
	
	FHUS dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .UPC);
	
	integer i;
	initial begin
		for(i = 0; i <8; i++) begin
			UPC = i; #10;
		end
	end
endmodule
