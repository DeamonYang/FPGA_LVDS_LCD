-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
-- Date        : Wed Oct 16 21:36:40 2019
-- Host        : DESKTOP-L1VR7A3 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               h:/FPGA/ZYNQ_PL/lvds/lvds.srcs/sources_1/ip/selectio_wiz_0/selectio_wiz_0_stub.vhdl
-- Design      : selectio_wiz_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity selectio_wiz_0 is
  Port ( 
    data_out_from_device : in STD_LOGIC_VECTOR ( 7 downto 0 );
    data_out_to_pins_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    data_out_to_pins_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    clk_in : in STD_LOGIC;
    clk_div_in : in STD_LOGIC;
    io_reset : in STD_LOGIC
  );

end selectio_wiz_0;

architecture stub of selectio_wiz_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "data_out_from_device[7:0],data_out_to_pins_p[0:0],data_out_to_pins_n[0:0],clk_in,clk_div_in,io_reset";
begin
end;
