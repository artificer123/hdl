
# usdrx1-xcvr

add_instance avl_usdrx1_xcvr avl_adxcvr 1.0
set_instance_parameter_value avl_usdrx1_xcvr {ID} {1}
set_instance_parameter_value avl_usdrx1_xcvr {TX_OR_RX_N} {0}
set_instance_parameter_value avl_usdrx1_xcvr {PCS_CONFIG} {JESD_PCS_CFG1}
set_instance_parameter_value avl_usdrx1_xcvr {LANE_RATE} {3200.0}
set_instance_parameter_value avl_usdrx1_xcvr {PLLCLK_FREQUENCY} {1600.0}
set_instance_parameter_value avl_usdrx1_xcvr {REFCLK_FREQUENCY} {80.0}
set_instance_parameter_value avl_usdrx1_xcvr {CORECLK_FREQUENCY} {80.0}
set_instance_parameter_value avl_usdrx1_xcvr {NUM_OF_LANES} {8}
set_instance_parameter_value avl_usdrx1_xcvr {NUM_OF_CONVS} {32}
set_instance_parameter_value avl_usdrx1_xcvr {FRM_BCNT} {4}
set_instance_parameter_value avl_usdrx1_xcvr {FRM_SCNT} {1}
set_instance_parameter_value avl_usdrx1_xcvr {MF_FCNT} {32}
set_instance_parameter_value avl_usdrx1_xcvr {HD} {0}

add_connection sys_clk.clk avl_usdrx1_xcvr.sys_clk
add_connection sys_clk.clk_reset avl_usdrx1_xcvr.sys_resetn
add_interface rx_ref_clk clock sink
set_interface_property rx_ref_clk EXPORT_OF avl_usdrx1_xcvr.ref_clk
add_interface rx_data_0 conduit end
set_interface_property rx_data_0 EXPORT_OF avl_usdrx1_xcvr.rx_data_0
add_interface rx_data_1 conduit end
set_interface_property rx_data_1 EXPORT_OF avl_usdrx1_xcvr.rx_data_1
add_interface rx_data_2 conduit end
set_interface_property rx_data_2 EXPORT_OF avl_usdrx1_xcvr.rx_data_2
add_interface rx_data_3 conduit end
set_interface_property rx_data_3 EXPORT_OF avl_usdrx1_xcvr.rx_data_3
add_interface rx_data_4 conduit end
set_interface_property rx_data_4 EXPORT_OF avl_usdrx1_xcvr.rx_data_4
add_interface rx_data_5 conduit end
set_interface_property rx_data_5 EXPORT_OF avl_usdrx1_xcvr.rx_data_5
add_interface rx_data_6 conduit end
set_interface_property rx_data_6 EXPORT_OF avl_usdrx1_xcvr.rx_data_6
add_interface rx_data_7 conduit end
set_interface_property rx_data_7 EXPORT_OF avl_usdrx1_xcvr.rx_data_7
add_interface rx_sysref conduit end
set_interface_property rx_sysref EXPORT_OF avl_usdrx1_xcvr.sysref
add_interface rx_sync conduit end
set_interface_property rx_sync EXPORT_OF avl_usdrx1_xcvr.sync
add_interface rx_ip_sof conduit end
set_interface_property rx_ip_sof EXPORT_OF avl_usdrx1_xcvr.ip_sof
add_interface rx_ip_data avalon_streaming source
set_interface_property rx_ip_data EXPORT_OF avl_usdrx1_xcvr.ip_data

# usdrx1-xcvr

add_instance axi_usdrx1_xcvr axi_adxcvr 1.0
set_instance_parameter_value axi_usdrx1_xcvr {ID} {1}
set_instance_parameter_value axi_usdrx1_xcvr {TX_OR_RX_N} {0}
set_instance_parameter_value axi_usdrx1_xcvr {NUM_OF_LANES} {8}

add_connection sys_clk.clk axi_usdrx1_xcvr.s_axi_clock
add_connection sys_clk.clk_reset axi_usdrx1_xcvr.s_axi_reset
add_connection axi_usdrx1_xcvr.if_up_rst avl_usdrx1_xcvr.rst
add_connection avl_usdrx1_xcvr.ready axi_usdrx1_xcvr.ready
add_connection axi_usdrx1_xcvr.core_pll_locked avl_usdrx1_xcvr.core_pll_locked

# ad9671

