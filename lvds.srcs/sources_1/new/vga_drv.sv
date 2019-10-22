`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/17 20:17:21
// Design Name: 
// Module Name: vga_drv
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


module vga_drv#(
		parameter PIX_WIDTH = 8
	)(
		input	logic					rst_n_i,
		input	logic					clk_i,
		input	logic[PIX_WIDTH-1:0]	r_i,
		input	logic[PIX_WIDTH-1:0]	g_i,
		input	logic[PIX_WIDTH-1:0]	b_i,
		
		output	logic[PIX_WIDTH-1:0]	r_o,
		output	logic[PIX_WIDTH-1:0]	g_o,
		output	logic[PIX_WIDTH-1:0]	b_o,
		
		output	logic					de,
		output	logic					vsync,
		output	logic					hsync,
		output	logic					new_fram_o
    );
	 
//	parameter h_visable = 1024;
//	parameter h_max = 1344;
//	parameter h_start_sync = h_visable + 20;
//	parameter h_end_sync = h_start_sync + 200;
//	
//	parameter v_visable = 600;
//	parameter v_max = 635;
//	parameter v_start_sync = v_visable + 5;
//	parameter v_end_sync = v_start_sync + 10;



	parameter h_visable = 1366;
	parameter h_max = 1489;
	parameter h_start_sync = h_visable + 4;
	parameter h_end_sync = h_start_sync + 10;
	
	parameter v_visable = 768;
	parameter v_max = 780;
	parameter v_start_sync = v_visable + 2;
	parameter v_end_sync = v_start_sync + 5;
	
	
	logic [11:0]h_cnt;
	logic [11:0]v_cnt;
	
	logic	r_hsync;
	logic	r_vsync;
	logic	r_de;
	logic	[PIX_WIDTH*3-1:0] img_data;
	
	always_ff@(posedge clk_i or negedge rst_n_i)
	if(!rst_n_i)
		h_cnt <= 'd0;
	else if(h_cnt < h_max - 1'b1)
		h_cnt <= h_cnt + 1'b1;
	else
		h_cnt <= 'd0;
	
	always_ff@(posedge clk_i or negedge rst_n_i)
	if(!rst_n_i)
		v_cnt <= 'd0;
	else if(h_cnt == h_max - 1'b1)begin
		if(v_cnt < v_max - 1'b1)
			v_cnt <= v_cnt + 1'b1;
		else
			v_cnt <= 'd0;
	end else
		v_cnt <= v_cnt;
	
		
	assign new_fram_o = ((h_cnt == h_max - 1'b1) && (v_cnt == v_max - 1'b1));
	
	always_ff@(posedge clk_i or negedge rst_n_i)
	if(!rst_n_i)
		hsync <= 1'b0;
	else if((h_cnt >= (h_start_sync - 2'd2)) && (h_cnt < (h_end_sync - 2'd2)))
		hsync <= 1'b0;
	else
		hsync <= 1'b1;
	
	always_ff@(posedge clk_i or negedge rst_n_i)
	if(!rst_n_i)
		vsync <= 1'b0;
	else if((v_cnt >= (v_start_sync - 2'd1)) && (v_cnt < (v_end_sync - 2'd1)))
		vsync <= 1'b0;
	else
		vsync <= 1'b1;	
	
	always_ff@(posedge clk_i or negedge rst_n_i)
	if(!rst_n_i)
		de <= 1'b0;
	else if((v_cnt >= v_visable) || (h_cnt >= h_visable))
		de <= 1'b0;
	else
		de <= 1'b1;	

	always_ff@(posedge clk_i or negedge rst_n_i)
	if(!rst_n_i)
		{r_o,g_o,b_o} <= 'd0;
	else
		{r_o,g_o,b_o} <= {r_i,g_i,b_i};
		


//	assign hsync = ((h_cnt >= (h_start_sync - 2'd2)) && (h_cnt < (h_end_sync - 2'd2)))?1'b0:1'b1;
//	assign vsync = ((v_cnt >= (v_start_sync - 2'd1)) && (v_cnt < (v_end_sync - 2'd1)))?1'b0:1'b1;
//	
//	assign de = ((v_cnt >= v_visable) || (h_cnt >= h_visable))?1'b0:1'b1;
//	assign {r_o,g_o,b_o} = {r_i,g_i,b_i};
	
endmodule








