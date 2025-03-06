module vga_top(
    // incoming clock signal - 50 MHz
	input sysclk,
   // reset signal
   input rst,

	// 8-bit color allocates 3 bits for red, 3 for green, 2 for blue
	input [2:0] input_red,
	input [2:0] input_green,
	input [1:0] input_blue,
	
    // VGA outputs
	output logic hsync,
	output logic vsync,
	
	// expects 12 bits for color
	output logic [3:0] red,
	output logic [3:0] green,
	output logic [3:0] blue
);

//Clock used by vga
logic vgaclk;
logic reset_fake = 'b0;

logic [2:0] input_red_fake = 3'b111;
logic [2:0] input_green_fake = 3'b000;
logic [1:0] input_blue_fake = 2'b00;

vgaclk clk(.areset(reset_fake), .inclk0(sysclk), .c0(vgaclk));

//VGA logic
vga vga_internal(.vgaclk(vgaclk), .rst(reset_fake), .hsync(hsync), .vsync(vsync), 
					.input_red(input_red_fake), .input_green(input_green_fake), .input_blue(input_blue_fake), .red(red), .green(green), .blue(blue));

always_ff @(posedge vgaclk) begin
	input_red_fake <= input_red_fake + 1;
	input_green_fake <= input_green_fake + 2;
	input_blue_fake <= input_blue_fake + 1;
end
					
endmodule