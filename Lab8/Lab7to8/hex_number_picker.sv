module hex_number_picker (value, display_value);
	input logic [3:0] value;
	output logic [6:0] display_value;
	
	always_comb begin
		case(value)
			4'b0000: display_value = 7'b1000000;
			4'b0001: display_value = 7'b1111001;
			4'b0010: display_value = 7'b0100100;
			4'b0011: display_value = 7'b0110000;
			4'b0100: display_value = 7'b0011001;
			4'b0101: display_value = 7'b0010010;
			4'b0110: display_value = 7'b0000011;
			4'b0111: display_value = 7'b1111000;
			4'b1000: display_value = 7'b0000000;
			4'b1001: display_value = 7'b0011000;
			default: display_value = 7'b1000000;
		endcase
	end
endmodule

module hex_number_picker_testbench ();
	logic [3:0] value;
	logic [6:0] display_value;
	
	hex_number_picker dut (.value, .display_value);
	
	initial begin
		for (int i = 0; i < 16; i++) begin
			value = i; #10;
		end
	end
endmodule
