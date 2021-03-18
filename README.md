# floating-point-adder
This is the verilog implementation of a floating point adder that adds two numbers in the IEEE754 single precision format of floating point representation.<br>

This code is written in a modular format, where blocks shown in the circuit diagram are implemented in different modules.<br>
<img src="/assets/adder-diagram.png" alt="drawing" width="500"/> <br>

Explanation of the separate modules has been provided in the verilog files in the code directory. <br>

### About the IEEE 754 representation of single precision floating point numbers

The inputs are two floating point numbers shown in the IEEE754 single precision format, which is shown here - <br>
<img src="/assets/ieee754-single-precision.png" alt="drawing" width="500"/> <br>


The number represented by such a representation is calculated using this formula - <br>
<img src="/assets/number-calculation.png" alt="drawing"> <br>

Special numbers, such as zero, infinity or NaN (Not a number) are represented as shown in this table - <br>
<img src="/assets/ieee754-table.png" alt="drawing"> <br>

