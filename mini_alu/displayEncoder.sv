module displayEncoder(
	input logic [19:0] result,
	output logic [7:0] displayBits [0:5]
);

	// TODO: create signals for the six 4-bit digits
	logic [3:0] digit1; // 1
	logic [3:0] digit2; // 2
	logic [3:0] digit3; // 3
	logic [3:0] digit4; // 4
	logic [3:0] digit5; // 5
	logic [3:0] digit6; // 6
	
	// TODO: Instantiate six copies of sevenSegDigit, one for each digit (calculated below) 
	sevenSegDigit segDigit1(.digit(digit1), .displayBits(displayBits[0])); // 1
	sevenSegDigit segDigit2(.digit(digit2), .displayBits(displayBits[1])); // 2
	sevenSegDigit segDigit3(.digit(digit3), .displayBits(displayBits[2])); // 3
	sevenSegDigit segDigit4(.digit(digit4), .displayBits(displayBits[3])); // 4 
	sevenSegDigit segDigit5(.digit(digit5), .displayBits(displayBits[4])); // 5
	sevenSegDigit segDigit6(.digit(digit6), .displayBits(displayBits[5])); // 6
	
	// The following block contains the logic of your combinational circuit
	always_comb begin
		// TODO: Convert a 20-bit input result to six individual digits (4 bits each) 
		digit1 = result % 10;
		digit2 = result / 10 % 10;
		digit3 = result / 100 % 10;
		digit4 = result / 1000 % 10;
		digit5 = result / 10000 % 10;
		digit6 = result / 100000 % 10;
	end

endmodule