/*
	This is the normaliseSum module, also shown as the "Shift Left or Right" step 
	in the picture. Here, the output of the bigALU is adjusted to be shown in the
	normalised IEEE754 format of single precision floating point representation
*/
module normaliseSum (input [31:0] fracIn, input [7:0] exponentIn, input op, output reg [31:0] fracOut, output reg [7:0] exponentOut);

integer breakout;
integer shAmt;
integer index;

always @(*) begin

	breakout = 0;

	if(op == 0) begin					// In addition, if the sum exceeds a single bit before the decimal, frac [24] will become 1
		if(fracIn[24] == 1) begin
			fracOut = fracIn >> 1;
			exponentOut = exponentIn + 1;
		end
		else begin
			fracOut = fracIn;
			exponentOut = exponentIn;
		end 
	end

	else if(op == 1) begin				// In subtraction, if the numbers are close, there may be a lot of shifts needed for the decimal

		// While loops and break statements are not synthesisable and hence, the code is written in this way
		for(index = 22; index >= 0; index = index - 1) begin
			if (breakout != 1)
          		if (fracIn[index] == 1) begin
               		shAmt = 23 - index;
               		breakout = 1;
          		end
		end
		fracOut = fracIn << shAmt;
		exponentOut = exponentIn - shAmt;
	end

end

endmodule : normaliseSum