add_instance axi_ad9671_core_0 axi_ad9671 1.0
set_instance_parameter_value axi_ad9671_core_0 {ID} {0}
set_instance_parameter_value axi_ad9671_core_0 {QUAD_OR_DUAL_N} {0}
add_connection avl_usdrx1_xcvr.core_clk axi_ad9671_core_0.if_rx_clk
add_interface rx_ip_sof_0 conduit end
set_interface_property rx_ip_sof_0 EXPORT_OF axi_ad9671_core_0.if_rx_sof
add_interface rx_ip_data_0 avalon_streaming sink
set_interface_property rx_ip_data_0 EXPORT_OF axi_ad9671_core_0.if_rx_data
add_connection sys_clk.clk_reset axi_ad9671_core_0.s_axi_reset
add_connection sys_clk.clk axi_ad9671_core_0.s_axi_clock
add_interface rx_core_ch_0 conduit end
set_interface_property rx_core_ch_0 EXPORT_OF axi_ad9671_core_0.adc_ch
add_interface rx_core_sync_0 conduit end
set_interface_property rx_core_sync_0 EXPORT_OF axi_ad9671_core_0.if_sync
add_interface rx_core_ovf_0 conduit end
set_interface_property rx_core_ovf_0 EXPORT_OF axi_ad9671_core_0.if_adc_dovf
add_interface rx_core_unf_0 conduit end
set_interface_property rx_core_unf_0 EXPORT_OF axi_ad9671_core_0.if_adc_dunf

add_instance axi_ad9671_core_1 axi_ad9671 1.0
set_instance_parameter_value axi_ad9671_core_1 {ID} {1}
set_instance_parameter_value axi_ad9671_core_1 {QUAD_OR_DUAL_N} {0}
add_connection avl_usdrx1_xcvr.core_clk axi_ad9671_core_1.if_rx_clk
add_interface rx_ip_sof_1 conduit end
set_interface_property rx_ip_sof_1 EXPORT_OF axi_ad9671_core_1.if_rx_sof
add_interface rx_ip_data_1 avalon_streaming sink
set_interface_property rx_ip_data_1 EXPORT_OF axi_ad9671_core_1.if_rx_data
add_connection sys_clk.clk_reset axi_ad9671_core_1.s_axi_reset
add_connection sys_clk.clk axi_ad9671_core_1.s_axi_clock
add_interface rx_core_ch_1 conduit end
set_interface_property rx_core_ch_1 EXPORT_OF axi_ad9671_core_1.adc_ch
add_interface rx_core_sync_1 conduit end
set_interface_property rx_core_sync_1 EXPORT_OF axi_ad9671_core_1.if_sync
add_interface rx_core_ovf_1 conduit end
set_interface_property rx_core_ovf_1 EXPORT_OF axi_ad9671_core_1.if_adc_dovf
add_interface rx_core_unf_1 conduit end
set_interface_property rx_core_unf_1 EXPORT_OF axi_ad9671_core_1.if_adc_dunf

add_instance axi_ad9671_core_2 axi_ad9671 1.0
set_instance_parameter_value axi_ad9671_core_2 {ID} {2}
set_instance_parameter_value axi_ad9671_core_2 {QUAD_OR_DUAL_N} {0}
add_connection avl_usdrx1_xcvr.core_clk axi_ad9671_core_2.if_rx_clk
add_interface rx_ip_sof_2 conduit end
set_interface_property rx_ip_sof_2 EXPORT_OF axi_ad9671_core_2.if_rx_sof
add_interface rx_ip_data_2 avalon_streaming sink
set_interface_property rx_ip_data_2 EXPORT_OF axi_ad9671_core_2.if_rx_data
add_connection sys_clk.clk_reset axi_ad9671_core_2.s_axi_reset
add_connection sys_clk.clk axi_ad9671_core_2.s_axi_clock
add_interface rx_core_ch_2 conduit end
set_interface_property rx_core_ch_2 EXPORT_OF axi_ad9671_core_2.adc_ch
add_interface rx_core_sync_2 conduit end
set_interface_property rx_core_sync_2 EXPORT_OF axi_ad9671_core_2.if_sync
add_interface rx_core_ovf_2 conduit end
set_interface_property rx_core_ovf_2 EXPORT_OF axi_ad9671_core_2.if_adc_dovf
add_interface rx_core_unf_2 conduit end
set_interface_property rx_core_unf_2 EXPORT_OF axi_ad9671_core_2.if_adc_dunf

