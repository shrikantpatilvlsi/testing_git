// top file
// Authors: Shrikant Patil
//			Onkar Choudhari
//			Padma Balaji Dhanushkodi


//-----------------------------------------------------------------------//



module cardinal_cmp (clk, reset,
	node0_inst_in, node0_d_in, node0_pc_out,
	node0_d_out, node0_memWrEn, node0_memEn,
	node0_addr_nic, node0_din_nic, node0_dout_nic,
	node0_nicEn, node0_nicWrEn,node0_addr_out,

	node1_inst_in, node1_d_in, node1_pc_out,
	node1_d_out, node1_memWrEn, node1_memEn,
	node1_addr_nic, node1_din_nic, node1_dout_nic,
	node1_nicEn, node1_nicWrEn,node1_addr_out,

	node2_inst_in, node2_d_in, node2_pc_out,
	node2_d_out, node2_memWrEn, node2_memEn,
	node2_addr_nic, node2_din_nic, node2_dout_nic,
	node2_nicEn, node2_nicWrEn,node2_addr_out,

	node3_inst_in, node3_d_in, node3_pc_out,
	node3_d_out, node3_memWrEn, node3_memEn,
	node3_addr_nic, node3_din_nic, node3_dout_nic,
	node3_nicEn, node3_nicWrEn,node3_addr_out,

	node4_inst_in, node4_d_in, node4_pc_out,
	node4_d_out, node4_memWrEn, node4_memEn,
	node4_addr_nic, node4_din_nic, node4_dout_nic,
	node4_nicEn, node4_nicWrEn,node4_addr_out,

	node5_inst_in, node5_d_in, node5_pc_out,
	node5_d_out, node5_memWrEn, node5_memEn,
	node5_addr_nic, node5_din_nic, node5_dout_nic,
	node5_nicEn, node5_nicWrEn,node5_addr_out,

	node6_inst_in, node6_d_in, node6_pc_out,
	node6_d_out, node6_memWrEn, node6_memEn,
	node6_addr_nic, node6_din_nic, node6_dout_nic,
	node6_nicEn, node6_nicWrEn,node6_addr_out,

	node7_inst_in, node7_d_in, node7_pc_out,
	node7_d_out, node7_memWrEn, node7_memEn,
	node7_addr_nic, node7_din_nic, node7_dout_nic,
	node7_nicEn, node7_nicWrEn,node7_addr_out,

	node8_inst_in, node8_d_in, node8_pc_out,
	node8_d_out, node8_memWrEn, node8_memEn,
	node8_addr_nic, node8_din_nic, node8_dout_nic,
	node8_nicEn, node8_nicWrEn,node8_addr_out,

	node9_inst_in, node9_d_in, node9_pc_out,
	node9_d_out, node9_memWrEn, node9_memEn,
	node9_addr_nic, node9_din_nic, node9_dout_nic,
	node9_nicEn, node9_nicWrEn,node9_addr_out,

	node10_inst_in, node10_d_in, node10_pc_out,
	node10_d_out, node10_memWrEn, node10_memEn,
	node10_addr_nic, node10_din_nic, node10_dout_nic,
	node10_nicEn, node10_nicWrEn,node10_addr_out,

	node11_inst_in, node11_d_in, node11_pc_out,
	node11_d_out, node11_memWrEn, node11_memEn,
	node11_addr_nic, node11_din_nic, node11_dout_nic,
	node11_nicEn, node11_nicWrEn,node11_addr_out,

	node12_inst_in, node12_d_in, node12_pc_out,
	node12_d_out, node12_memWrEn, node12_memEn,
	node12_addr_nic, node12_din_nic, node12_dout_nic,
	node12_nicEn, node12_nicWrEn,node12_addr_out,

	node13_inst_in, node13_d_in, node13_pc_out,
	node13_d_out, node13_memWrEn, node13_memEn,
	node13_addr_nic, node13_din_nic, node13_dout_nic,
	node13_nicEn, node13_nicWrEn,node13_addr_out,

	node14_inst_in, node14_d_in, node14_pc_out,
	node14_d_out, node14_memWrEn, node14_memEn,
	node14_addr_nic, node14_din_nic, node14_dout_nic,
	node14_nicEn, node14_nicWrEn,node14_addr_out,

	node15_inst_in, node15_d_in, node15_pc_out,
	node15_d_out, node15_memWrEn, node15_memEn,
	node15_addr_nic, node15_din_nic, node15_dout_nic,
	node15_nicEn, node15_nicWrEn,node15_addr_out,

	);
	input clk; input reset;

	input [0:31]  node0_inst_in;
	input [0:63]  node0_d_in;
	output [0:31] node0_pc_out;
	output [0:63] node0_d_out;
	output		  node0_memWrEn;
	output		  node0_memEn;
	output [0:1]  node0_addr_nic;
	output [0:63] node0_din_nic;
	output [0:63] node0_dout_nic;
	output 		  node0_nicEn;
	output 		  node0_nicWrEn;
	output [0:31] node0_addr_out;

	input [0:31]  node1_inst_in;
	input [0:63]  node1_d_in;
	output [0:31] node1_pc_out;
	output [0:63] node1_d_out;
	output		  node1_memWrEn;
	output		  node1_memEn;
	output [0:1]  node1_addr_nic;
	output [0:63] node1_din_nic;
	output [0:63] node1_dout_nic;
	output 		  node1_nicEn;
	output 		  node1_nicWrEn;
	output [0:31] node1_addr_out;

	input [0:31]  node2_inst_in;
	input [0:63]  node2_d_in;
	output [0:31] node2_pc_out;
	output [0:63] node2_d_out;
	output		  node2_memWrEn;
	output		  node2_memEn;
	output [0:1]  node2_addr_nic;
	output [0:63] node2_din_nic;
	output [0:63] node2_dout_nic;
	output 		  node2_nicEn;
	output 		  node2_nicWrEn;
	output [0:31] node2_addr_out;

	input [0:31]  node3_inst_in;
	input [0:63]  node3_d_in;
	output [0:31] node3_pc_out;
	output [0:63] node3_d_out;
	output		  node3_memWrEn;
	output		  node3_memEn;
	output [0:1]  node3_addr_nic;
	output [0:63] node3_din_nic;
	output [0:63] node3_dout_nic;
	output 		  node3_nicEn;
	output 		  node3_nicWrEn;
	output [0:31] node3_addr_out;

	input [0:31]  node4_inst_in;
	input [0:63]  node4_d_in;
	output [0:31] node4_pc_out;
	output [0:63] node4_d_out;
	output		  node4_memWrEn;
	output		  node4_memEn;
	output [0:1]  node4_addr_nic;
	output [0:63] node4_din_nic;
	output [0:63] node4_dout_nic;
	output 		  node4_nicEn;
	output 		  node4_nicWrEn;
	output [0:31] node4_addr_out;

	input [0:31]  node5_inst_in;
	input [0:63]  node5_d_in;
	output [0:31] node5_pc_out;
	output [0:63] node5_d_out;
	output		  node5_memWrEn;
	output		  node5_memEn;
	output [0:1]  node5_addr_nic;
	output [0:63] node5_din_nic;
	output [0:63] node5_dout_nic;
	output 		  node5_nicEn;
	output 		  node5_nicWrEn;
	output [0:31] node5_addr_out;

	input [0:31]  node6_inst_in;
	input [0:63]  node6_d_in;
	output [0:31] node6_pc_out;
	output [0:63] node6_d_out;
	output		  node6_memWrEn;
	output		  node6_memEn;
	output [0:1]  node6_addr_nic;
	output [0:63] node6_din_nic;
	output [0:63] node6_dout_nic;
	output 		  node6_nicEn;
	output 		  node6_nicWrEn;
	output [0:31] node6_addr_out;

	input [0:31]  node7_inst_in;
	input [0:63]  node7_d_in;
	output [0:31] node7_pc_out;
	output [0:63] node7_d_out;
	output		  node7_memWrEn;
	output		  node7_memEn;
	output [0:1]  node7_addr_nic;
	output [0:63] node7_din_nic;
	output [0:63] node7_dout_nic;
	output 		  node7_nicEn;
	output 		  node7_nicWrEn;
	output [0:31] node7_addr_out;

	input [0:31]  node8_inst_in;
	input [0:63]  node8_d_in;
	output [0:31] node8_pc_out;
	output [0:63] node8_d_out;
	output		  node8_memWrEn;
	output		  node8_memEn;
	output [0:1]  node8_addr_nic;
	output [0:63] node8_din_nic;
	output [0:63] node8_dout_nic;
	output 		  node8_nicEn;
	output 		  node8_nicWrEn;
	output [0:31] node8_addr_out;

	input [0:31]  node9_inst_in;
	input [0:63]  node9_d_in;
	output [0:31] node9_pc_out;
	output [0:63] node9_d_out;
	output		  node9_memWrEn;
	output		  node9_memEn;
	output [0:1]  node9_addr_nic;
	output [0:63] node9_din_nic;
	output [0:63] node9_dout_nic;
	output 		  node9_nicEn;
	output 		  node9_nicWrEn;
	output [0:31] node9_addr_out;

	input [0:31]  node10_inst_in;
	input [0:63]  node10_d_in;
	output [0:31] node10_pc_out;
	output [0:63] node10_d_out;
	output		  node10_memWrEn;
	output		  node10_memEn;
	output [0:1]  node10_addr_nic;
	output [0:63] node10_din_nic;
	output [0:63] node10_dout_nic;
	output 		  node10_nicEn;
	output 		  node10_nicWrEn;
	output [0:31] node10_addr_out;

	input [0:31]  node11_inst_in;
	input [0:63]  node11_d_in;
	output [0:31] node11_pc_out;
	output [0:63] node11_d_out;
	output		  node11_memWrEn;
	output		  node11_memEn;
	output [0:1]  node11_addr_nic;
	output [0:63] node11_din_nic;
	output [0:63] node11_dout_nic;
	output 		  node11_nicEn;
	output 		  node11_nicWrEn;
	output [0:31] node11_addr_out;

	input [0:31]  node12_inst_in;
	input [0:63]  node12_d_in;
	output [0:31] node12_pc_out;
	output [0:63] node12_d_out;
	output		  node12_memWrEn;
	output		  node12_memEn;
	output [0:1]  node12_addr_nic;
	output [0:63] node12_din_nic;
	output [0:63] node12_dout_nic;
	output 		  node12_nicEn;
	output 		  node12_nicWrEn;
	output [0:31] node12_addr_out;

	input [0:31]  node13_inst_in;
	input [0:63]  node13_d_in;
	output [0:31] node13_pc_out;
	output [0:63] node13_d_out;
	output		  node13_memWrEn;
	output		  node13_memEn;
	output [0:1]  node13_addr_nic;
	output [0:63] node13_din_nic;
	output [0:63] node13_dout_nic;
	output 		  node13_nicEn;
	output 		  node13_nicWrEn;
	output [0:31] node13_addr_out;

	input [0:31]  node14_inst_in;
	input [0:63]  node14_d_in;
	output [0:31] node14_pc_out;
	output [0:63] node14_d_out;
	output		  node14_memWrEn;
	output		  node14_memEn;
	output [0:1]  node14_addr_nic;
	output [0:63] node14_din_nic;
	output [0:63] node14_dout_nic;
	output 		  node14_nicEn;
	output 		  node14_nicWrEn;
	output [0:31] node14_addr_out;

	input [0:31]  node15_inst_in;
	input [0:63]  node15_d_in;
	output [0:31] node15_pc_out;
	output [0:63] node15_d_out;
	output		  node15_memWrEn;
	output		  node15_memEn;
	output [0:1]  node15_addr_nic;
	output [0:63] node15_din_nic;
	output [0:63] node15_dout_nic;
	output 		  node15_nicEn;
	output 		  node15_nicWrEn;
	output [0:31] node15_addr_out;

