`timescale 1ns/100ps

module tb;
//declarations
//
//
	reg tb_clk, tb_reset;

	reg [0:1] nic00_addr_tb, nic01_addr_tb, nic02_addr_tb, nic03_addr_tb,
	nic10_addr_tb, nic11_addr_tb, nic12_addr_tb, nic13_addr_tb,
	nic20_addr_tb, nic21_addr_tb, nic22_addr_tb, nic23_addr_tb,
	nic30_addr_tb, nic31_addr_tb, nic32_addr_tb, nic33_addr_tb;

	reg [0:63] nic00_d_in_tb, nic01_d_in_tb, nic02_d_in_tb, nic03_d_in_tb,
	nic10_d_in_tb, nic11_d_in_tb, nic12_d_in_tb, nic13_d_in_tb,
	nic20_d_in_tb, nic21_d_in_tb, nic22_d_in_tb, nic23_d_in_tb,
	nic30_d_in_tb, nic31_d_in_tb, nic32_d_in_tb, nic33_d_in_tb;

	wire [0:63] nic00_d_out_tb, nic01_d_out_tb, nic02_d_out_tb, nic03_d_out_tb,
	nic10_d_out_tb, nic11_d_out_tb, nic12_d_out_tb, nic13_d_out_tb,
	nic20_d_out_tb, nic21_d_out_tb, nic22_d_out_tb, nic23_d_out_tb,
	nic30_d_out_tb, nic31_d_out_tb, nic32_d_out_tb, nic33_d_out_tb;

	reg nic00_nicEn_tb, nic01_nicEn_tb, nic02_nicEn_tb, nic03_nicEn_tb,
	nic10_nicEn_tb, nic11_nicEn_tb, nic12_nicEn_tb, nic13_nicEn_tb,
	nic20_nicEn_tb, nic21_nicEn_tb, nic22_nicEn_tb, nic23_nicEn_tb,
	nic30_nicEn_tb, nic31_nicEn_tb, nic32_nicEn_tb, nic33_nicEn_tb;

	reg nic00_nicEnWr_tb, nic01_nicEnWr_tb, nic02_nicEnWr_tb, nic03_nicEnWr_tb,
	nic10_nicEnWr_tb, nic11_nicEnWr_tb, nic12_nicEnWr_tb, nic13_nicEnWr_tb,
	nic20_nicEnWr_tb, nic21_nicEnWr_tb, nic22_nicEnWr_tb, nic23_nicEnWr_tb,
	nic30_nicEnWr_tb, nic31_nicEnWr_tb, nic32_nicEnWr_tb, nic33_nicEnWr_tb;

//DUT instantiation
//mesh_archi uut1 ();
	mesh_archi uut1 (.reset(tb_reset), .clk(tb_clk),
		.nic00_addr(nic00_addr_tb), .nic01_addr(nic01_addr_tb), .nic02_addr(nic02_addr_tb), .nic03_addr(nic03_addr_tb),
		.nic10_addr(nic10_addr_tb), .nic11_addr(nic11_addr_tb), .nic12_addr(nic12_addr_tb), .nic13_addr(nic13_addr_tb),
		.nic20_addr(nic20_addr_tb), .nic21_addr(nic21_addr_tb), .nic22_addr(nic22_addr_tb), .nic23_addr(nic23_addr_tb),
		.nic30_addr(nic30_addr_tb), .nic31_addr(nic31_addr_tb), .nic32_addr(nic32_addr_tb), .nic33_addr(nic33_addr_tb),

		.nic00_d_in(nic00_d_in_tb), .nic01_d_in(nic01_d_in_tb), .nic02_d_in(nic02_d_in_tb), .nic03_d_in(nic03_d_in_tb),
		.nic10_d_in(nic10_d_in_tb), .nic11_d_in(nic11_d_in_tb), .nic12_d_in(nic12_d_in_tb), .nic13_d_in(nic13_d_in_tb),
		.nic20_d_in(nic20_d_in_tb), .nic21_d_in(nic21_d_in_tb), .nic22_d_in(nic22_d_in_tb), .nic23_d_in(nic23_d_in_tb),
		.nic30_d_in(nic30_d_in_tb), .nic31_d_in(nic31_d_in_tb), .nic32_d_in(nic32_d_in_tb), .nic33_d_in(nic33_d_in_tb),

		.nic00_d_out(nic00_d_out_tb), .nic01_d_out(nic01_d_out_tb), .nic02_d_out(nic02_d_out_tb), .nic03_d_out(nic03_d_out_tb),
		.nic10_d_out(nic10_d_out_tb), .nic11_d_out(nic11_d_out_tb), .nic12_d_out(nic12_d_out_tb), .nic13_d_out(nic13_d_out_tb),
		.nic20_d_out(nic20_d_out_tb), .nic21_d_out(nic21_d_out_tb), .nic22_d_out(nic22_d_out_tb), .nic23_d_out(nic23_d_out_tb),
		.nic30_d_out(nic30_d_out_tb), .nic31_d_out(nic31_d_out_tb), .nic32_d_out(nic32_d_out_tb), .nic33_d_out(nic33_d_out_tb),

		.nic00_nicEn(nic00_nicEn_tb), .nic01_nicEn(nic01_nicEn_tb), .nic02_nicEn(nic02_nicEn_tb), .nic03_nicEn(nic03_nicEn_tb),
		.nic10_nicEn(nic10_nicEn_tb), .nic11_nicEn(nic11_nicEn_tb), .nic12_nicEn(nic12_nicEn_tb), .nic13_nicEn(nic13_nicEn_tb),
		.nic20_nicEn(nic20_nicEn_tb), .nic21_nicEn(nic21_nicEn_tb), .nic22_nicEn(nic22_nicEn_tb), .nic23_nicEn(nic23_nicEn_tb),
		.nic30_nicEn(nic30_nicEn_tb), .nic31_nicEn(nic31_nicEn_tb), .nic32_nicEn(nic32_nicEn_tb), .nic33_nicEn(nic33_nicEn_tb),

		.nic00_nicEnWr(nic00_nicEnWr_tb), .nic01_nicEnWr(nic01_nicEnWr_tb), .nic02_nicEnWr(nic02_nicEnWr_tb), .nic03_nicEnWr(nic03_nicEnWr_tb),
		.nic10_nicEnWr(nic10_nicEnWr_tb), .nic11_nicEnWr(nic11_nicEnWr_tb), .nic12_nicEnWr(nic12_nicEnWr_tb), .nic13_nicEnWr(nic13_nicEnWr_tb),
		.nic20_nicEnWr(nic20_nicEnWr_tb), .nic21_nicEnWr(nic21_nicEnWr_tb), .nic22_nicEnWr(nic22_nicEnWr_tb), .nic23_nicEnWr(nic23_nicEnWr_tb),
		.nic30_nicEnWr(nic30_nicEnWr_tb), .nic31_nicEnWr(nic31_nicEnWr_tb), .nic32_nicEnWr(nic32_nicEnWr_tb), .nic33_nicEnWr(nic33_nicEnWr_tb)
	);



//Stimulus
	initial begin
		tb_clk = 1'b0;
		tb_reset = 1'b1;
		//En=0
		nic00_nicEn_tb = 1'b0; nic01_nicEn_tb = 1'b0; nic02_nicEn_tb = 1'b0; nic03_nicEn_tb = 1'b0;
		nic10_nicEn_tb = 1'b0; nic11_nicEn_tb = 1'b0; nic12_nicEn_tb = 1'b0; nic13_nicEn_tb = 1'b0;
		nic20_nicEn_tb = 1'b0; nic21_nicEn_tb = 1'b0; nic22_nicEn_tb = 1'b0; nic23_nicEn_tb = 1'b0;
		nic30_nicEn_tb = 1'b0; nic31_nicEn_tb = 1'b0; nic32_nicEn_tb = 1'b0; nic33_nicEn_tb = 1'b0;
		//WrEn=0
		nic00_nicEnWr_tb = 1'b0; nic01_nicEnWr_tb = 1'b0; nic02_nicEnWr_tb = 1'b0; nic03_nicEnWr_tb = 1'b0;
		nic10_nicEnWr_tb = 1'b0; nic11_nicEnWr_tb = 1'b0; nic12_nicEnWr_tb = 1'b0; nic13_nicEnWr_tb = 1'b0;
		nic20_nicEnWr_tb = 1'b0; nic21_nicEnWr_tb = 1'b0; nic22_nicEnWr_tb = 1'b0; nic23_nicEnWr_tb = 1'b0;
		nic30_nicEnWr_tb = 1'b0; nic31_nicEnWr_tb = 1'b0; nic32_nicEnWr_tb = 1'b0; nic33_nicEnWr_tb = 1'b0;

//posedge1
		@(posedge tb_clk);
		tb_reset =1;

//posedge2
		@(posedge tb_clk);
//**send data from PE00 to PE11 <1-east 1-south>
//**send data from PE22 to PE11 <1west 1-north>
		tb_reset = 0;
		@(posedge tb_clk);
		@(negedge tb_clk);
		nic00_nicEn_tb = 1'b1;
		nic00_addr_tb = 2'b10;
		nic00_nicEnWr_tb = 1'b1;

		nic22_nicEn_tb = 1'b1;
		nic22_addr_tb = 2'b10;
		nic22_nicEnWr_tb = 1'b1;

		nic00_d_in_tb = 64'h5555555555558804;
		nic22_d_in_tb = 64'hAAAAAAAAAAAA8802;
		nic11_nicEn_tb = 1'b1;
		nic11_addr_tb = 2'b10;
		@(negedge tb_clk);

		nic00_nicEn_tb = 1'b0;
		nic00_nicEnWr_tb = 1'b0;

		nic22_nicEn_tb = 1'b0;
		nic22_nicEnWr_tb = 1'b0;

		@(posedge tb_clk);

//**send  data from PE00 to PE33 <3-east 3-south>
//**send data from PE30 to PE03 <3-east 3 -north>

//PE00 <new data!>
		nic00_nicEn_tb = 1'b1;
		nic00_nicEnWr_tb = 1'b1;
		nic00_d_in_tb = 64'hEEEEEEEEEEEECC04;
//PE30
		nic30_nicEn_tb = 1'b1;
		nic30_nicEnWr_tb = 1'b1;
		nic30_d_in_tb = 64'h888888888888CC00;

		@(negedge tb_clk);
		nic30_nicEn_tb = 1'b0;
		nic30_nicEnWr_tb = 1'b0;

		nic00_nicEn_tb = 1'b0;
		nic00_nicEnWr_tb = 1'b0;

//enabling output PEs to read the data from NIC
		nic03_nicEn_tb = 1'b1;
		nic33_nicEn_tb = 1'b1;
		repeat(10)
			@(posedge tb_clk);
		$finish;
	end

	always begin
		#4 tb_clk = ~tb_clk;
	end

endmodule


/*

 15 [63:60]  [59:56] [55:52] [51:48] [47:44] [43:40  [39:36] [35:32] [31:28] [27:24] [23:10] 19:16]  15:12]  11:8]   7:4]    [3:0
 INPUT PE00  2   0   1   1   A   A   A   A   A   A   A   A   A   A   A   A
 OUTPUT PE11 2   0   0   0   A   A   A   A   A   A   A   A   A   A   A   A

 INPUT PE22  4   0   1   1   5   5   5   5   5   5   5   5   5   5   5   5
 OUTPUT PE11 4   0   0   0   5   5   5   5   5   5   5   5   5   5   5   5


 INPUT PE00  2   0   3   3   7   7   7   7   7   7   7   7   7   7   7   7
 OUTPUT PE33 2   0   0   0   7   7   7   7   7   7   7   7   7   7   7   7

 INPUT PE30  0   0   3   3   1   1   1   1   1   1   1   1   1   1   1   1
 OUTPUT PE03 0   0   0   0   1   1   1   1   1   1   1   1   1   1   1   1
 */
