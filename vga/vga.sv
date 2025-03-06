module vga(
    // incoming clock signal - 25 MHz
	input vgaclk,
    // incoming reset signal - driven by shift register in top level
    input rst,

	// 8-bit color allocates 3 bits for red, 3 for green, 2 for blue
	input [2:0] input_red,
	input [2:0] input_green,
	input [1:0] input_blue,
    
    // output horizontal and vertical counters for communication with graphics module
	output logic [9:0] hc_out,
	output logic [9:0] vc_out,

    // VGA outputs
	output logic hsync,
	output logic vsync,
    // expects 12 bits for color
	output logic [3:0] red,
	
	output logic [3:0] green,
	output logic [3:0] blue
);

	localparam HPIXELS  = 640;    // number of visible pixels per horizontal line
	localparam HFP      = 16;    // length (in pixels) of horizontal front porch
	localparam HSPULSE  = 96;    // length (in pixels) of hsync pulse
	localparam HBP      = 48;    // length (in pixels) of horizontal back porch
	localparam HTOTAL   = 800; // total pixels
	
	localparam VPIXELS  = 480;    // number of visible horizontal lines per frame
	localparam VFP      = 10;    // length (in pixels) of vertical front porch
	localparam VSPULSE  = 2;    // length (in pixels) of vsync pulse
	localparam VBP      = 33;    // length (in pixels) of vertical back porch
	localparam VTOTAL   = 525; // total pixels
	
	// make sure values add up
	initial begin
		if (HPIXELS + HFP + HSPULSE + HBP != 800 || VPIXELS + VFP + VSPULSE + VBP != 525) begin
			$error("Expected horizontal pixels to add up to 800 and vertical pixels to add up to 525");
		end
	end
	
	// horizontal and vertical counters
	logic [9:0] hc;
	logic [9:0] vc;
	
	initial begin
		hc = 1'd0;
		vc = 1'd0;
	end
	
	assign hc_out = hc;
	assign vc_out = vc;
	
   // Update hc and vc
	always_ff @(posedge vgaclk) begin
		if (rst == 'b1) begin
			hc <= 0;
			vc <= 0;
		end
		
		else if(hc >= HTOTAL - 1) begin
			if(vc >= VTOTAL - 1)
				vc <= 0;
			else
				vc <= vc + 1;
			hc <= 0;
		end
		
		else
			hc <= hc + 1;
	end
	
	
	//Set hsycn and vsync to low in blanking area
	assign hsync = (hc >= HPIXELS + HFP && hc < HPIXELS + HFP + HSPULSE) ? 0 : 1;
	assign vsync = (vc >= VPIXELS + VFP && vc < VPIXELS + VFP + VSPULSE) ? 0 : 1;
	
   //set red, green, blue outputs
	always_comb begin
		//Unideal conversion
		if(hc < HPIXELS && vc < VPIXELS) begin
        red = input_red << 1;
        green = input_green << 1;
        blue = input_blue << 2;
		end
		else begin
			red = 0;
			green = 0;
			blue = 0;
		end
	end

endmodule
