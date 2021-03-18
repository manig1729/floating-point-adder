/*
	This is the bigALU which either does addition or subtraction based on the signs of
	the input
	The signs have already been XORed in fpAdder.v and here, the output of that XOR is 
	taken as input op
*/

module bigALU (input [31:0] num1, input [31:0] num2, input op , output reg [31:0] sum);

always @(*) begin
	if(op == 0)
		sum = num1 + num2;
	else if(op == 1)
		sum = num1 - num2;
end
endmodule : bigALU