`timescale 1ns/1ns

module ALU_testbench(
	output logic [7:0] displayBits [0:5]
	);

logic [3:0] test_op1 = 4'b0011;
logic [3:0] test_op2 = 4'b0001;
logic test_operation = 0;
logic test_sign = 1;

ALU_top DUT(.op1(test_op1), .op2(test_op2), .operation(test_operation), .sign(test_sign), .displayBits(displayBits));

initial begin
#20;
test_op1 [3:0] = 4'b0001;
test_op2 [3:0] = 4'b1101;
test_operation = 1;
#20;
end
	
endmodule