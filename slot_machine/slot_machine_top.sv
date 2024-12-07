module slot_machine_top(
	input logic clk,
	input logic rst_but,
	input logic run_but,
	output logic [7:0] display_bits [0:5]
	);
	
	//Slot Clock Speeds [Hz]
	parameter SLOT1_SPEED = 1;
	parameter SLOT2_SPEED = 2;
	parameter SLOT3_SPEED = 3;
	
	//Slot Clock Wire
	logic slot1_clk = 0;
	logic slot2_clk = 0;
	logic slot3_clk = 0;
	
	//Slot Output Wires
	logic [3:0] slot1_num = 4'b0100;
	logic [3:0] slot2_num = 4'b0010;
	logic [3:0] slot3_num = 4'b1001;
	logic [3:0] slot4_num = 4'b0110;
	
	//Run and Reset Wires
	logic run = 1;
	logic rst = 1;
	
	//Pseudo Display Bits
	logic [7:0] pre_display_bits [0:5];
	
	//Slot Clock Dividers
	clock_divider slot1_clk_div(.clk(clk), .speed(SLOT1_SPEED), .rst(rst), .out_clk(slot1_clk));
	clock_divider slot2_clk_div(.clk(clk), .speed(SLOT2_SPEED), .rst(rst), .out_clk(slot2_clk));
	clock_divider slot3_clk_div(.clk(clk), .speed(SLOT3_SPEED), .rst(rst), .out_clk(slot3_clk));
	
	//Slots
	slot slot1(.clk(slot1_clk), .run(run), .rst(rst), .num(slot1_num));
	slot slot2(.clk(slot2_clk), .run(run), .rst(rst), .num(slot2_num));
	slot slot3(.clk(slot3_clk), .run(run), .rst(rst), .num(slot3_num));
	
	//Display Encoder
	display_encoder display(.slot1_num(slot1_num), .slot2_num(slot2_num), .slot3_num(slot3_num), .display_bits(pre_display_bits [0:5]));
	
	always_comb begin
		if(run == 0) begin
			if(slot1_num == slot2_num && slot2_num == slot3_num) begin
				case (slot3_clk)
					0: for(int i = 0; i < 6; i++) display_bits[i] = 8'b11111111;
					default: display_bits = pre_display_bits;
				endcase
			end
			else begin
				case (slot1_clk)
					0: for(int i = 0; i < 6; i++) display_bits[i] = 8'b11111111;
					default: display_bits = pre_display_bits;
				endcase
			end
		end
		else display_bits = pre_display_bits;
	end
	
	always_ff @(posedge run_but) begin
		run <= ~run;
	end
	
endmodule

//TODO: Fix reset button to reset clock dividers only once and allow slots to reset