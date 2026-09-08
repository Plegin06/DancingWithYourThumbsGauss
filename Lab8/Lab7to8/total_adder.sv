module total_adder (in1, in2, in3, in4, out);
	input logic [7:0] in1, in2, in3, in4; //twos comp values
	
	output logic [11:0] out; //twos comp value
	
	logic [11:0] in1pad, in2pad, in3pad, in4pad, sum;
	
	always_comb begin
		in1pad = { {4{in1[7]}}, in1 };
		in2pad = { {4{in2[7]}}, in2 };
		in3pad = { {4{in3[7]}}, in3 };
		in4pad = { {4{in4[7]}}, in4 };
		
		out = in1pad + in2pad + in3pad + in4pad;
	end
	

endmodule

module total_adder_testbench ();
	logic [7:0] in1, in2, in3, in4; //twos comp values
	
	logic [11:0] out; //twos comp value
	
	total_adder dut (.in1, .in2, .in3, .in4, .out);
	
	initial begin
		//good addition
		for (int i = 0; i < 128; i++) begin
			in1 = i; in2 = i; in3 = -i; in4= -i; #10;
		end
		in3 = 0; in4 = 0;
		for (int i = 0; i < 128; i++) begin
			in1 = i; in2 = i; #10;
		end
	end
endmodule
