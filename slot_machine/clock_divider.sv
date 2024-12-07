module clock_divider(
		input logic clk,
		input logic [19:0] speed,
		input logic rst,
		output logic out_clk
	);

	parameter INCOMING_SIGNAL = 50000000;
	logic [25:0] counter = 0;
	logic next_clk = 0;

	always_ff @(posedge clk) begin
		out_clk <= next_clk;
		
		if(counter == INCOMING_SIGNAL/speed - 1) counter <= 0;
		else counter <= counter + 1;
		
		if(rst == 0) begin
			counter <= 0;
		end
	end
	
	always_comb begin
		if(counter < (INCOMING_SIGNAL/speed)/2) next_clk = 0;
		else next_clk = 1;
	end

endmodule