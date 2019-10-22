



set_property PACKAGE_PIN M19 [get_ports rst_n_i]
set_property PACKAGE_PIN K17 [get_ports clk_i]

set_property IOSTANDARD LVCMOS33 [get_ports clk_i]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n_i]
set_property IOSTANDARD BLVDS_25 [get_ports {lvds_data_p_o[3]}]
set_property IOSTANDARD BLVDS_25 [get_ports {lvds_data_n_o[3]}]
set_property IOSTANDARD BLVDS_25 [get_ports {lvds_data_p_o[2]}]
set_property IOSTANDARD BLVDS_25 [get_ports {lvds_data_n_o[2]}]
set_property IOSTANDARD BLVDS_25 [get_ports {lvds_data_p_o[1]}]
set_property IOSTANDARD BLVDS_25 [get_ports {lvds_data_n_o[1]}]
set_property IOSTANDARD BLVDS_25 [get_ports {lvds_data_p_o[0]}]
set_property IOSTANDARD BLVDS_25 [get_ports {lvds_data_n_o[0]}]
set_property IOSTANDARD BLVDS_25 [get_ports lvds_clk_p_o]
set_property IOSTANDARD BLVDS_25 [get_ports lvds_clk_n_o]
 
set_property PACKAGE_PIN M15 [get_ports led_o]
set_property IOSTANDARD LVCMOS33 [get_ports led_o]


set_property PACKAGE_PIN T14 [get_ports lvds_clk_p_o]
set_property PACKAGE_PIN N18 [get_ports {lvds_data_p_o[0]}]
set_property PACKAGE_PIN N20 [get_ports {lvds_data_p_o[1]}]
set_property PACKAGE_PIN T20 [get_ports {lvds_data_p_o[2]}]
set_property PACKAGE_PIN T16 [get_ports {lvds_data_p_o[3]}]

set_property IOSTANDARD LVCMOS25 [get_ports lcd_de_o]
set_property IOSTANDARD LVCMOS25 [get_ports lcd_hs_o]
set_property IOSTANDARD LVCMOS25 [get_ports lcd_vs_o]
set_property PACKAGE_PIN P14 [get_ports lcd_de_o]
set_property PACKAGE_PIN R14 [get_ports lcd_hs_o]
set_property PACKAGE_PIN T11 [get_ports lcd_vs_o]
