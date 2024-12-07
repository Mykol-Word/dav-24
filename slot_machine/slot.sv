module slot(
	input logic clk,
	input logic run,
	input logic rst,
	output logic [3:0] num
	);

	logic [3:0] shift_reg = 4'b0100;
	
	always_ff @(posedge clk) begin
		
		if(run == 1 && rst == 1) begin
			shift_reg <= shift_reg >> 1;
			shift_reg[3] <= shift_reg[1] ^ shift_reg[0];
		end
		if(rst == 0) shift_reg <= 4'b0100;
	end 
	
	always_comb begin
		num = shift_reg;
	end
	
endmodule