add_instance axi_ad9671_core_3 axi_ad9671 1.0
set_instance_parameter_value axi_ad9671_core_3 {ID} {3}
set_instance_parameter_value axi_ad9671_core_3 {QUAD_OR_DUAL_N} {0}
add_connection avl_usdrx1_xcvr.core_clk axi_ad9671_core_3.if_rx_clk
add_interface rx_ip_sof_3 conduit end
set_interface_property rx_ip_sof_3 EXPORT_OF axi_ad9671_core_3.if_rx_sof
add_interface rx_ip_data_3 avalon_streaming sink
set_interface_property rx_ip_data_3 EXPORT_OF axi_ad9671_core_3.if_rx_data
add_connection sys_clk.clk_reset axi_ad9671_core_3.s_axi_reset
add_connection sys_clk.clk axi_ad9671_core_3.s_axi_clock
add_interface rx_core_ch_3 conduit end
set_interface_property rx_core_ch_3 EXPORT_OF axi_ad9671_core_3.adc_ch
add_interface rx_core_sync_3 conduit end
set_interface_property rx_core_sync_3 EXPORT_OF axi_ad9671_core_3.if_sync
add_interface rx_core_ovf_3 conduit end
set_interface_property rx_core_ovf_3 EXPORT_OF axi_ad9671_core_3.if_adc_dovf
add_interface rx_core_unf_3 conduit end
set_interface_property rx_core_unf_3 EXPORT_OF axi_ad9671_core_3.if_adc_dunf

# usdrx1-fifo

add_instance usdrx1_adcfifo util_adcfifo 1.0
set_instance_parameter_value usdrx1_adcfifo {ADC_DATA_WIDTH} {512}
set_instance_parameter_value usdrx1_adcfifo {DMA_DATA_WIDTH} {512}
set_instance_parameter_value usdrx1_adcfifo {DMA_ADDRESS_WIDTH} {10}

add_connection sys_clk.clk_reset usdrx1_adcfifo.if_adc_rst
add_connection sys_dma_clk.clk_reset usdrx1_adcfifo.if_adc_rst
add_connection avl_usdrx1_xcvr.core_clk usdrx1_adcfifo.if_adc_clk
add_interface rx_ch_wr conduit end
set_interface_property rx_ch_wr EXPORT_OF usdrx1_adcfifo.if_adc_wr
add_interface rx_ch_wdata conduit end
set_interface_property rx_ch_wdata EXPORT_OF usdrx1_adcfifo.if_adc_wdata
add_interface rx_ch_wovf conduit end
set_interface_property rx_ch_wovf EXPORT_OF usdrx1_adcfifo.if_adc_wovf
add_connection sys_dma_clk.clk usdrx1_adcfifo.if_dma_clk

# usdrx1-dma

add_instance axi_usdrx1_dma axi_dmac 1.0
set_instance_parameter_value axi_usdrx1_dma {DMA_DATA_WIDTH_SRC} {512}
set_instance_parameter_value axi_usdrx1_dma {DMA_DATA_WIDTH_DEST} {512}
set_instance_parameter_value axi_usdrx1_dma {DMA_LENGTH_WIDTH} {24}
set_instance_parameter_value axi_usdrx1_dma {DMA_2D_TRANSFER} {0}
set_instance_parameter_value axi_usdrx1_dma {SYNC_TRANSFER_START} {1}
set_instance_parameter_value axi_usdrx1_dma {CYCLIC} {0}
set_instance_parameter_value axi_usdrx1_dma {DMA_TYPE_DEST} {0}
set_instance_parameter_value axi_usdrx1_dma {DMA_TYPE_SRC} {1}

add_connection sys_dma_clk.clk axi_usdrx1_dma.if_s_axis_aclk
add_connection usdrx1_adcfifo.if_dma_wr axi_usdrx1_dma.if_s_axis_valid
add_connection usdrx1_adcfifo.if_dma_wdata axi_usdrx1_dma.if_s_axis_data
add_connection usdrx1_adcfifo.if_dma_wready axi_usdrx1_dma.if_s_axis_ready
add_connection usdrx1_adcfifo.if_dma_xfer_req axi_usdrx1_dma.if_s_axis_xfer_req
add_connection sys_clk.clk_reset axi_usdrx1_dma.s_axi_reset
add_connection sys_clk.clk axi_usdrx1_dma.s_axi_clock
add_connection sys_dma_clk.clk_reset axi_usdrx1_dma.m_dest_axi_reset
add_connection sys_dma_clk.clk axi_usdrx1_dma.m_dest_axi_clock

