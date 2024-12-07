module seven_seg_digit(
	input logic [3:0] digit,
	output logic [7:0] display_bits
);

	// The following block contains the logic of your combinational circuit
	always_comb begin
		// TODO: fill out the case construct below to output the correct seven-segment display bits
		case (digit)
			4'b0000: display_bits = 8'b11000000; // 0
			4'b0001: display_bits = 8'b11111001; // 1
			4'b0010: display_bits = 8'b10100100; // 2
			4'b0011: display_bits = 8'b10110000; // 3
			4'b0100: display_bits = 8'b10011001; // 4
			4'b0101: display_bits = 8'b10010010; // 5
			4'b0110: display_bits = 8'b10000010; // 6
			4'b0111: display_bits = 8'b11111000; // 7
			4'b1000: display_bits = 8'b10000000; // 8
			4'b1001: display_bits = 8'b10010000; // 9
			default: display_bits = 8'b11111111; // error digit
		endcase
	end

endmodule