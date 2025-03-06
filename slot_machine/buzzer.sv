module buzzer(
	input logic clk,
	input logic freq,
	input logic rst,
	output logic buzz_clk
	);

	clock_divider clk_div(.clk(clk), .speed(freq), .rst(rst), .out_clk(buzz_clk));
	
endmodule

//TODO: Finish. Incomplete as of now