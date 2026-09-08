module ten_comparator(inA, inB, out);
	input logic [9:0] inA, inB;
	output logic out;
	
	assign out = inA > inB;
	
endmodule

module ten_comparator_testbench();
	logic [9:0] inA, inB;
	logic out;
	
	ten_comparator dut (.inA, .inB, .out);
	
	initial begin
		//A < B
		inA = 10'b0000000000; inB = 10'b0000000001; #10;
		//A > B
		inA = 10'b0000000001; inB = 10'b0000000000; #10;
		//A = B - out should be 0
		inA = 10'b1111111111; inB = 10'b1111111111; #10;
	end
endmodule
