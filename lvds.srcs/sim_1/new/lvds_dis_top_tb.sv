`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/17 20:55:01
// Design Name: 
// Module Name: lvds_dis_top_tb
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


module lvds_dis_top_tb;

	logic		rst_n_i;
	logic		clk_i;

	wire[3:0]	lvds_data_p_o;
	wire[3:0]	lvds_data_n_o;
	wire		lvds_clk_p_o;
	wire		lvds_clk_n_o;	




	lvds_dis_top lvds_dis_top_u0(
		.rst_n_i		(rst_n_i		),
		.clk_i			(clk_i			),
		.lvds_data_p_o	(lvds_data_p_o	),
		.lvds_data_n_o	(lvds_data_n_o	),
		.lvds_clk_p_o	(lvds_clk_p_o	),
		.lvds_clk_n_o	(lvds_clk_n_o	)	
    );
	
	initial begin
		rst_n_i = 0;
		clk_i = 0;
		repeat(100)@(posedge clk_i);
		rst_n_i = 1;
		repeat(1024*10)@(posedge clk_i);
		$finish;
	
	end
	
	always #10 clk_i = ~clk_i;
endmodule
