//this module receives a 9 bit twos comp value and will convert it to a hex display value across 4 hexes
//one hex will light the engative, the other 3 will light the values
module point_displayer (in, HEXSIGN, HEXHunds, HEXTens, HEXOnes, HEXbonus, HEXbonus2);
	input logic [11:0] in; //twos comp
	
	output logic [6:0] HEXSIGN, HEXHunds, HEXTens, HEXOnes, HEXbonus, HEXbonus2;
	
	logic is_negative;
	logic [11:0] abs_value;
	
	logic [3:0] ones, tens, hundreds;
	
	always_comb begin
		if (in == 11'b00111111100) begin
			hundreds = 4'b1000;
			tens = 4'b1000;
			ones = 4'b1000;
			HEXSIGN = '0;
			HEXbonus = '0;
			HEXbonus2 = '0;
			abs_value = 'X;
		end 
		else begin
			if (in[10] == 1'b1) begin
				abs_value   = -in;
				HEXSIGN = 7'b0111111;
			end else begin
				abs_value   = in;
				HEXSIGN = 7'b1111111;
			end

			hundreds = 4'(abs_value / 10'd100);       
			tens     = 4'((abs_value / 10'd10) % 10'd10);  
			ones     = 4'(abs_value % 10'd10);
			
			HEXbonus = '1;
			HEXbonus2 = '1;
		end
		 
	end
	
	hex_number_picker ones_hex (.value(ones), .display_value(HEXOnes));
	hex_number_picker tens_hex (.value(tens), .display_value(HEXTens));
	hex_number_picker hunds_hex (.value(hundreds), .display_value(HEXHunds));
	
	
	

endmodule

module point_displayer_testbench ();
	logic [10:0] in;
	logic [6:0] HEXSIGN, HEXHunds, HEXTens, HEXOnes;
	
	point_displayer dut (.in, .HEXSIGN, .HEXHunds, .HEXTens, .HEXOnes);
	
	initial begin
		//try various binary values to see if this works
		for (int i = 0; i < 256; i++) begin
			in = i; #10;
		end
		for (int i = 0; i > -257; i--) begin
			in = i; #10;
		end
	end
endmodule

