`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: DeamonYang
// 
// Create Date: 2019/10/17 15:34:30
// Design Name: 
// Module Name: lcd_lvds
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


`timescale 1ns/1ps

module lcd_lvds#(
		parameter DATA_IN_LEN = 8,
		parameter LVDS_LANES = 4
	)(
		input	logic					rst_n_i	,
		input	logic					clk_i	,
		input	logic					clk_p_i	,
		input	logic					clk_n_i	,
		input	logic					clk_dvi_i,
		
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
	
	logic[DATA_IN_LEN-1:0]	R,G,B;
	logic[DATA_IN_LEN-2:0]	data_in_map[LVDS_LANES-1:0];
	logic 					r_clk_dvi;
	logic					pos_clk;
	logic[LVDS_LANES-1:0]	lvds_data_in;
	logic[DATA_IN_LEN-2:0]	lvds_data_shift[LVDS_LANES-1:0];
	logic[2:0]				cnt;
	logic                   lvds_clk_gen;
	
//	assign lvds_clk_p_o = clk_p_i;
//	assign lvds_clk_n_o = clk_n_i; 
	
	assign R = lcd_r_i;
	assign G = lcd_g_i;
	assign B = lcd_b_i;
	
	/*8 bit lvds lcd data mappig*/
	assign data_in_map[0] = {G[0],R[5:0]};
	assign data_in_map[1] = {B[1:0],G[5:1]};
	assign data_in_map[2] = {lcd_de_i,lcd_vs_i,lcd_hs_i,B[5:2]}; 
	assign data_in_map[3] = {1'b0,B[7:6],G[7:6],R[7:6]};
 
//	assign data_in_map[0] = {7{lcd_de_i}};//{lcd_de_i,lcd_vs_i,lcd_hs_i,B[5:2]}; //{G[0],R[5:0]};
//	assign data_in_map[1] = {lcd_de_i,lcd_vs_i,lcd_hs_i,B[5:2]}; //{B[1:0],G[5:1]};
//	assign data_in_map[2] = {lcd_de_i,lcd_vs_i,lcd_hs_i,B[5:2]}; 
//	assign data_in_map[3] = {lcd_de_i,lcd_vs_i,lcd_hs_i,B[5:2]}; //{1'b0,B[7:6],G[7:6],R[7:6]};
	
	assign pos_clk = ((~r_clk_dvi)&clk_dvi_i);
	
	
	always_ff@(posedge clk_i or negedge rst_n_i)
	if(!rst_n_i)
		r_clk_dvi <= 1'b0;
	else
		r_clk_dvi <= clk_dvi_i;
		
	always_ff@(posedge clk_i or negedge rst_n_i)
	if(!rst_n_i)
		cnt <= 'd0;
	else if(pos_clk | ((cnt != 'd0) & (cnt < 3'd6)))
		cnt <= cnt + 1'b1;
	else
		cnt <= 'd0;
	
	/*serialization of parallel data*/
	generate
		genvar i;
		for(i = 0;i < LVDS_LANES;i = i + 1)begin:ins_u 
			always_ff@(posedge clk_i or negedge rst_n_i)
			if(!rst_n_i)
				lvds_data_shift[i] <= 'd0;
			else
				lvds_data_shift[i] <= (data_in_map[i] << cnt);
			
			assign lvds_data_in[i] = lvds_data_shift[i][DATA_IN_LEN-2];
		end
	endgenerate
	
	/*generate clock output*/
	always_ff@(posedge clk_i or negedge rst_n_i)
	if(!rst_n_i)
	   lvds_clk_gen <= 1'b0;
	else if((cnt > 1) & (cnt < 5))
	   lvds_clk_gen <= 1'b0;
	else
	   lvds_clk_gen <= 1'b1;
	
	
	/*lvds output component*/
	generate
		genvar j;
		for(j = 0;j < LVDS_LANES;j = j + 1)begin:lvds_u
			OBUFDS #(
				.IOSTANDARD("DEFAULT"),                                             //  I/O电平标准
				.SLEW("SLOW")
			) OBUFDS_ (
				.O  (lvds_data_p_o[j] ),
				.OB (lvds_data_n_o[j] ),
				.I  (lvds_data_in[j]) 
			);
		end
	endgenerate
	
	/*LVDS diff clock*/
	OBUFDS #(
		.IOSTANDARD("DEFAULT"),                                             //  I/O电平标准
		.SLEW("SLOW")
	) OBUFDS_clock (
		.O  (lvds_clk_p_o ),
		.OB (lvds_clk_n_o ),
		.I  (lvds_clk_gen) 
	);
	
	
endmodule