//------------------------------------------

	wire [0:1]		nic00_cpu0_addr;
	wire [0:63]		nic00_cpu0_din;
	wire [0:63]		nic00_cpu0_dout;
	wire 			nic00_cpu0_En;
	wire 			nic00_cpu0_WrEn;


	wire [0:1]		nic01_cpu1_addr;
	wire [0:63]		nic01_cpu1_din;
	wire [0:63]		nic01_cpu1_dout;
	wire 			nic01_cpu1_En;
	wire 			nic01_cpu1_WrEn;

	wire [0:1]		nic02_cpu2_addr;
	wire [0:63]		nic02_cpu2_din;
	wire [0:63]		nic02_cpu2_dout;
	wire 			nic02_cpu2_En;
	wire 			nic02_cpu2_WrEn;

	wire [0:1]		nic03_cpu3_addr;
	wire [0:63]		nic03_cpu3_din;
	wire [0:63]		nic03_cpu3_dout;
	wire 			nic03_cpu3_En;
	wire 			nic03_cpu3_WrEn;

	wire [0:1]		nic10_cpu4_addr;
	wire [0:63]		nic10_cpu4_din;
	wire [0:63]		nic10_cpu4_dout;
	wire 			nic10_cpu4_En;
	wire 			nic10_cpu4_WrEn;

	wire [0:1]		nic11_cpu5_addr;
	wire [0:63]		nic11_cpu5_din;
	wire [0:63]		nic11_cpu5_dout;
	wire 			nic11_cpu5_En;
	wire 			nic11_cpu5_WrEn;

	wire [0:1]		nic12_cpu6_addr;
	wire [0:63]		nic12_cpu6_din;
	wire [0:63]		nic12_cpu6_dout;
	wire 			nic12_cpu6_En;
	wire 			nic12_cpu6_WrEn;

	wire [0:1]		nic13_cpu7_addr;
	wire [0:63]		nic13_cpu7_din;
	wire [0:63]		nic13_cpu7_dout;
	wire 			nic13_cpu7_En;
	wire 			nic13_cpu7_WrEn;

	wire [0:1]		nic20_cpu8_addr;
	wire [0:63]		nic20_cpu8_din;
	wire [0:63]		nic20_cpu8_dout;
	wire 			nic20_cpu8_En;
	wire 			nic20_cpu8_WrEn;

	wire [0:1]		nic21_cpu9_addr;
	wire [0:63]		nic21_cpu9_din;
	wire [0:63]		nic21_cpu9_dout;
	wire 			nic21_cpu9_En;
	wire 			nic21_cpu9_WrEn;

	wire [0:1]		nic22_cpu10_addr;
	wire [0:63]		nic22_cpu10_din;
	wire [0:63]		nic22_cpu10_dout;
	wire 			nic22_cpu10_En;
	wire 			nic22_cpu10_WrEn;

	wire [0:1]		nic23_cpu11_addr;
	wire [0:63]		nic23_cpu11_din;
	wire [0:63]		nic23_cpu11_dout;
	wire 			nic23_cpu11_En;
	wire 			nic23_cpu11_WrEn;

	wire [0:1]		nic30_cpu12_addr;
	wire [0:63]		nic30_cpu12_din;
	wire [0:63]		nic30_cpu12_dout;
	wire 			nic30_cpu12_En;
	wire 			nic30_cpu12_WrEn;

	wire [0:1]		nic31_cpu13_addr;
	wire [0:63]		nic31_cpu13_din;
	wire [0:63]		nic31_cpu13_dout;
	wire 			nic31_cpu13_En;
	wire 			nic31_cpu13_WrEn;

	wire [0:1]		nic32_cpu14_addr;
	wire [0:63]		nic32_cpu14_din;
	wire [0:63]		nic32_cpu14_dout;
	wire 			nic32_cpu14_En;
	wire 			nic32_cpu14_WrEn;

	wire [0:1]		nic33_cpu15_addr;
	wire [0:63]		nic33_cpu15_din;
	wire [0:63]		nic33_cpu15_dout;
	wire 			nic33_cpu15_En;
	wire 			nic33_cpu15_WrEn;

