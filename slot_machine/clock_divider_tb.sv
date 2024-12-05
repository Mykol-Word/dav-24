`timescale 1ns/1ns

module clock_divider_tb(
		output logic out_clk
	);
		
	logic test_clk = 0;
	logic [19:0] test_speed = 1000000;
	logic test_rst = 0;

	clock_divider DUT(.clk(test_clk), .speed(test_speed), .rst(test_rst), .out_clk(out_clk));

	initial begin
		for(int i = 1; i < 101; i++) begin
			#20
			test_clk = i % 2;
		end
	end
		
endmodule