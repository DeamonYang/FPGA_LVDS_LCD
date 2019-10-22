`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/17 20:46:11
// Design Name: 
// Module Name: lvds_dis_top
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


module lvds_dis_top(
	input 	logic		rst_n_i,
	input	logic		clk_i,

	output	logic[3:0]	lvds_data_p_o,
	output	logic[3:0]	lvds_data_n_o,
	output	logic		lvds_clk_p_o,
	output	logic		lvds_clk_n_o,
	output 	logic 		led_o,
	output	logic		lcd_hs_o,
	output	logic		lcd_vs_o,
	output	logic		lcd_de_o
    );
    
	parameter PIX_WIDTH = 8;
 	parameter DATA_IN_LEN = 8;
	parameter LVDS_LANES = 4;
	
	
	logic					lcd_de_i;
	logic					lcd_vs_i;
	logic					lcd_hs_i;
	logic[DATA_IN_LEN-1:0]	lcd_r_i	;
	logic[DATA_IN_LEN-1:0]	lcd_g_i	;
	logic[DATA_IN_LEN-1:0]	lcd_b_i	;
	logic					new_fram;
	logic[23:0]				dis_data;
	
	assign	lcd_hs_o = lcd_hs_i;
	assign 	lcd_vs_o = lcd_vs_i;
	assign	lcd_de_o = lcd_de_i;
	
	logic  clock_sys;
	
	logic[21:0]        dis_cnt;
	
//    logic clk_5m;
	
//	  clk_wiz_0 clk_sl
//    (
//     // Clock out ports
//     .clk_out1(clk_5m),     // output clk_out1
//    // Clock in ports
//     .clk_in1(clk_i)); 
	
	
	always@(posedge clk_i or negedge rst_n_i)
	if(!rst_n_i)
		dis_data <= 24'h55AA00; 
	else if(new_fram )
		dis_data <= dis_data + 24'h1;
	
    vga_drv#(
        .PIX_WIDTH(PIX_WIDTH)
    )vga_drv_u0(
        .rst_n_i(rst_n_i),
        .clk_i	(clk_i),
        .r_i	(dis_data[23:16]),
        .g_i	(dis_data[15:8]),
        .b_i	(dis_data[7:0]),
        .r_o	(lcd_r_i),
        .g_o	(lcd_g_i),
        .b_o	(lcd_b_i),
        .de		(lcd_de_i),
        .vsync	(lcd_vs_i),
        .hsync	(lcd_hs_i),
		.new_fram_o(new_fram)
    );
	
	led_blin#(
		.LED_MAX(1)
	)led_blin_u0(
		.rst_n_i(rst_n_i),
		.clk_i(clk_i),
		.led_o(led_o)
    );
	
	
	
	lvds_lcd_controller#(
		.DATA_IN_LEN	(DATA_IN_LEN	),
		.LVDS_LANES 	(LVDS_LANES 	)
	)lvds_lcd_controller_u0(
		.clk_sys_i		(clk_i			),
		.rst_n_i		(rst_n_i		),
		.lcd_de_i		(lcd_de_i		),
		.lcd_hs_i		(lcd_hs_i		),
		.lcd_vs_i		(lcd_vs_i		),
		.lcd_r_i		(lcd_r_i		),
		.lcd_g_i		(lcd_g_i		),
		.lcd_b_i		(lcd_b_i		),
		.lvds_data_p_o	(lvds_data_p_o	),
		.lvds_data_n_o	(lvds_data_n_o	),
		.lvds_clk_p_o	(lvds_clk_p_o	),
		.lvds_clk_n_o	(lvds_clk_n_o	)
    );
endmodule