//------------------------------------------





//Instantiation of mesh architecture + NIC

mesh_archi m1 (.clk(clk),.reset(reset),

	.nic00_addr(nic00_cpu0_addr),
	.nic00_d_out(nic00_cpu0_dout),
	.nic00_d_in(nic00_cpu0_din),
	.nic00_nicEn(nic00_cpu0_En),
	.nic00_nicEnWr(nic00_cpu0_WrEn),

	.nic01_addr(nic01_cpu1_addr),
	.nic01_d_out(nic01_cpu1_dout),
	.nic01_d_in(nic01_cpu1_din),
	.nic01_nicEn(nic01_cpu1_En),
	.nic01_nicEnWr(nic01_cpu1_WrEn),

	.nic02_addr(nic02_cpu2_addr),
	.nic02_d_out(nic02_cpu2_dout),
	.nic02_d_in(nic02_cpu2_din),
	.nic02_nicEn(nic02_cpu2_En),
	.nic02_nicEnWr(nic02_cpu2_WrEn),

	.nic03_addr(nic03_cpu3_addr),
	.nic03_d_out(nic03_cpu3_dout),
	.nic03_d_in(nic03_cpu3_din),
	.nic03_nicEn(nic03_cpu3_En),
	.nic03_nicEnWr(nic03_cpu3_WrEn),

	.nic10_addr(nic10_cpu4_addr),
	.nic10_d_out(nic10_cpu4_dout),
	.nic10_d_in(nic10_cpu4_din),
	.nic10_nicEn(nic10_cpu4_En),
	.nic10_nicEnWr(nic10_cpu4_WrEn),

	.nic11_addr(nic11_cpu5_addr),
	.nic11_d_out(nic11_cpu5_dout),
	.nic11_d_in(nic11_cpu5_din),
	.nic11_nicEn(nic11_cpu5_En),
	.nic11_nicEnWr(nic11_cpu5_WrEn),

	.nic12_addr(nic12_cpu6_addr),
	.nic12_d_out(nic12_cpu6_dout),
	.nic12_d_in(nic12_cpu6_din),
	.nic12_nicEn(nic12_cpu6_En),
	.nic12_nicEnWr(nic12_cpu6_WrEn),

	.nic13_addr(nic13_cpu7_addr),
	.nic13_d_out(nic13_cpu7_dout),
	.nic13_d_in(nic13_cpu7_din),
	.nic13_nicEn(nic13_cpu7_En),
	.nic13_nicEnWr(nic13_cpu7_WrEn),

	.nic20_addr(nic20_cpu8_addr),
	.nic20_d_out(nic20_cpu8_dout),
	.nic20_d_in(nic20_cpu8_din),
	.nic20_nicEn(nic20_cpu8_En),
	.nic20_nicEnWr(nic20_cpu8_WrEn),

	.nic21_addr(nic21_cpu9_addr),
	.nic21_d_out(nic21_cpu9_dout),
	.nic21_d_in(nic21_cpu9_din),
	.nic21_nicEn(nic21_cpu9_En),
	.nic21_nicEnWr(nic21_cpu9_WrEn),

	.nic22_addr(nic22_cpu10_addr),
	.nic22_d_out(nic22_cpu10_dout),
	.nic22_d_in(nic22_cpu10_din),
	.nic22_nicEn(nic22_cpu10_En),
	.nic22_nicEnWr(nic22_cpu10_WrEn),

	.nic23_addr(nic23_cpu11_addr),
	.nic23_d_out(nic23_cpu11_dout),
	.nic23_d_in(nic23_cpu11_din),
	.nic23_nicEn(nic23_cpu11_En),
	.nic23_nicEnWr(nic23_cpu11_WrEn),

	.nic30_addr(nic30_cpu12_addr),
	.nic30_d_out(nic30_cpu12_dout),
	.nic30_d_in(nic30_cpu12_din),
	.nic30_nicEn(nic30_cpu12_En),
	.nic30_nicEnWr(nic30_cpu12_WrEn),

	.nic31_addr(nic31_cpu13_addr),
	.nic31_d_out(nic31_cpu13_dout),
	.nic31_d_in(nic31_cpu13_din),
	.nic31_nicEn(nic31_cpu13_En),
	.nic31_nicEnWr(nic31_cpu13_WrEn),

	.nic32_addr(nic32_cpu14_addr),
	.nic32_d_out(nic32_cpu14_dout),
	.nic32_d_in(nic32_cpu14_din),
	.nic32_nicEn(nic32_cpu14_En),
	.nic32_nicEnWr(nic32_cpu14_WrEn),

	.nic33_addr(nic33_cpu15_addr),
	.nic33_d_out(nic33_cpu15_dout),
	.nic33_d_in(nic33_cpu15_din),
	.nic33_nicEn(nic33_cpu15_En),
	.nic33_nicEnWr(nic33_cpu15_WrEn)
	);

	cardinal_cpu cpu0 (
		.addr_to_dmem(node0_addr_out),
		.data_from_dmem(node0_d_in),
		.data_to_dmem(node0_d_out),
		.dmem_En(node0_memEn),
		.dmem_WrEn(node0_memWrEn),
		.inst_from_imem(node0_inst_in),
		.prog_counter_out(node0_pc_out),
		.clk(clk),.reset(reset),

		.nic_addr(nic00_cpu0_addr),
		.nic_d_in(nic00_cpu0_din),
		.nic_d_out(nic00_cpu0_dout),
		.nicEn(nic00_cpu0_En),
		.nicWrEn(nic00_cpu0_WrEn)
		);

	cardinal_cpu cpu1 (
		.addr_to_dmem(node1_addr_out),
		.data_from_dmem(node1_d_in),
		.data_to_dmem(node1_d_out),
		.dmem_En(node1_memEn),
		.dmem_WrEn(node1_memWrEn),
		.inst_from_imem(node1_inst_in),
		.prog_counter_out(node1_pc_out),
		.clk(clk),.reset(reset),

		.nic_addr(nic01_cpu1_addr),
		.nic_d_in(nic01_cpu1_din),
		.nic_d_out(nic01_cpu1_dout),
		.nicEn(nic01_cpu1_En),
		.nicWrEn(nic01_cpu1_WrEn)
		);

	cardinal_cpu cpu2 (
		.addr_to_dmem(node2_addr_out),
		.data_from_dmem(node2_d_in),
		.data_to_dmem(node2_d_out),
		.dmem_En(node2_memEn),
		.dmem_WrEn(node2_memWrEn),
		.inst_from_imem(node2_inst_in),
		.prog_counter_out(node2_pc_out),
		.clk(clk),.reset(reset),

		.nic_addr(nic02_cpu2_addr),
		.nic_d_in(nic02_cpu2_din),
		.nic_d_out(nic02_cpu2_dout),
		.nicEn(nic02_cpu2_En),
		.nicWrEn(nic02_cpu2_WrEn)
		);

	cardinal_cpu cpu3 (
		.addr_to_dmem(node3_addr_out),
		.data_from_dmem(node3_d_in),
		.data_to_dmem(node3_d_out),
		.dmem_En(node3_memEn),
		.dmem_WrEn(node3_memWrEn),
		.inst_from_imem(node3_inst_in),
		.prog_counter_out(node3_pc_out),
		.clk(clk),.reset(reset),

		.nic_addr(nic03_cpu3_addr),
		.nic_d_in(nic03_cpu3_din),
		.nic_d_out(nic03_cpu3_dout),
		.nicEn(nic03_cpu3_En),
		.nicWrEn(nic03_cpu3_WrEn)
		);

	cardinal_cpu cpu4 (
		.addr_to_dmem(node4_addr_out),
		.data_from_dmem(node4_d_in),
		.data_to_dmem(node4_d_out),
		.dmem_En(node4_memEn),
		.dmem_WrEn(node4_memWrEn),
		.inst_from_imem(node4_inst_in),
		.prog_counter_out(node4_pc_out),
		.clk(clk),.reset(reset),

		.nic_addr(nic10_cpu4_addr),
		.nic_d_in(nic10_cpu4_din),
		.nic_d_out(nic10_cpu4_dout),
		.nicEn(nic10_cpu4_En),
		.nicWrEn(nic10_cpu4_WrEn)
		);

	cardinal_cpu cpu5 (
		.addr_to_dmem(node5_addr_out),
		.data_from_dmem(node5_d_in),
		.data_to_dmem(node5_d_out),
		.dmem_En(node5_memEn),
		.dmem_WrEn(node5_memWrEn),
		.inst_from_imem(node5_inst_in),
		.prog_counter_out(node5_pc_out),
		.clk(clk),.reset(reset),

		.nic_addr(nic11_cpu5_addr),
		.nic_d_in(nic11_cpu5_din),
		.nic_d_out(nic11_cpu5_dout),
		.nicEn(nic11_cpu5_En),
		.nicWrEn(nic11_cpu5_WrEn)
		);

	cardinal_cpu cpu6 (
		.addr_to_dmem(node6_addr_out),
		.data_from_dmem(node6_d_in),
		.data_to_dmem(node6_d_out),
		.dmem_En(node6_memEn),
		.dmem_WrEn(node6_memWrEn),
		.inst_from_imem(node6_inst_in),
		.prog_counter_out(node6_pc_out),
		.clk(clk),.reset(reset),

		.nic_addr(nic12_cpu6_addr),
		.nic_d_in(nic12_cpu6_din),
		.nic_d_out(nic12_cpu6_dout),
		.nicEn(nic12_cpu6_En),
		.nicWrEn(nic12_cpu6_WrEn)
		);

	cardinal_cpu cpu7 (
		.addr_to_dmem(node7_addr_out),
		.data_from_dmem(node7_d_in),
		.data_to_dmem(node7_d_out),
		.dmem_En(node7_memEn),
		.dmem_WrEn(node7_memWrEn),
		.inst_from_imem(node7_inst_in),
		.prog_counter_out(node7_pc_out),
		.clk(clk),.reset(reset),

		.nic_addr(nic13_cpu7_addr),
		.nic_d_in(nic13_cpu7_din),
		.nic_d_out(nic13_cpu7_dout),
		.nicEn(nic13_cpu7_En),
		.nicWrEn(nic13_cpu7_WrEn)
		);

	cardinal_cpu cpu8 (
		.addr_to_dmem(node8_addr_out),
		.data_from_dmem(node8_d_in),
		.data_to_dmem(node8_d_out),
		.dmem_En(node8_memEn),
		.dmem_WrEn(node8_memWrEn),
		.inst_from_imem(node8_inst_in),
		.prog_counter_out(node8_pc_out),
		.clk(clk),.reset(reset),

		.nic_addr(nic20_cpu8_addr),
		.nic_d_in(nic20_cpu8_din),
		.nic_d_out(nic20_cpu8_dout),
		.nicEn(nic20_cpu8_En),
		.nicWrEn(nic20_cpu8_WrEn)
		);

	cardinal_cpu cpu9 (
		.addr_to_dmem(node9_addr_out),
		.data_from_dmem(node9_d_in),
		.data_to_dmem(node9_d_out),
		.dmem_En(node9_memEn),
		.dmem_WrEn(node9_memWrEn),
		.inst_from_imem(node9_inst_in),
		.prog_counter_out(node9_pc_out),
		.clk(clk),.reset(reset),

		.nic_addr(nic21_cpu9_addr),
		.nic_d_in(nic21_cpu9_din),
		.nic_d_out(nic21_cpu9_dout),
		.nicEn(nic21_cpu9_En),
		.nicWrEn(nic21_cpu9_WrEn)
		);

	cardinal_cpu cpu10 (
		.addr_to_dmem(node10_addr_out),
		.data_from_dmem(node10_d_in),
		.data_to_dmem(node10_d_out),
		.dmem_En(node10_memEn),
		.dmem_WrEn(node10_memWrEn),
		.inst_from_imem(node10_inst_in),
		.prog_counter_out(node10_pc_out),
		.clk(clk),.reset(reset),

		.nic_addr(nic22_cpu10_addr),
		.nic_d_in(nic22_cpu10_din),
		.nic_d_out(nic22_cpu10_dout),
		.nicEn(nic22_cpu10_En),
		.nicWrEn(nic22_cpu10_WrEn)
		);

	cardinal_cpu cpu11 (
		.addr_to_dmem(node11_addr_out),
		.data_from_dmem(node11_d_in),
		.data_to_dmem(node11_d_out),
		.dmem_En(node11_memEn),
		.dmem_WrEn(node11_memWrEn),
		.inst_from_imem(node11_inst_in),
		.prog_counter_out(node11_pc_out),
		.clk(clk),.reset(reset),

		.nic_addr(nic23_cpu11_addr),
		.nic_d_in(nic23_cpu11_din),
		.nic_d_out(nic23_cpu11_dout),
		.nicEn(nic23_cpu11_En),
		.nicWrEn(nic23_cpu11_WrEn)
		);

	cardinal_cpu cpu12 (
		.addr_to_dmem(node12_addr_out),
		.data_from_dmem(node12_d_in),
		.data_to_dmem(node12_d_out),
		.dmem_En(node12_memEn),
		.dmem_WrEn(node12_memWrEn),
		.inst_from_imem(node12_inst_in),
		.prog_counter_out(node12_pc_out),
		.clk(clk),.reset(reset),

		.nic_addr(nic30_cpu12_addr),
		.nic_d_in(nic30_cpu12_din),
		.nic_d_out(nic30_cpu12_dout),
		.nicEn(nic30_cpu12_En),
		.nicWrEn(nic30_cpu12_WrEn)
		);

	cardinal_cpu cpu13 (
		.addr_to_dmem(node13_addr_out),
		.data_from_dmem(node13_d_in),
		.data_to_dmem(node13_d_out),
		.dmem_En(node13_memEn),
		.dmem_WrEn(node13_memWrEn),
		.inst_from_imem(node13_inst_in),
		.prog_counter_out(node13_pc_out),
		.clk(clk),.reset(reset),

		.nic_addr(nic31_cpu13_addr),
		.nic_d_in(nic31_cpu13_din),
		.nic_d_out(nic31_cpu13_dout),
		.nicEn(nic31_cpu13_En),
		.nicWrEn(nic31_cpu13_WrEn)
		);

	cardinal_cpu cpu14 (
		.addr_to_dmem(node14_addr_out),
		.data_from_dmem(node14_d_in),
		.data_to_dmem(node14_d_out),
		.dmem_En(node14_memEn),
		.dmem_WrEn(node14_memWrEn),
		.inst_from_imem(node14_inst_in),
		.prog_counter_out(node14_pc_out),
		.clk(clk),.reset(reset),

		.nic_addr(nic32_cpu14_addr),
		.nic_d_in(nic32_cpu14_din),
		.nic_d_out(nic32_cpu14_dout),
		.nicEn(nic32_cpu14_En),
		.nicWrEn(nic32_cpu14_WrEn)
		);

	cardinal_cpu cpu15 (
		.addr_to_dmem(node15_addr_out),
		.data_from_dmem(node15_d_in),
		.data_to_dmem(node15_d_out),
		.dmem_En(node15_memEn),
		.dmem_WrEn(node15_memWrEn),
		.inst_from_imem(node15_inst_in),
		.prog_counter_out(node15_pc_out),
		.clk(clk),.reset(reset),

		.nic_addr(nic33_cpu15_addr),
		.nic_d_in(nic33_cpu15_din),
		.nic_d_out(nic33_cpu15_dout),
		.nicEn(nic33_cpu15_En),
		.nicWrEn(nic33_cpu15_WrEn)
		);

	// --------------------------------------
	// Assign nic signals to be pulled out
	//---------------------------------------

	assign node0_addr_nic = nic00_cpu0_addr;
	assign node0_din_nic  = nic00_cpu0_din;
	assign node0_dout_nic = nic00_cpu0_dout;
	assign node0_nicEn    = nic00_cpu0_En;
	assign node0_nicWrEn  = nic00_cpu0_WrEn;

	assign node1_addr_nic = nic01_cpu1_addr;
	assign node1_din_nic  = nic01_cpu1_din;
	assign node1_dout_nic = nic01_cpu1_dout;
	assign node1_nicEn    = nic01_cpu1_En;
	assign node1_nicWrEn  = nic01_cpu1_WrEn;

	assign node2_addr_nic = nic02_cpu2_addr;
	assign node2_din_nic  = nic02_cpu2_din;
	assign node2_dout_nic = nic02_cpu2_dout;
	assign node2_nicEn    = nic02_cpu2_En;
	assign node2_nicWrEn  = nic02_cpu2_WrEn;

	assign node3_addr_nic = nic03_cpu3_addr;
	assign node3_din_nic  = nic03_cpu3_din;
	assign node3_dout_nic = nic03_cpu3_dout;
	assign node3_nicEn    = nic03_cpu3_En;
	assign node3_nicWrEn  = nic03_cpu3_WrEn;

	assign node4_addr_nic = nic10_cpu4_addr;
	assign node4_din_nic  = nic10_cpu4_din;
	assign node4_dout_nic = nic10_cpu4_dout;
	assign node4_nicEn    = nic10_cpu4_En;
	assign node4_nicWrEn  = nic10_cpu4_WrEn;

	assign node5_addr_nic = nic11_cpu5_addr;
	assign node5_din_nic  = nic11_cpu5_din;
	assign node5_dout_nic = nic11_cpu5_dout;
	assign node5_nicEn    = nic11_cpu5_En;
	assign node5_nicWrEn  = nic11_cpu5_WrEn;

	assign node6_addr_nic = nic12_cpu6_addr;
	assign node6_din_nic  = nic12_cpu6_din;
	assign node6_dout_nic = nic12_cpu6_dout;
	assign node6_nicEn    = nic12_cpu6_En;
	assign node6_nicWrEn  = nic12_cpu6_WrEn;

	assign node7_addr_nic = nic13_cpu7_addr;
	assign node7_din_nic  = nic13_cpu7_din;
	assign node7_dout_nic = nic13_cpu7_dout;
	assign node7_nicEn    = nic13_cpu7_En;
	assign node7_nicWrEn  = nic13_cpu7_WrEn;

	assign node8_addr_nic = nic20_cpu8_addr;
	assign node8_din_nic  = nic20_cpu8_din;
	assign node8_dout_nic = nic20_cpu8_dout;
	assign node8_nicEn    = nic20_cpu8_En;
	assign node8_nicWrEn  = nic20_cpu8_WrEn;

	assign node9_addr_nic = nic21_cpu9_addr;
	assign node9_din_nic  = nic21_cpu9_din;
	assign node9_dout_nic = nic21_cpu9_dout;
	assign node9_nicEn    = nic21_cpu9_En;
	assign node9_nicWrEn  = nic21_cpu9_WrEn;

	assign node10_addr_nic = nic22_cpu10_addr;
	assign node10_din_nic  = nic22_cpu10_din;
	assign node10_dout_nic = nic22_cpu10_dout;
	assign node10_nicEn    = nic22_cpu10_En;
	assign node10_nicWrEn  = nic22_cpu10_WrEn;

	assign node11_addr_nic = nic23_cpu11_addr;
	assign node11_din_nic  = nic23_cpu11_din;
	assign node11_dout_nic = nic23_cpu11_dout;
	assign node11_nicEn    = nic23_cpu11_En;
	assign node11_nicWrEn  = nic23_cpu11_WrEn;

	assign node12_addr_nic = nic30_cpu12_addr;
	assign node12_din_nic  = nic30_cpu12_din;
	assign node12_dout_nic = nic30_cpu12_dout;
	assign node12_nicEn    = nic30_cpu12_En;
	assign node12_nicWrEn  = nic30_cpu12_WrEn;

	assign node13_addr_nic = nic31_cpu13_addr;
	assign node13_din_nic  = nic31_cpu13_din;
	assign node13_dout_nic = nic31_cpu13_dout;
	assign node13_nicEn    = nic31_cpu13_En;
	assign node13_nicWrEn  = nic31_cpu13_WrEn;

	assign node14_addr_nic = nic32_cpu14_addr;
	assign node14_din_nic  = nic32_cpu14_din;
	assign node14_dout_nic = nic32_cpu14_dout;
	assign node14_nicEn    = nic32_cpu14_En;
	assign node14_nicWrEn  = nic32_cpu14_WrEn;

	assign node15_addr_nic = nic33_cpu15_addr;
	assign node15_din_nic  = nic33_cpu15_din;
	assign node15_dout_nic = nic33_cpu15_dout;
	assign node15_nicEn    = nic33_cpu15_En;
	assign node15_nicWrEn  = nic33_cpu15_WrEn;


endmodule


