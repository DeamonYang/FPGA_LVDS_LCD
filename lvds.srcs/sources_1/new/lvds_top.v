`timescale 1ns/1ps

module lvds_top #(
   // width of the data for the system
	parameter SYS_W = 1,
   // width of the data for the device
	parameter DEV_W = 8)
 (
	// From the device out to the system
	input  [DEV_W-1:0] data_out_from_device,
	output [SYS_W-1:0] data_out_to_pins_p,
	output [SYS_W-1:0] data_out_to_pins_n,
	input             clk_div_in,   // Slow clock output
	input              clk_in,
	input              io_reset);
	
	selectio_wiz_0#(
		.SYS_W(SYS_W),
	   // width of the data for the device
		.DEV_W(DEV_W)
   )lvds(
		// From the device out to the system
		.data_out_from_device	(data_out_from_device	),
		.data_out_to_pins_p		(data_out_to_pins_p	),
		.data_out_to_pins_n		(data_out_to_pins_n	),
		.clk_div_in			(clk_div_in			),   // Slow clock output
		.clk_in                  (clk_in),
		.io_reset				(io_reset				)	
  );
 endmodule