/*
	These are the MUXes in the circuit
	One is for sign (1 bit), one is for exponent (8 bit) and one is for fraction (32 bit)
	The MUXes are also implemented using modules, given below
*/

module MUX_1bit (input a, input b, input Sel, output out);
	assign out = Sel?b:a;
endmodule : MUX_1bit

module MUX_32bit (input [31:0] a, input [31:0] b, input Sel, output [31:0] out);
	assign out = Sel?b:a;
endmodule : MUX_32bit

module MUX_8bit (input [7:0] a, input [7:0] b, input Sel, output [7:0] out);
	assign out = Sel?b:a;
endmodule : MUX_8bit