`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/17 22:07:13
// Design Name: 
// Module Name: led_blin
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


module led_blin#(
		parameter LED_MAX = 3
	)(
		input 	logic 				rst_n_i,
		input	logic 				clk_i,
		output	logic [LED_MAX-1:0]	led_o
    );
	
	logic[23:0] cnt[LED_MAX-1:0];
	
	generate
		genvar i;
		for(i = 0;i < LED_MAX;i = i + 1)begin: led_u
			always_ff@(posedge clk_i or negedge rst_n_i)
			if(!rst_n_i)
				cnt[i] <= 'd0;
			else
				cnt[i] <= cnt[i] + 1'b1;
				
			assign led_o[i] = cnt[i][21];
		end
	endgenerate
	
endmodule
