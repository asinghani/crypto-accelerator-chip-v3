module beepboop (
	io_in,
	io_out
);
	input [7:0] io_in;
	output wire [7:0] io_out;
	wire clock = io_in[0];
	wire reset = io_in[1];
	wire btn = io_in[2];
	reg red;
	reg yellow;
	reg green;
	reg walk;
	reg no_walk;
	reg the_beepbooper;
	assign io_out = {2'b00, the_beepbooper, no_walk, walk, green, yellow, red};
	reg [15:0] counter;
	always @(posedge clock)
		if (reset)
			counter <= 0;
		else begin
			if (counter != 0)
				counter <= counter + 1;
			if (counter >= 2200)
				counter <= 0;
			if ((counter == 0) && btn)
				counter <= 1;
		end
	always @(*) begin
		green = (counter == 0) || (counter >= 2200);
		yellow = (counter > 0) && (counter < 200);
		red = (counter >= 200) && (counter < 2200);
		walk = (counter > 300) && (counter < 1500);
		the_beepbooper = walk;
		no_walk = (((((counter >= 1500) && (counter < 1600)) || ((counter >= 1700) && (counter < 1800))) || ((counter >= 1900) && (counter < 2000))) || (counter >= 2100)) || (counter <= 300);
	end
endmodule
`default_nettype none
module tt (
	din,
	ds,
	dout
);
	input wire [7:0] din;
	input wire [2:0] ds;
	output wire [7:0] dout;
	wire [7:0] ttA_out [0:7];
	assign dout = ttA_out[ds];
	tt_ngaertne ttA_0(
		.io_in(din),
		.io_out(ttA_out[0])
	);
	tt_jrecta ttA_1(
		.io_in(din),
		.io_out(ttA_out[1])
	);
	tt_sophiali ttA_2(
		.io_in(din),
		.io_out(ttA_out[2])
	);
	tt_mgee3 ttA_3(
		.io_in(din),
		.io_out(ttA_out[3])
	);
	tt_jxlu ttA_4(
		.io_in(din),
		.io_out(ttA_out[4])
	);
	tt_qilins ttA_5(
		.io_in(din),
		.io_out(ttA_out[5])
	);
	beepboop ttA_6(
		.io_in(din),
		.io_out(ttA_out[6])
	);
endmodule
module tt_ngaertne (
	io_in,
	io_out
);
	input wire [7:0] io_in;
	output wire [7:0] io_out;
	wire clock;
	wire reset;
	assign clock = io_in[0];
	assign reset = io_in[1];
	reg [3:0] prog [15:0];
	reg [3:0] data [15:0];
	wire [1:0] instruction;
	assign instruction = io_in[3:2];
	reg [3:0] pc;
	wire [3:0] datac;
	wire [3:0] progc;
	assign progc = prog[pc];
	assign datac = data[pc];
	reg [3:0] regval;
	assign io_out = {regval, pc};
	wire [3:0] inputdata;
	reg lastdata3;
	assign inputdata = io_in[7:4];
	wire [3:0] npc;
	assign npc = pc + 1;
	always @(posedge clock)
		if (!reset) begin
			lastdata3 <= inputdata[3];
			case (instruction)
				2'd0: begin
					prog[pc] <= inputdata;
					pc <= npc;
				end
				2'd1: begin
					data[pc] <= inputdata;
					pc <= npc;
				end
				2'd2: pc <= inputdata;
				2'd3:
					case (progc)
						4'd0: begin
							regval <= datac;
							pc <= npc;
						end
						4'd1: begin
							data[datac] <= regval;
							pc <= npc;
						end
						4'd2: begin
							regval <= regval + datac;
							pc <= npc;
						end
						4'd4: begin
							regval <= regval - datac;
							pc <= npc;
						end
						4'd3: begin
							pc <= npc;
							regval <= regval * datac;
						end
						4'd5: begin
							pc <= npc;
							regval <= (datac < 4 ? regval << datac : regval << 3);
						end
						4'd6: begin
							pc <= npc;
							regval <= (datac < 4 ? regval >> datac : regval >> 3);
						end
						4'd7: begin
							pc <= (lastdata3 ? datac : npc);
							regval <= regval;
						end
						4'd8: begin
							pc <= npc;
							regval <= regval && datac;
						end
						4'd9: begin
							pc <= npc;
							regval <= regval || datac;
						end
						4'd10: begin
							pc <= npc;
							regval <= regval == datac;
						end
						4'd11: begin
							pc <= npc;
							regval <= regval != datac;
						end
						4'd12: begin
							pc <= npc;
							regval <= regval & datac;
						end
						4'd15: begin
							pc <= npc;
							regval <= ~regval;
						end
						4'd13: begin
							pc <= npc;
							regval <= regval | datac;
						end
						4'd14: begin
							pc <= npc;
							regval <= !regval;
						end
					endcase
			endcase
		end
		else begin
			pc <= 0;
			regval <= 0;
			data[0] <= 4'd0;
			data[1] <= 4'd0;
			data[2] <= 4'd0;
			data[3] <= 4'd0;
			data[4] <= 4'd0;
			data[5] <= 4'd0;
			data[6] <= 4'd0;
			data[7] <= 4'd0;
			data[8] <= 4'd0;
			data[9] <= 4'd0;
			data[10] <= 4'd0;
			data[11] <= 4'd0;
			data[12] <= 4'd0;
			data[13] <= 4'd0;
			data[14] <= 4'd0;
			data[15] <= 4'd0;
			prog[0] <= 4'd0;
			prog[1] <= 4'd0;
			prog[2] <= 4'd0;
			prog[3] <= 4'd0;
			prog[4] <= 4'd0;
			prog[5] <= 4'd0;
			prog[6] <= 4'd0;
			prog[7] <= 4'd0;
			prog[8] <= 4'd0;
			prog[9] <= 4'd0;
			prog[10] <= 4'd0;
			prog[11] <= 4'd0;
			prog[12] <= 4'd0;
			prog[13] <= 4'd0;
			prog[14] <= 4'd0;
			prog[15] <= 4'd0;
			lastdata3 <= 1'd0;
		end
endmodule
module tt_jrecta (
	io_in,
	io_out
);
	input [7:0] io_in;
	output wire [7:0] io_out;
	async_fifo #(
		.WIDTH(3),
		.DEPTH(8)
	) top(
		.rst(io_in[2]),
		.wclk(io_in[0]),
		.we(io_in[3]),
		.full(io_out[3]),
		.wdata(io_in[7:5]),
		.rclk(io_in[1]),
		.re(io_in[4]),
		.empty(io_out[4]),
		.rdata(io_out[7:5])
	);
endmodule
module async_fifo (
	rst,
	wclk,
	we,
	full,
	wdata,
	rclk,
	re,
	empty,
	rdata
);
	parameter WIDTH = 4;
	parameter DEPTH = 4;
	input wire rst;
	input wire wclk;
	input wire we;
	output wire full;
	input wire [WIDTH - 1:0] wdata;
	input wire rclk;
	input wire re;
	output wire empty;
	output wire [WIDTH - 1:0] rdata;
	parameter PTR_WIDTH = $clog2(DEPTH) + 1;
	wire [PTR_WIDTH - 1:0] wptr;
	wire [PTR_WIDTH - 1:0] wptr_gray;
	wire [PTR_WIDTH - 1:0] rptr;
	wire [PTR_WIDTH - 1:0] rptr_gray;
	reg [WIDTH - 1:0] data [DEPTH - 1:0];
	always @(posedge wclk)
		if (we & ~full)
			data[wptr[PTR_WIDTH - 2:0]] <= wdata;
	assign rdata = data[rptr[PTR_WIDTH - 2:0]];
	write_half #(.PTR_WIDTH(PTR_WIDTH)) frontend(
		.rst(rst),
		.wclk(wclk),
		.we(we),
		.rptr_gray(rptr_gray),
		.wptr(wptr),
		.wptr_gray(wptr_gray),
		.full(full)
	);
	read_half #(.PTR_WIDTH(PTR_WIDTH)) backend(
		.rst(rst),
		.rclk(rclk),
		.re(re),
		.wptr_gray(wptr_gray),
		.rptr(rptr),
		.rptr_gray(rptr_gray),
		.empty(empty)
	);
endmodule
module read_half (
	rst,
	rclk,
	re,
	wptr_gray,
	rptr,
	rptr_gray,
	empty
);
	parameter PTR_WIDTH = 0;
	input wire rst;
	input wire rclk;
	input wire re;
	input wire [PTR_WIDTH - 1:0] wptr_gray;
	output wire [PTR_WIDTH - 1:0] rptr;
	output wire [PTR_WIDTH - 1:0] rptr_gray;
	output wire empty;
	wire [PTR_WIDTH - 1:0] wptr_gray1;
	wire [PTR_WIDTH - 1:0] wptr_gray2;
	function automatic signed [PTR_WIDTH - 1:0] sv2v_cast_06624_signed;
		input reg signed [PTR_WIDTH - 1:0] inp;
		sv2v_cast_06624_signed = inp;
	endfunction
	reg_ar #(.WIDTH(PTR_WIDTH)) rptr_reg(
		.rst(rst),
		.clk(rclk),
		.en(re & ~empty),
		.d(rptr + sv2v_cast_06624_signed(1)),
		.q(rptr)
	);
	localparam [0:0] sv2v_uu_wptr_gray_sync_ext_en_1 = 1'sb1;
	reg_ar #(.WIDTH(2 * PTR_WIDTH)) wptr_gray_sync(
		.rst(rst),
		.clk(rclk),
		.en(sv2v_uu_wptr_gray_sync_ext_en_1),
		.d({wptr_gray, wptr_gray1}),
		.q({wptr_gray1, wptr_gray2})
	);
	bin2gray #(.WIDTH(PTR_WIDTH)) rptr_b2g(
		.binary(rptr),
		.gray(rptr_gray)
	);
	assign empty = wptr_gray2 == rptr_gray;
endmodule
module write_half (
	rst,
	wclk,
	we,
	rptr_gray,
	wptr,
	wptr_gray,
	full
);
	parameter PTR_WIDTH = 0;
	input wire rst;
	input wire wclk;
	input wire we;
	input wire [PTR_WIDTH - 1:0] rptr_gray;
	output wire [PTR_WIDTH - 1:0] wptr;
	output wire [PTR_WIDTH - 1:0] wptr_gray;
	output wire full;
	wire [PTR_WIDTH - 1:0] rptr_gray1;
	wire [PTR_WIDTH - 1:0] rptr_gray2;
	function automatic signed [PTR_WIDTH - 1:0] sv2v_cast_06624_signed;
		input reg signed [PTR_WIDTH - 1:0] inp;
		sv2v_cast_06624_signed = inp;
	endfunction
	reg_ar #(.WIDTH(PTR_WIDTH)) wptr_reg(
		.rst(rst),
		.clk(wclk),
		.en(we & ~full),
		.d(wptr + sv2v_cast_06624_signed(1)),
		.q(wptr)
	);
	localparam [0:0] sv2v_uu_rptr_gray_sync_ext_en_1 = 1'sb1;
	reg_ar #(.WIDTH(2 * PTR_WIDTH)) rptr_gray_sync(
		.rst(rst),
		.clk(wclk),
		.en(sv2v_uu_rptr_gray_sync_ext_en_1),
		.d({rptr_gray, rptr_gray1}),
		.q({rptr_gray1, rptr_gray2})
	);
	bin2gray #(.WIDTH(PTR_WIDTH)) wptr_b2g(
		.binary(wptr),
		.gray(wptr_gray)
	);
	generate
		if (PTR_WIDTH > 2) begin : genblk1
			assign full = (rptr_gray2[PTR_WIDTH - 1-:2] == ~wptr_gray[PTR_WIDTH - 1-:2]) && (rptr_gray2[0+:PTR_WIDTH - 2] == wptr_gray[0+:PTR_WIDTH - 2]);
		end
		else begin : genblk1
			assign full = rptr_gray2 == ~wptr_gray;
		end
	endgenerate
endmodule
module reg_ar (
	clk,
	rst,
	en,
	d,
	q
);
	parameter WIDTH = 0;
	input wire clk;
	input wire rst;
	input wire en;
	input wire [WIDTH - 1:0] d;
	output reg [WIDTH - 1:0] q;
	always @(posedge clk or posedge rst)
		if (rst)
			q <= 1'sb0;
		else if (en)
			q <= d;
endmodule
module gray2bin (
	gray,
	binary
);
	parameter WIDTH = 0;
	input wire [WIDTH - 1:0] gray;
	output wire [WIDTH - 1:0] binary;
	genvar i;
	generate
		for (i = 0; i < (WIDTH - 1); i = i + 1) begin : genblk1
			assign binary[i] = gray[i] ^ binary[i + 1];
		end
	endgenerate
	assign binary[WIDTH - 1] = gray[WIDTH - 1];
endmodule
module bin2gray (
	binary,
	gray
);
	parameter WIDTH = 0;
	input wire [WIDTH - 1:0] binary;
	output wire [WIDTH - 1:0] gray;
	assign gray = binary ^ (binary >> 1);
endmodule
module tt_sophiali (
	io_in,
	io_out
);
	input wire [7:0] io_in;
	output reg [7:0] io_out;
	reg clock;
	reg reset;
	reg en;
	reg [2:0] in;
	reg [1:0] arithOp;
	always @(*) begin
		clock = io_in[0];
		reset = io_in[1];
		en = io_in[2];
		in = io_in[3:5];
		arithOp = io_in[6:7];
	end
	wire enable;
	reg state;
	reg nextState;
	always @(posedge clock or posedge reset)
		if (reset)
			io_out <= 0;
		else if (enable)
			case (arithOp)
				2'b00: io_out <= io_out + in;
				2'b01: io_out <= io_out - in;
				2'b10: io_out <= io_out ^ {5'b00000, in};
				2'b11: io_out <= io_out << in;
			endcase
	always @(posedge clock or posedge reset)
		if (reset)
			state <= 1'd0;
		else
			state <= nextState;
	assign enable = (state == 1'd0) && (nextState == 1'd1);
	always @(*)
		if (state == 1'd0)
			nextState = (en ? 1'd1 : 1'd0);
		else
			nextState = (en ? 1'd1 : 1'd0);
endmodule
module tt_mgee3 (
	io_in,
	io_out
);
	input [7:0] io_in;
	output wire [7:0] io_out;
	wire net1 = io_in[0];
	wire net2 = io_in[1];
	wire net3 = io_in[2];
	wire net4 = io_in[3];
	wire net5 = io_in[4];
	wire net6 = io_in[5];
	wire net7 = 1'b1;
	wire net8;
	wire net9 = 1'b0;
	wire net10;
	wire net11;
	wire net12;
	wire net13;
	wire net14;
	wire net15;
	wire net16;
	wire net17;
	wire net18;
	wire net19;
	wire net20;
	wire net21 = 1'b0;
	xor_cell gate11(
		.a(net2),
		.b(net5),
		.out(net8)
	);
	xor_cell gate7(
		.a(net8),
		.b(net10),
		.out(net11)
	);
	and_cell gate8(
		.a(net8),
		.b(net10),
		.out(net12)
	);
	and_cell gate9(
		.a(net2),
		.b(net5),
		.out(net13)
	);
	or_cell gate10(
		.a(net12),
		.b(net13),
		.out(net14)
	);
	xor_cell gate1(
		.a(net3),
		.b(net6),
		.out(net15)
	);
	xor_cell gate2(
		.a(net15),
		.b(net14),
		.out(net16)
	);
	and_cell gate3(
		.a(net15),
		.b(net14),
		.out(net17)
	);
	and_cell gate4(
		.a(net3),
		.b(net6),
		.out(net18)
	);
	or_cell gate5(
		.a(net17),
		.b(net18),
		.out(net19)
	);
	and_cell gate6(
		.a(net1),
		.b(net4),
		.out(net10)
	);
	xor_cell gate12(
		.a(net1),
		.b(net4),
		.out(net20)
	);
endmodule
module tt_jxlu (
	io_in,
	io_out
);
	input wire [7:0] io_in;
	output wire [7:0] io_out;
	wire clk;
	wire reset;
	wire [5:0] duty;
	reg pwm_signal;
	assign io_out = pwm_signal;
	assign clk = io_in[0];
	assign reset = io_in[1];
	assign duty = io_in[7:2];
	reg [5:0] counter;
	reg [5:0] active_duty;
	always @(posedge clk)
		if (reset == 1) begin
			if (duty > 6'd50)
				active_duty <= 6'd50;
			else
				active_duty <= duty;
			counter <= 0;
		end
		else begin
			counter <= counter + 1'b1;
			if (counter == 49)
				counter <= 0;
			if (counter >= active_duty)
				pwm_signal <= 1'b0;
			else
				pwm_signal <= 1'b1;
		end
endmodule
`default_nettype none
module tt_qilins (
	io_in,
	io_out
);
	input [7:0] io_in;
	output wire [7:0] io_out;
	wire net1 = io_in[0];
	wire net2 = io_in[1];
	wire net3 = io_in[2];
	wire net4 = io_in[3];
	wire net5;
	wire net6;
	wire net7;
	wire net8;
	wire net9;
	wire net10;
	wire net11;
	wire net12;
	wire net13 = 1'b0;
	wire net14 = 1'b1;
	wire net15;
	wire net16;
	wire net17;
	wire net18;
	wire net19;
	wire net20;
	wire net21;
	wire net22;
	wire net23;
	wire net24;
	wire net25;
	wire net26;
	wire net27;
	wire net28;
	wire net29;
	wire net30;
	wire net31;
	wire net32;
	wire net33;
	wire net34;
	wire net35;
	wire net36;
	wire net37;
	wire net38;
	wire net39;
	wire net40;
	wire net41;
	wire net42;
	wire net43;
	wire net44;
	wire net45;
	wire net46;
	wire net47;
	wire net48;
	wire net49;
	wire net50;
	wire net51;
	wire net52;
	wire net53;
	wire net54;
	wire net55;
	wire net56;
	wire net57;
	wire net58;
	wire net59;
	wire net60;
	wire net61;
	wire net62;
	wire net63;
	wire net64;
	wire net65;
	wire net66;
	wire net67;
	wire net68;
	wire net69;
	wire net70;
	wire net71;
	wire net72;
	wire net73;
	wire net74;
	wire net75;
	wire net76;
	wire net77;
	wire net78;
	wire net79;
	wire net80;
	wire net81;
	wire net82;
	wire net83;
	wire net84;
	wire net85;
	wire net86;
	assign io_out[0] = net5;
	assign io_out[1] = net6;
	assign io_out[2] = net7;
	assign io_out[3] = net8;
	assign io_out[4] = net9;
	assign io_out[5] = net10;
	assign io_out[6] = net11;
	assign io_out[7] = net12;
	not_cell gate7(
		.in(net1),
		.out(net15)
	);
	not_cell gate8(
		.in(net2),
		.out(net16)
	);
	not_cell gate9(
		.in(net3),
		.out(net17)
	);
	not_cell gate10(
		.in(net4),
		.out(net18)
	);
	and_cell gate11(
		.a(net15),
		.b(net2),
		.out(net19)
	);
	and_cell gate14(
		.a(net17),
		.b(net19),
		.out(net20)
	);
	and_cell gate12(
		.a(net17),
		.b(net18),
		.out(net21)
	);
	and_cell gate15(
		.a(net2),
		.b(net18),
		.out(net22)
	);
	and_cell gate16(
		.a(net1),
		.b(net16),
		.out(net23)
	);
	and_cell gate17(
		.a(net1),
		.b(net3),
		.out(net24)
	);
	or_cell gate18(
		.a(net20),
		.b(net21),
		.out(net25)
	);
	or_cell gate19(
		.a(net22),
		.b(net23),
		.out(net26)
	);
	or_cell gate20(
		.a(net25),
		.b(net27),
		.out(net10)
	);
	or_cell gate21(
		.a(net26),
		.b(net24),
		.out(net27)
	);
	and_cell gate22(
		.a(net1),
		.b(net16),
		.out(net28)
	);
	and_cell gate23(
		.a(net17),
		.b(net28),
		.out(net29)
	);
	and_cell gate24(
		.a(net15),
		.b(net2),
		.out(net30)
	);
	and_cell gate25(
		.a(net30),
		.b(net4),
		.out(net31)
	);
	and_cell gate26(
		.a(net1),
		.b(net18),
		.out(net32)
	);
	and_cell gate27(
		.a(net15),
		.b(net3),
		.out(net33)
	);
	and_cell gate28(
		.a(net2),
		.b(net3),
		.out(net34)
	);
	and_cell gate29(
		.a(net16),
		.b(net18),
		.out(net35)
	);
	or_cell gate30(
		.a(net29),
		.b(net31),
		.out(net36)
	);
	or_cell gate31(
		.a(net32),
		.b(net33),
		.out(net37)
	);
	or_cell gate32(
		.a(net34),
		.b(net35),
		.out(net38)
	);
	or_cell gate33(
		.a(net36),
		.b(net37),
		.out(net39)
	);
	or_cell gate34(
		.a(net39),
		.b(net38),
		.out(net5)
	);
	and_cell gate13(
		.a(net15),
		.b(net17),
		.out(net40)
	);
	and_cell gate35(
		.a(net18),
		.b(net40),
		.out(net41)
	);
	and_cell gate36(
		.a(net15),
		.b(net3),
		.out(net42)
	);
	and_cell gate37(
		.a(net4),
		.b(net42),
		.out(net43)
	);
	and_cell gate38(
		.a(net1),
		.b(net17),
		.out(net44)
	);
	and_cell gate39(
		.a(net4),
		.b(net44),
		.out(net45)
	);
	and_cell gate40(
		.a(net16),
		.b(net17),
		.out(net46)
	);
	and_cell gate41(
		.a(net16),
		.b(net18),
		.out(net47)
	);
	or_cell gate42(
		.a(net41),
		.b(net43),
		.out(net48)
	);
	or_cell gate43(
		.a(net45),
		.b(net46),
		.out(net49)
	);
	or_cell gate44(
		.a(net48),
		.b(net49),
		.out(net50)
	);
	or_cell gate45(
		.a(net50),
		.b(net47),
		.out(net6)
	);
	and_cell gate46(
		.a(net15),
		.b(net17),
		.out(net51)
	);
	and_cell gate47(
		.a(net15),
		.b(net4),
		.out(net52)
	);
	and_cell gate48(
		.a(net17),
		.b(net4),
		.out(net53)
	);
	and_cell gate49(
		.a(net15),
		.b(net2),
		.out(net54)
	);
	and_cell gate50(
		.a(net1),
		.b(net16),
		.out(net55)
	);
	or_cell gate51(
		.a(net51),
		.b(net52),
		.out(net56)
	);
	or_cell gate52(
		.a(net53),
		.b(net54),
		.out(net57)
	);
	or_cell gate53(
		.a(net58),
		.b(net55),
		.out(net7)
	);
	or_cell gate54(
		.a(net56),
		.b(net57),
		.out(net58)
	);
	and_cell gate55(
		.a(net15),
		.b(net16),
		.out(net59)
	);
	and_cell gate56(
		.a(net59),
		.b(net18),
		.out(net60)
	);
	and_cell gate57(
		.a(net16),
		.b(net3),
		.out(net61)
	);
	and_cell gate58(
		.a(net61),
		.b(net4),
		.out(net62)
	);
	and_cell gate59(
		.a(net2),
		.b(net17),
		.out(net63)
	);
	and_cell gate60(
		.a(net63),
		.b(net4),
		.out(net64)
	);
	and_cell gate61(
		.a(net2),
		.b(net3),
		.out(net65)
	);
	and_cell gate62(
		.a(net65),
		.b(net18),
		.out(net66)
	);
	and_cell gate63(
		.a(net1),
		.b(net17),
		.out(net67)
	);
	or_cell gate64(
		.a(net60),
		.b(net62),
		.out(net68)
	);
	or_cell gate65(
		.a(net68),
		.b(net69),
		.out(net70)
	);
	or_cell gate66(
		.a(net64),
		.b(net66),
		.out(net69)
	);
	or_cell gate68(
		.a(net70),
		.b(net67),
		.out(net8)
	);
	and_cell gate67(
		.a(net16),
		.b(net18),
		.out(net71)
	);
	and_cell gate69(
		.a(net3),
		.b(net18),
		.out(net72)
	);
	and_cell gate70(
		.a(net1),
		.b(net3),
		.out(net73)
	);
	and_cell gate71(
		.a(net1),
		.b(net2),
		.out(net74)
	);
	or_cell gate72(
		.a(net71),
		.b(net72),
		.out(net75)
	);
	or_cell gate73(
		.a(net73),
		.b(net74),
		.out(net76)
	);
	or_cell gate74(
		.a(net75),
		.b(net76),
		.out(net9)
	);
	and_cell gate75(
		.a(net15),
		.b(net2),
		.out(net77)
	);
	and_cell gate76(
		.a(net77),
		.b(net17),
		.out(net78)
	);
	and_cell gate77(
		.a(net16),
		.b(net3),
		.out(net79)
	);
	and_cell gate78(
		.a(net3),
		.b(net18),
		.out(net80)
	);
	and_cell gate79(
		.a(net1),
		.b(net16),
		.out(net81)
	);
	and_cell gate80(
		.a(net1),
		.b(net4),
		.out(net82)
	);
	or_cell gate81(
		.a(net78),
		.b(net79),
		.out(net83)
	);
	or_cell gate82(
		.a(net80),
		.b(net81),
		.out(net84)
	);
	or_cell gate83(
		.a(net85),
		.b(net82),
		.out(net11)
	);
	or_cell gate84(
		.a(net83),
		.b(net84),
		.out(net85)
	);
	and_cell gate85(
		.a(net1),
		.b(net86),
		.out(net12)
	);
	nand_cell gate87(
		.a(net17),
		.b(net16),
		.out(net86)
	);
endmodule
module buffer_cell (
	in,
	out
);
	input wire in;
	output wire out;
	assign out = in;
endmodule
module and_cell (
	a,
	b,
	out
);
	input wire a;
	input wire b;
	output wire out;
	assign out = a & b;
endmodule
module or_cell (
	a,
	b,
	out
);
	input wire a;
	input wire b;
	output wire out;
	assign out = a | b;
endmodule
module xor_cell (
	a,
	b,
	out
);
	input wire a;
	input wire b;
	output wire out;
	assign out = a ^ b;
endmodule
module nand_cell (
	a,
	b,
	out
);
	input wire a;
	input wire b;
	output wire out;
	assign out = !(a & b);
endmodule
module not_cell (
	in,
	out
);
	input wire in;
	output wire out;
	assign out = !in;
endmodule
module mux_cell (
	a,
	b,
	sel,
	out
);
	input wire a;
	input wire b;
	input wire sel;
	output wire out;
	assign out = (sel ? b : a);
endmodule
module dff_cell (
	clk,
	d,
	q,
	notq
);
	input wire clk;
	input wire d;
	output reg q;
	output wire notq;
	assign notq = !q;
	always @(posedge clk) q <= d;
endmodule
module dffsr_cell (
	clk,
	d,
	s,
	r,
	q,
	notq
);
	input wire clk;
	input wire d;
	input wire s;
	input wire r;
	output reg q;
	output wire notq;
	assign notq = !q;
	always @(posedge clk or posedge s or posedge r)
		if (r)
			q <= 0;
		else if (s)
			q <= 1;
		else
			q <= d;
endmodule

