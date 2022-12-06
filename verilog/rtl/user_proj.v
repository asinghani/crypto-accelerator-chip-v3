`default_nettype none

`include "crypto_accelerator.v"
`include "tt.v"

module user_proj (
`ifdef USE_POWER_PINS
    inout vdd,	// User area 1 1.8V supply
    inout vss,	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [63:0] la_data_in,
    output [63:0] la_data_out,
    input  [63:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // IRQ
    output [2:0] irq
);
    wire clk = wb_clk_i;
    wire rst = wb_rst_i;

    wire [`MPRJ_IO_PADS-1:0] io_in;
    wire [`MPRJ_IO_PADS-1:0] io_out;
    wire [`MPRJ_IO_PADS-1:0] io_oeb;

    assign io_oeb[`MPRJ_IO_PADS-1:20] = '1;
    assign io_oeb[19:12] = '0;
    assign io_oeb[11:0] = '1;
    assign la_oenb[63:20] = '1;
    assign la_oenb[19:12] = '0;
    assign la_oenb[11:0] = '1;

    tt tt1 (
        .din(io_in[27:20]),
        .ds(io_in[30:28]),
        .dout(io_out[19:12])
    );

    tt tt2 (
        .din(la_data_in[27:20]),
        .ds(la_data_in[30:28]),
        .dout(la_data_out[19:12])
    );

	AesWishbone aes (
        .clock(clk),
        .reset(rst),
        .io_bus_cyc(wbs_cyc_i),
        .io_bus_stb(wbs_stb_i),
        .io_bus_we(wbs_we_i),
        .io_bus_sel(wbs_sel_i),
        .io_bus_addr(wbs_adr_i[24:0]),
        .io_bus_data_wr(wbs_dat_i),
        .io_bus_ack(wbs_ack_o),
        .io_bus_data_rd(wbs_dat_o)
    );


endmodule

`default_nettype wire
