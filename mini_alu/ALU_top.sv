module ALU_top (
	input logic [3:0] op1,
	input logic [3:0] op2,
	input logic operation, 
	input logic sign,		
	output logic [7:0] displayBits [0:5]
	);
	
	logic [19:0] result;
	displayEncoder display(.result(result), .displayBits(displayBits));

	// The following block contains the logic of your combinational circuit
	always_comb begin
	if (operation) begin
		if (sign) result = op2 >> op1;
		else result = op2 << op1;
	end else begin
		if (sign) result = op1 - op2; 
		else result = op1 + op2; 
	end
	
	end
endmodule