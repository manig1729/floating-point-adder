/*
	This module generated the select signal to be used in the MUXes to 
	differentiate between the smaller and bigger (absolute value) numbers

	This could have been done easily by just checking the exponents.
	However, an extra case has been taken to check for fractions in case the exponents are equal
*/

module selectSignalMux (input [31:0] frac1, input [31:0] frac2, input [7:0] expdiff, output reg sel);
	
reg [31:0] fracdiff;
always @(*) begin
	if(expdiff != 0) begin
		sel = expdiff[7];
	end
	else if(expdiff == 0) begin
		fracdiff = frac1 - frac2;
		sel = fracdiff[31];
	end		
end

endmodule : selectSignalMux