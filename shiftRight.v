/* 
	This module is the "Shift Right" block shown in the figure
	It shifts an input by a specified amount

	This block is used to match the exponents of both the numbers.
	Once the exponents are matched (to that of the larger number), 
	the fraction of the smaller number has to shifted by an amount equal to
	the difference between the exponents of the two numbers
*/

module shiftRight (input [31:0] num, input [7:0] shiftAmt, output [31:0] shitftAns);
	assign shitftAns = num >> shiftAmt;
endmodule : shiftRight
