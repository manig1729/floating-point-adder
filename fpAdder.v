/* 
	This is the verilog implementation of a floating point adder that takes inputs in the 
	IEEE754 format of single precision floating point representation and returns their 
	sum in the same IEEE754 format

	Author : Manikandan Gunaseelan
*/

/* 
	The code is written in a modular form where all small functions in the adder have
	been implemented in different modules
*/
module fpAdder (input [31:0] n1, input [31:0] n2, output [31:0] sum);

	wire [31:0] fraction1;
	wire [31:0] fraction2;
	wire [7:0] exponent1;
	wire [7:0] exponent2;
	wire sign1;
	wire sign2;

	// The following store intermediate values during calculations
	wire [7:0] exponentDiff;
	wire [7:0] exponentDiffAbs;

	wire [31:0] fractionTemp;
	wire [31:0] fractionSmall;
	wire [31:0] fractionLarge;
	wire [31:0] fractionSumInitial;
	wire [31:0] fractionFinal;

	wire [7:0] exponentTemp;
	wire [7:0] exponentFinal;
	wire signFinal;
	wire bigALUOp;

	// These are to store the final values after exceptions are tested
	wire [31:0] fractionFinalE;
	wire [7:0] exponentFinalE;
	wire signFinalE;

		/* 
			Since there is an implied 1 in IEEE 754 format, an extra 1 is added to the fractions
			Also, to avoid 2's complement notation issues and allow for easy rounding in the
			future, eight extra 0's are added at the MSB
			This makes our fractions 32 bits long instead of 23 bits
		*/
		assign fraction1 = {8'b0, 1'b1, n1[22:0]};
		assign fraction2 = {8'b0, 1'b1, n2[22:0]};

		assign exponent1 = n1[30:23];
		assign exponent2 = n2[30:23];
		
		assign sign1 = n1[31];
		assign sign2 = n2[31];

		smallALU ALU1 (exponent1, exponent2, exponentDiff);		// calculation of exponent difference

		wire i;					// To be used as select signal in MUX
		selectSignalMux Control_Unit_Select_Signal (fraction1, fraction2, exponentDiff, i);

		/*
			if exponentDiff is negative, it will be represented in 2's complement format
			However, we need the absolute value of the exponent Difference to be able
			to shift the smaller fraction. Hence, we find exponentDiffAbs here -
		*/
		assign exponentDiffAbs = exponentDiff[7]?-(exponentDiff):exponentDiff;	// This will determine the shift amount

		MUX_8bit MUX1 (exponent1, exponent2, i, exponentTemp);

		MUX_32bit MUX2 (fraction2, fraction1, i, fractionTemp);		// fractionTemp will be shifted by the shift amount
		MUX_32bit MUX3 (fraction1, fraction2, i, fractionLarge);

		MUX_1bit MUX4 (sign1, sign2, i, signLarge);
		MUX_1bit MUX5 (sign2, sign1, i, signSmall);

		assign bigALUOp = signLarge ^ signSmall;	// If both numbers have the same sign, addition is to be done, else subtraction
		assign signFinal = signLarge;				// The sign of the final number is the sign of the number with the bigger absolute value

		shiftRight SHIFT (fractionTemp, exponentDiffAbs, fractionSmall);	// smaller number's fraction is shifted by the amount of difference in exponents

		bigALU ALU2 (fractionLarge, fractionSmall, bigALUOp, fractionSumInitial);	// Main calculation using adjusted numbers

		normaliseSum NORMALISE (fractionSumInitial, exponentTemp, bigALUOp, fractionFinal, exponentFinal);	// Normalising the result to be shown in IEEE754 format

		exceptionCheck EXCEPTION_BLOCK (fractionFinal, exponentFinal, signLarge, fractionFinalE, exponentFinalE, signFinalE); // Check for overflow or underflow

		// Note that the rounding hardware is not implemented in this project

		assign sum = {signFinalE, exponentFinalE, fractionFinalE[22:0]};	// final assignment of sum value

endmodule : fpAdder



