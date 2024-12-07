module display_encoder(
	input logic [3:0] slot1_num,
	input logic [3:0] slot2_num,
	input logic [3:0] slot3_num,
	output logic [7:0] display_bits [0:5]
);

	// TODO: create signals for the six 4-bit digits
	logic [3:0] digit1; // 1
	logic [3:0] digit2; // 2
	logic [3:0] digit3; // 3
	logic [3:0] digit4; // 4
	logic [3:0] digit5; // 5
	logic [3:0] digit6; // 6
	
	// TODO: Instantiate six copies of seven_seg_digit, one for each digit (calculated below) 
	seven_seg_digit seg_digit_1(.digit(digit1), .display_bits(display_bits[0])); // 1
	seven_seg_digit seg_digit_2(.digit(digit2), .display_bits(display_bits[1])); // 2
	seven_seg_digit seg_digit_3(.digit(digit3), .display_bits(display_bits[2])); // 3
	seven_seg_digit seg_digit_4(.digit(digit4), .display_bits(display_bits[3])); // 4 
	seven_seg_digit seg_digit_5(.digit(digit5), .display_bits(display_bits[4])); // 5
	seven_seg_digit seg_digit_6(.digit(digit6), .display_bits(display_bits[5])); // 6
	
	// The following block contains the logic of your combinational circuit
	always_comb begin
		// TODO: Convert a 20-bit input result to six individual digits (4 bits each) 
		digit1 = slot1_num % 10;
		digit2 = slot1_num / 10;
		digit3 = slot2_num % 10;
		digit4 = slot2_num / 10;
		digit5 = slot3_num % 10;
		digit6 = slot3_num / 10;
	end

endmodule