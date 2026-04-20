/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_dream_risc_v_top (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  wire [31:0] suport;

  core_top core_top_inst (
    .clk(clk),
    .rst_n(rst_n),
    .testmode_i(1'b0),
    .fetch_enable_i(1'b1),
    .irq_i(32'b0),
    .clock_gating_i(1'b0),
    .boot_addr_i(32'h00010000),

    //DBG_AXI4_SUPPORTED // nao ta definido
    //.dbg_master(dbg_master), 

    //.output(output),

    // DBG_WISHBONE_SUPPORTED // nao ta definido
    //.wb_dat_o(wb_dat_o),
    //.wb_dat_i(wb_dat_i),
    //.wb_cyc_o(wb_cyc_o),
    //.wb_stb_o(wb_stb_o),
    //.wb_sel_o(wb_sel_o),
    //.wb_we_o(wb_we_o),
    //.wb_ack_i(wb_ack_i),
    //.wb_cab_o(wb_cab_o),
    //.wb_err_i(wb_err_i),
    //.wb_cti_o(wb_cti_o),
    //.wb_bte_o(wb_bte_o),

    .tck_i(1'b0),
    .trstn_i(1'b0),
    .tms_i(1'b0),
    .tdi_i(1'b0),
    .tdo_o(),

    .instr_read(),
    .instr_busy(1'b0),
    .instr_rvalid(1'b0),
    .instr_addr(suport),
    .instr_rdata({24'b0, ui_in}),

    .lsu_read(),
    .lsu_busy(1'b0),
    .lsu_rvalid(1'b0),
    .lsu_addr(),
    .lsu_write(),
    .lsu_be(),
    .lsu_rdata(32'b0),
    .lsu_wdata(),
    .lsu_resp(2'b0),
    .lsu_wrespvalid(1'b0),

    .debug_read(1'b0),
    .debug_busy(),
    .debug_rvalid(),
    .debug_addr(15'b0),
    .debug_write(32'b0),
    .debug_wdata(32'b0),
    .debug_rdata()
  );

  assign uo_out = suport[7:0];

  assign uio_out[7:0] = 8'b0000_0000;
  assign uio_oe[7:0] = 8'b0000_0000;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, uio_in[7:0], 1'b0};

endmodule
