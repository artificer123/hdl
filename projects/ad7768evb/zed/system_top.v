// ***************************************************************************
// ***************************************************************************
// Copyright 2014 - 2017 (c) Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/master/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module system_top (

  inout       [14:0]      ddr_addr,
  inout       [ 2:0]      ddr_ba,
  inout                   ddr_cas_n,
  inout                   ddr_ck_n,
  inout                   ddr_ck_p,
  inout                   ddr_cke,
  inout                   ddr_cs_n,
  inout       [ 3:0]      ddr_dm,
  inout       [31:0]      ddr_dq,
  inout       [ 3:0]      ddr_dqs_n,
  inout       [ 3:0]      ddr_dqs_p,
  inout                   ddr_odt,
  inout                   ddr_ras_n,
  inout                   ddr_reset_n,
  inout                   ddr_we_n,

  inout                   fixed_io_ddr_vrn,
  inout                   fixed_io_ddr_vrp,
  inout       [53:0]      fixed_io_mio,
  inout                   fixed_io_ps_clk,
  inout                   fixed_io_ps_porb,
  inout                   fixed_io_ps_srstb,

  inout       [31:0]      gpio_bd,

  output                  hdmi_out_clk,
  output                  hdmi_vsync,
  output                  hdmi_hsync,
  output                  hdmi_data_e,
  output      [15:0]      hdmi_data,

  output                  i2s_mclk,
  output                  i2s_bclk,
  output                  i2s_lrclk,
  output                  i2s_sdata_out,
  input                   i2s_sdata_in,

  output                  spdif,

  inout                   iic_scl,
  inout                   iic_sda,
  inout       [ 1:0]      iic_mux_scl,
  inout       [ 1:0]      iic_mux_sda,

  input                   otg_vbusoc,

  input                   clk_in,
  input                   ready_in,
  input       [ 7:0]      data_in,

  output                  spi_csn,
  output                  spi_clk,
  output                  spi_mosi,
  input                   spi_miso,

  inout                   gpio_0_mode_0,
  inout                   gpio_1_mode_1,
  inout                   gpio_2_mode_2,
  inout                   gpio_3_mode_3,
  inout                   gpio_4_filter,
  inout                   reset_n,
  inout                   start_n,
  inout                   sync_n,
  inout                   sync_in_n,
  output                  mclk);

  // internal signals

  wire            adc_clk;
  wire            adc_valid;
  wire            adc_valid_0;
  wire            adc_valid_1;
  wire            adc_valid_2;
  wire            adc_valid_3;
  wire            adc_valid_4;
  wire            adc_valid_5;
  wire            adc_valid_6;
  wire            adc_valid_7;
  wire            adc_sync;
  wire    [31:0]  adc_data;
  wire    [31:0]  adc_data_0;
  wire    [31:0]  adc_data_1;
  wire    [31:0]  adc_data_2;
  wire    [31:0]  adc_data_3;
  wire    [31:0]  adc_data_4;
  wire    [31:0]  adc_data_5;
  wire    [31:0]  adc_data_6;
  wire    [31:0]  adc_data_7;
  wire            up_sshot;
  wire    [ 1:0]  up_format;
  wire            up_crc_enable;
  wire            up_crc_4_or_16_n;
  wire    [63:0]  adc_gpio_i;
  wire    [63:0]  adc_gpio_o;
  wire    [63:0]  adc_gpio_t;
  wire    [63:0]  gpio_i;
  wire    [63:0]  gpio_o;
  wire    [63:0]  gpio_t;
  wire    [ 1:0]  iic_mux_scl_i_s;
  wire    [ 1:0]  iic_mux_scl_o_s;
  wire            iic_mux_scl_t_s;
  wire    [ 1:0]  iic_mux_sda_i_s;
  wire    [ 1:0]  iic_mux_sda_o_s;
  wire            iic_mux_sda_t_s;

  // use crystal

  assign mclk = 1'b0;
  assign up_sshot = gpio_o[36];
  assign up_format = gpio_o[35:34];
  assign up_crc_enable = gpio_o[33];
  assign up_crc_4_or_16_n = gpio_o[32];

  // instantiations

  ad_iobuf #(.DATA_WIDTH(9)) i_iobuf (
    .dio_t ({gpio_t[52:48], gpio_t[43:40]}),
    .dio_i ({gpio_o[52:48], gpio_o[43:40]}),
    .dio_o ({gpio_i[52:48], gpio_i[43:40]}),
    .dio_p ({ gpio_4_filter,        // 52
              gpio_3_mode_3,        // 51
              gpio_2_mode_2,        // 50
              gpio_1_mode_1,        // 49
              gpio_0_mode_0,        // 48
              sync_in_n,            // 43
              sync_n,               // 42
              start_n,              // 41
              reset_n}));           // 40

  ad_iobuf #(.DATA_WIDTH(32)) i_iobuf_bd (
    .dio_t (gpio_t[31:0]),
    .dio_i (gpio_o[31:0]),
    .dio_o (gpio_i[31:0]),
    .dio_p (gpio_bd));

  assign gpio_i[36:32] = 5'b0;
  assign gpio_i[39:37] = gpio_o[39:37];
  assign gpio_i[47:44] = gpio_o[47:44];
  assign gpio_i[63:53] = gpio_o[63:53];

  ad_iobuf #(.DATA_WIDTH(2)) i_iic_mux_scl (
    .dio_t ({iic_mux_scl_t_s, iic_mux_scl_t_s}),
    .dio_i (iic_mux_scl_o_s),
    .dio_o (iic_mux_scl_i_s),
    .dio_p (iic_mux_scl));

  ad_iobuf #(.DATA_WIDTH(2)) i_iic_mux_sda (
    .dio_t ({iic_mux_sda_t_s, iic_mux_sda_t_s}),
    .dio_i (iic_mux_sda_o_s),
    .dio_o (iic_mux_sda_i_s),
    .dio_p (iic_mux_sda));

  ad7768_if i_ad7768_if (
    .clk_in (clk_in),
    .ready_in (ready_in),
    .data_in (data_in),
    .adc_clk (adc_clk),
    .adc_valid (adc_valid),
    .adc_valid_0 (adc_valid_0),
    .adc_valid_1 (adc_valid_1),
    .adc_valid_2 (adc_valid_2),
    .adc_valid_3 (adc_valid_3),
    .adc_valid_4 (adc_valid_4),
    .adc_valid_5 (adc_valid_5),
    .adc_valid_6 (adc_valid_6),
    .adc_valid_7 (adc_valid_7),
    .adc_sync (adc_sync),
    .adc_data (adc_data),
    .adc_data_0 (adc_data_0),
    .adc_data_1 (adc_data_1),
    .adc_data_2 (adc_data_2),
    .adc_data_3 (adc_data_3),
    .adc_data_4 (adc_data_4),
    .adc_data_5 (adc_data_5),
    .adc_data_6 (adc_data_6),
    .adc_data_7 (adc_data_7),
    .up_sshot (up_sshot),
    .up_format (up_format),
    .up_crc_enable (up_crc_enable),
    .up_crc_4_or_16_n (up_crc_4_or_16_n),
    .up_status_clr (adc_gpio_o[32:0]),
    .up_status (adc_gpio_i[32:0]));

  system_wrapper i_system_wrapper (
    .adc_clk (adc_clk),
    .adc_data (adc_data),
    .adc_data_0 (adc_data_0),
    .adc_data_1 (adc_data_1),
    .adc_data_2 (adc_data_2),
    .adc_data_3 (adc_data_3),
    .adc_data_4 (adc_data_4),
    .adc_data_5 (adc_data_5),
    .adc_data_6 (adc_data_6),
    .adc_data_7 (adc_data_7),
    .adc_gpio_0_i (adc_gpio_i[31:0]),
    .adc_gpio_0_o (adc_gpio_o[31:0]),
    .adc_gpio_0_t (adc_gpio_t[31:0]),
    .adc_gpio_1_i (adc_gpio_i[63:32]),
    .adc_gpio_1_o (adc_gpio_o[63:32]),
    .adc_gpio_1_t (adc_gpio_t[63:32]),
    .adc_valid (adc_valid),
    .adc_valid_0 (adc_valid_0),
    .adc_valid_1 (adc_valid_1),
    .adc_valid_2 (adc_valid_2),
    .adc_valid_3 (adc_valid_3),
    .adc_valid_4 (adc_valid_4),
    .adc_valid_5 (adc_valid_5),
    .adc_valid_6 (adc_valid_6),
    .adc_valid_7 (adc_valid_7),
    .adc_sync (adc_sync),
    .ddr_addr (ddr_addr),
    .ddr_ba (ddr_ba),
    .ddr_cas_n (ddr_cas_n),
    .ddr_ck_n (ddr_ck_n),
    .ddr_ck_p (ddr_ck_p),
    .ddr_cke (ddr_cke),
    .ddr_cs_n (ddr_cs_n),
    .ddr_dm (ddr_dm),
    .ddr_dq (ddr_dq),
    .ddr_dqs_n (ddr_dqs_n),
    .ddr_dqs_p (ddr_dqs_p),
    .ddr_odt (ddr_odt),
    .ddr_ras_n (ddr_ras_n),
    .ddr_reset_n (ddr_reset_n),
    .ddr_we_n (ddr_we_n),
    .fixed_io_ddr_vrn (fixed_io_ddr_vrn),
    .fixed_io_ddr_vrp (fixed_io_ddr_vrp),
    .fixed_io_mio (fixed_io_mio),
    .fixed_io_ps_clk (fixed_io_ps_clk),
    .fixed_io_ps_porb (fixed_io_ps_porb),
    .fixed_io_ps_srstb (fixed_io_ps_srstb),
    .gpio_i (gpio_i),
    .gpio_o (gpio_o),
    .gpio_t (gpio_t),
    .hdmi_data (hdmi_data),
    .hdmi_data_e (hdmi_data_e),
    .hdmi_hsync (hdmi_hsync),
    .hdmi_out_clk (hdmi_out_clk),
    .hdmi_vsync (hdmi_vsync),
    .i2s_bclk (i2s_bclk),
    .i2s_lrclk (i2s_lrclk),
    .i2s_mclk (i2s_mclk),
    .i2s_sdata_in (i2s_sdata_in),
    .i2s_sdata_out (i2s_sdata_out),
    .iic_fmc_scl_io (iic_scl),
    .iic_fmc_sda_io (iic_sda),
    .iic_mux_scl_i (iic_mux_scl_i_s),
    .iic_mux_scl_o (iic_mux_scl_o_s),
    .iic_mux_scl_t (iic_mux_scl_t_s),
    .iic_mux_sda_i (iic_mux_sda_i_s),
    .iic_mux_sda_o (iic_mux_sda_o_s),
    .iic_mux_sda_t (iic_mux_sda_t_s),
    .otg_vbusoc (otg_vbusoc),
    .spdif (spdif),
    .spi0_clk_i (1'b0),
    .spi0_clk_o (spi_clk),
    .spi0_csn_0_o (spi_csn),
    .spi0_csn_1_o (),
    .spi0_csn_2_o (),
    .spi0_csn_i (1'b1),
    .spi0_sdi_i (spi_miso),
    .spi0_sdo_i (1'b0),
    .spi0_sdo_o (spi_mosi),
    .spi1_clk_i (1'b0),
    .spi1_clk_o (),
    .spi1_csn_0_o (),
    .spi1_csn_1_o (),
    .spi1_csn_2_o (),
    .spi1_csn_i (1'b1),
    .spi1_sdi_i (1'b0),
    .spi1_sdo_i (1'b0),
    .spi1_sdo_o ());

endmodule

// ***************************************************************************
// ***************************************************************************
