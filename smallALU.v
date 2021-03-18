/*
	This module is the Small ALU as shown in the figure
	It returns the difference of two inputs 

	This ALU is used to calculate the difference of the
	two exponents and to decide the shift amount that
	will be needed in the following shift right block
*/

module smallALU (input [7:0] num1, input [7:0] num2, output [7:0] diff);
	assign diff = num1 - num2;
endmodule : smallALU