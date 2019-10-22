`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/17 17:09:47
// Design Name: 
// Module Name: lvds_lcd_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lvds_lcd_controller#(
		parameter DATA_IN_LEN = 8,
		parameter LVDS_LANES = 4
	)(
		input	logic					clk_sys_i,
		input	logic					rst_n_i,
		
		input	logic					lcd_de_i,
		input	logic					lcd_vs_i,
		input	logic					lcd_hs_i,
		
		input	logic[DATA_IN_LEN-1:0]	lcd_r_i	,
		input	logic[DATA_IN_LEN-1:0]	lcd_g_i	,
		input	logic[DATA_IN_LEN-1:0]	lcd_b_i	,
		
		output	logic[LVDS_LANES-1:0]	lvds_data_p_o,
		output	logic[LVDS_LANES-1:0]	lvds_data_n_o,
		output	logic					lvds_clk_p_o,
		output	logic					lvds_clk_n_o
    );
	
	logic clk_locked;
	logic lvds_hclk_x7;
	logic lvds_dv_shift_clk;
	logic sys_rst_n;
	
	assign sys_rst_n = (rst_n_i&clk_locked);
	
	clk_lvds clk_pll_lvds
   (
		.clk_out1(lvds_hclk_x7),     // output clk_out1 = clk_sys  x7
		.clk_out2(lvds_dv_shift_clk),     // output clk_out2 
		.resetn(rst_n_i), // input reset
		.locked(clk_locked),       // output locked
		.clk_in1(clk_sys_i)); // Clock in ports
	
	 
	lcd_lvds#(
		.DATA_IN_LEN	(DATA_IN_LEN	) ,
		.LVDS_LANES		(LVDS_LANES		)
	)lvds_ins_u0(
		.rst_n_i		(sys_rst_n		),
		.clk_i			(lvds_hclk_x7	),
		.clk_p_i		(lvds_dv_shift_clk),
		.clk_n_i		(1'b1			),
		.clk_dvi_i		(clk_sys_i		),
		.lcd_de_i		(lcd_de_i		),
		.lcd_vs_i		(lcd_vs_i		),
		.lcd_hs_i		(lcd_hs_i		),
		.lcd_r_i		(lcd_r_i		),
		.lcd_g_i		(lcd_g_i		),
		.lcd_b_i		(lcd_b_i		),
		.lvds_data_p_o	(lvds_data_p_o	),
		.lvds_data_n_o	(lvds_data_n_o	),
		.lvds_clk_p_o	(lvds_clk_p_o	),
		.lvds_clk_n_o	(lvds_clk_n_o	)
	);
	
endmodule
