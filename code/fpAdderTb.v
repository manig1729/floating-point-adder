/*
	Testbench to test the code. A few different cases have been taken to
	show the extent of the adder. Inputs n1 and n2 are exchanged to show that
	the order of the inputs doesn't make a difference and negative numbers are taken 
	to show the sign calculations are done correctly.

	Finally, a case of overflow check is taken where two numbers very close to infinity
	are added and the output sum obtained is infinity
*/

module fpAdderTb;
	reg [31:0] n1, n2;
	wire [31:0] sum;

	fpAdder FPA ( .n1(n1), .n2(n2), .sum(sum) );

	initial begin
			n1 <= 32'b01000001110000010000000000000000;			// 24.125
			n2 <= 32'b01000100011011001011000000000000;			// 946.75

	#10 	n1 <= 32'b01000100011011001011000000000000;			// 946.75
			n2 <= 32'b01000001110000010000000000000000; 		// 24.125

	#10		n1 <= 32'b00111101110011001100110011001101;			// 0.1
			n2 <= 32'b00111110110011001100110011001101;			// 0.4

	#10 	n1 <= 32'b01000000100010000000000000000000;			// 4.25
			n2 <= 32'b11000000100001000000000000000000;			// -4.125

	#10 	n1 <= 32'b11000000100001000000000000000000;			// -4.125
			n2 <= 32'b01000000100010000000000000000000;			// 4.25

	#10 	n1 <= 32'b11000001000000100000000000000000;			// -8.125
			n2 <= 32'b01000000100010000000000000000000;			// 4.25

	#10 	n1 <= 32'b11000010111101010100000000000000;			// -122.625
			n2 <= 32'b01000011000011101000000000000000;			// 142.5

	#10 	n1 <= 32'b01111111011111111111111111111111;			// Very close to infinity
			n2 <= 32'b01111111011111111111111111111111;			// Very close to infinity
	end
endmodule
