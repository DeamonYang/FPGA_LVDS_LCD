`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/16 20:57:25
// Design Name: 
// Module Name: lvds_tr_tb
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


module lvds_tr_tb;

	parameter DATA_IN_LEN = 8;
	parameter LVDS_LANES = 4;
	logic					rst_n_i	;
	logic					clk_i	;
	logic					clk_p_i	;
	logic					clk_n_i	;
	logic					clk_dvi_i;
	logic					lcd_de_i;
	logic[DATA_IN_LEN-1:0]	lcd_r_i	;
	logic[DATA_IN_LEN-1:0]	lcd_g_i	;
	logic[DATA_IN_LEN-1:0]	lcd_b_i	;
	
	wire[LVDS_LANES-1:0]	lvds_data_p_o;
	wire[LVDS_LANES-1:0]	lvds_data_n_o;
	wire					lvds_clk_p_o;
	wire					lvds_clk_n_o;
	logic [DATA_IN_LEN*3-1:0] rgb_data;

	assign {lcd_r_i,lcd_g_i,lcd_b_i} = rgb_data;
	assign clk_n_i = ~clk_p_i;

	lcd_lvds#(
		.DATA_IN_LEN	(DATA_IN_LEN	) ,
		.LVDS_LANES		(LVDS_LANES		)
	)lvds_ins(
		.rst_n_i		(rst_n_i		),
		.clk_i			(clk_i),
		.clk_p_i		(clk_p_i		),
		.clk_n_i		(clk_n_i		),
		.clk_dvi_i		(clk_dvi_i		),
		.lcd_de_i		(lcd_de_i		),
		.lcd_r_i		(lcd_r_i		),
		.lcd_g_i		(lcd_g_i		),
		.lcd_b_i		(lcd_b_i		),
		.lvds_data_p_o	(lvds_data_p_o	),
		.lvds_data_n_o	(lvds_data_n_o	),
		.lvds_clk_p_o	(lvds_clk_p_o	),
		.lvds_clk_n_o	(lvds_clk_n_o	)
	);


	initial begin
		rst_n_i = 0;
		clk_p_i = 0;
		clk_i = 0;
		clk_dvi_i = 0;
		lcd_de_i = 0;
		rgb_data = 24'h55AA55;
		repeat(100)@(posedge clk_p_i);
		rst_n_i = 1;
		lcd_de_i = 1;
		@(posedge clk_dvi_i);
		rgb_data = 24'hAA55AA;
		repeat(10)@(posedge clk_dvi_i);
		$finish;
	end
	
	always #70 clk_dvi_i = ~clk_dvi_i;
	always #10 clk_p_i = ~clk_p_i;
	always #10 clk_i = ~clk_i;



endmodule