# core-clock

add_instance rx_core_clk altera_clock_bridge 16.0
add_connection avl_usdrx1_xcvr.core_clk rx_core_clk.in_clk
add_interface rx_core_clk clock source
set_interface_property rx_core_clk EXPORT_OF rx_core_clk.out_clk

# phy reconfiguration

add_instance avl_phy_reconfig alt_xcvr_reconfig 16.0
set_instance_parameter_value avl_phy_reconfig {number_of_reconfig_interfaces} {8}
set_instance_parameter_value avl_phy_reconfig {gui_split_sizes} {1,1,1,1,1,1,1,1}
add_connection avl_phy_reconfig.ch0_0_to_xcvr avl_usdrx1_xcvr.phy_reconfig_to_xcvr_0 
add_connection avl_usdrx1_xcvr.phy_reconfig_from_xcvr_0 avl_phy_reconfig.ch0_0_from_xcvr 
add_connection avl_phy_reconfig.ch1_1_to_xcvr avl_usdrx1_xcvr.phy_reconfig_to_xcvr_1 
add_connection avl_usdrx1_xcvr.phy_reconfig_from_xcvr_1 avl_phy_reconfig.ch1_1_from_xcvr 
add_connection avl_phy_reconfig.ch2_2_to_xcvr avl_usdrx1_xcvr.phy_reconfig_to_xcvr_2 
add_connection avl_usdrx1_xcvr.phy_reconfig_from_xcvr_2 avl_phy_reconfig.ch2_2_from_xcvr 
add_connection avl_phy_reconfig.ch3_3_to_xcvr avl_usdrx1_xcvr.phy_reconfig_to_xcvr_3 
add_connection avl_usdrx1_xcvr.phy_reconfig_from_xcvr_3 avl_phy_reconfig.ch3_3_from_xcvr 
add_connection avl_phy_reconfig.ch4_4_to_xcvr avl_usdrx1_xcvr.phy_reconfig_to_xcvr_4 
add_connection avl_usdrx1_xcvr.phy_reconfig_from_xcvr_4 avl_phy_reconfig.ch4_4_from_xcvr 
add_connection avl_phy_reconfig.ch5_5_to_xcvr avl_usdrx1_xcvr.phy_reconfig_to_xcvr_5 
add_connection avl_usdrx1_xcvr.phy_reconfig_from_xcvr_5 avl_phy_reconfig.ch5_5_from_xcvr 
add_connection avl_phy_reconfig.ch6_6_to_xcvr avl_usdrx1_xcvr.phy_reconfig_to_xcvr_6 
add_connection avl_usdrx1_xcvr.phy_reconfig_from_xcvr_6 avl_phy_reconfig.ch6_6_from_xcvr 
add_connection avl_phy_reconfig.ch7_7_to_xcvr avl_usdrx1_xcvr.phy_reconfig_to_xcvr_7 
add_connection avl_usdrx1_xcvr.phy_reconfig_from_xcvr_7 avl_phy_reconfig.ch7_7_from_xcvr 
add_connection sys_clk.clk_reset avl_phy_reconfig.mgmt_rst_reset
add_connection sys_clk.clk avl_phy_reconfig.mgmt_clk_clk

# addresses

ad_cpu_interconnect 0x00010000 avl_phy_reconfig.reconfig_mgmt
ad_cpu_interconnect 0x00018000 avl_usdrx1_xcvr.core_pll_reconfig
ad_cpu_interconnect 0x00019000 avl_usdrx1_xcvr.ip_reconfig
ad_cpu_interconnect 0x00020000 axi_usdrx1_xcvr.s_axi
ad_cpu_interconnect 0x00050000 axi_ad9671_core_0.s_axi
ad_cpu_interconnect 0x00060000 axi_ad9671_core_1.s_axi
ad_cpu_interconnect 0x00070000 axi_ad9671_core_2.s_axi
ad_cpu_interconnect 0x00080000 axi_ad9671_core_3.s_axi
ad_cpu_interconnect 0x00090000 axi_usdrx1_dma.s_axi

# dma interconnects

ad_dma_interconnect axi_usdrx1_dma.m_dest_axi

# interrupts

ad_cpu_interrupt 11 axi_usdrx1_dma.interrupt_sender

