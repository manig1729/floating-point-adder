/* 
	This is the final module that checks for overflow or underflow in the result
	There are specific formats of representation of zero and infinity in the IEEE754 format
	These formats are shown in a table in the project folder
*/
module exceptionCheck (input [31:0] frac, input [7:0] exp, input s, output reg [31:0] fracfinE, output reg [7:0] expfinE, output reg sfinE);

always @(*) begin
	// If exponent is 255 (or higher) result is infinity not NaN
	if (exp >= 255) begin
		fracfinE = 0;
		expfinE = 255;
		sfinE = s;
	end

	// If exponent is 0 (after bias) result is zero
	else if (exp == 0) begin
		fracfinE = 0;
		expfinE = 0;
		sfinE = 0;
	end

	// No exceptions
	else begin
		fracfinE = frac;
		expfinE = exp;
		sfinE = s;
	end
end	

endmodule : exceptionCheck