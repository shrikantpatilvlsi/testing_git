/////////////////////////////////////////////////////////
// Filename         : tb_cmp_basic_check.v
// Description      : Basic check for packet passing from
//                    One CPU to another CPU
// Author           : Group 1
/////////////////////////////////////////////////////////
// Test Bench for the Cardinal Processor GRID RTL Verification

`timescale 1ns/10ps

//Define the clock cycle
`define CYCLE_TIME 100

// Include Files
`include "./design/cardinal_cmp.v"
`include "./design/cardinal_cpu.v"
`include "./design/channel_buffer.v"
`include "./design/input_control.v"
`include "./design/mesh_archi.v"
`include "./design/mesh_router.v"
`include "./design/NIC.v"
`include "./design/output_arbiter.v"
`include "./design/register_file.v"
`include "./design/priority_decider.v"
`include "./design/request_generator.v"
`include "./design/swapbits.v"
`include "./design/alu.v"

// Memory Files
`include "./include/dmem.v"
`include "./include/imem.v"
`include "./include/gscl45nm.v"

// Register File
//`include "./design/REGFILE32x64.v"

//Design File
//`include "./design/cpu.v"
//`include "./design/cardinal_nic.v"
//`include "./design/cardinal_ring.v"
//`include "./design/cardinal_router.v"

// This testbench instantiates the following modules:
// a. 64-bit Variable width Cardinal Processor as CPU,
// b. 256 X 32 bit word Instruction memory
// c. 256 X 64 bit word Data memory

module tb_cmp_basic_check;
	reg CLK, RESET;


//Definitions for Sender processor
	wire [0:31] node0_pc_out;
	wire [0:31] node0_inst_in;
	wire [0:31] node0_addr_out;
	wire [0:63] node0_d_out, node0_d_in;
	wire node0_memEn, node0_memWrEn;

//Definitions for the Receiver Processor
	wire [0:31] node1_pc_out;
	wire [0:31] node1_inst_in;
	wire [0:31] node1_addr_out;
	wire [0:63] node1_d_out, node1_d_in;
	wire node1_memEn, node1_memWrEn;


	wire [0:31] node2_pc_out;
	wire [0:31] node2_inst_in;
	wire [0:31] node2_addr_out;
	wire [0:63] node2_d_out, node2_d_in;
	wire node2_memEn, node2_memWrEn;

	wire [0:31] node3_pc_out;
	wire [0:31] node3_inst_in;
	wire [0:31] node3_addr_out;
	wire [0:63] node3_d_out, node3_d_in;
	wire node3_memEn, node3_memWrEn;

	wire [0:31] node4_pc_out;
	wire [0:31] node4_inst_in;
	wire [0:31] node4_addr_out;
	wire [0:63] node4_d_out, node4_d_in;
	wire node4_memEn, node4_memWrEn;

	wire [0:31] node5_pc_out;
	wire [0:31] node5_inst_in;
	wire [0:31] node5_addr_out;
	wire [0:63] node5_d_out, node5_d_in;
	wire node5_memEn, node5_memWrEn;

	wire [0:31] node6_pc_out;
	wire [0:31] node6_inst_in;
	wire [0:31] node6_addr_out;
	wire [0:63] node6_d_out, node6_d_in;
	wire node6_memEn, node6_memWrEn;

	wire [0:31] node7_pc_out;
	wire [0:31] node7_inst_in;
	wire [0:31] node7_addr_out;
	wire [0:63] node7_d_out, node7_d_in;
	wire node7_memEn, node7_memWrEn;

	wire [0:31] node8_pc_out;
	wire [0:31] node8_inst_in;
	wire [0:31] node8_addr_out;
	wire [0:63] node8_d_out, node8_d_in;
	wire node8_memEn, node8_memWrEn;

	wire [0:31] node9_pc_out;
	wire [0:31] node9_inst_in;
	wire [0:31] node9_addr_out;
	wire [0:63] node9_d_out, node9_d_in;
	wire node9_memEn, node9_memWrEn;

	wire [0:31] node10_pc_out;
	wire [0:31] node10_inst_in;
	wire [0:31] node10_addr_out;
	wire [0:63] node10_d_out, node10_d_in;
	wire node10_memEn, node10_memWrEn;

	wire [0:31] node11_pc_out;
	wire [0:31] node11_inst_in;
	wire [0:31] node11_addr_out;
	wire [0:63] node11_d_out, node11_d_in;
	wire node11_memEn, node11_memWrEn;

	wire [0:31] node12_pc_out;
	wire [0:31] node12_inst_in;
	wire [0:31] node12_addr_out;
	wire [0:63] node12_d_out, node12_d_in;
	wire node12_memEn, node12_memWrEn;

	wire [0:31] node13_pc_out;
	wire [0:31] node13_inst_in;
	wire [0:31] node13_addr_out;
	wire [0:63] node13_d_out, node13_d_in;
	wire node13_memEn, node13_memWrEn;

	wire [0:31] node14_pc_out;
	wire [0:31] node14_inst_in;
	wire [0:31] node14_addr_out;
	wire [0:63] node14_d_out, node14_d_in;
	wire node14_memEn, node14_memWrEn;

	wire [0:31] node15_pc_out;
	wire [0:31] node15_inst_in;
	wire [0:31] node15_addr_out;
	wire [0:63] node15_d_out, node15_d_in;
	wire node15_memEn, node15_memWrEn;


	integer dmem0_dump_file;        // Channel Descriptor for DMEM0 final dump
	integer dmem1_dump_file;       // Channel Descriptor for DMEM1 final dump
	integer dmem2_dump_file;       // Channel Descriptor for DMEM1 final dump
	integer dmem3_dump_file;       // Channel Descriptor for DMEM1 final dump
	integer dmem4_dump_file;       // Channel Descriptor for DMEM1 final dump
	integer dmem5_dump_file;       // Channel Descriptor for DMEM1 final dump
	integer dmem6_dump_file;       // Channel Descriptor for DMEM1 final dump
	integer dmem7_dump_file;       // Channel Descriptor for DMEM1 final dump
	integer dmem8_dump_file;        // Channel Descriptor for DMEM0 final dump
	integer dmem9_dump_file;       // Channel Descriptor for DMEM1 final dump
	integer dmem10_dump_file;       // Channel Descriptor for DMEM1 final dump
	integer dmem11_dump_file;       // Channel Descriptor for DMEM1 final dump
	integer dmem12_dump_file;       // Channel Descriptor for DMEM1 final dump
	integer dmem13_dump_file;       // Channel Descriptor for DMEM1 final dump
	integer dmem14_dump_file;       // Channel Descriptor for DMEM1 final dump
	integer dmem15_dump_file;       // Channel Descriptor for DMEM1 final dump

	integer i;
	integer cycle_number;

//// ******************** Module Instantiations ******************** \\\\

// Instruction Memory Instance
	imem IM_node0 (
		.memAddr        (node0_pc_out[22:29]),  // Only 8-bits are used in this project
		.dataOut        (node0_inst_in)     // 32-bit  Instruction
	);

	imem IM_node1 (
		.memAddr        (node1_pc_out[22:29]),  // Only 8-bits are used in this project
		.dataOut        (node1_inst_in)     // 32-bit  Instruction
	);

	imem IM_node2 (
		.memAddr        (node2_pc_out[22:29]),  // Only 8-bits are used in this project
		.dataOut        (node2_inst_in)     // 32-bit  Instruction
	);

	imem IM_node3 (
		.memAddr        (node3_pc_out[22:29]),  // Only 8-bits are used in this project
		.dataOut        (node3_inst_in)     // 32-bit  Instruction
		);

	imem IM_node4 (
	.memAddr		(node4_pc_out[22:29]),	// Only 8-bits are used in this project
	.dataOut		(node4_inst_in)		// 32-bit  Instruction
		);

	imem IM_node5 (
	.memAddr		(node5_pc_out[22:29]),	// Only 8-bits are used in this project
	.dataOut		(node5_inst_in)		// 32-bit  Instruction
		);

	imem IM_node6 (
	.memAddr		(node6_pc_out[22:29]),	// Only 8-bits are used in this project
	.dataOut		(node6_inst_in)		// 32-bit  Instruction
		);

	imem IM_node7 (
	.memAddr		(node7_pc_out[22:29]),	// Only 8-bits are used in this project
	.dataOut		(node7_inst_in)		// 32-bit  Instruction
		);

	imem IM_node8 (
	.memAddr		(node8_pc_out[22:29]),	// Only 8-bits are used in this project
	.dataOut		(node8_inst_in)		// 32-bit  Instruction
		);

	imem IM_node9 (
	.memAddr		(node9_pc_out[22:29]),	// Only 8-bits are used in this project
	.dataOut		(node9_inst_in)		// 32-bit  Instruction
		);

	imem IM_node10 (
	.memAddr		(node10_pc_out[22:29]),	// Only 8-bits are used in this project
	.dataOut		(node10_inst_in)		// 32-bit  Instruction
		);

	imem IM_node11 (
	.memAddr		(node11_pc_out[22:29]),	// Only 8-bits are used in this project
	.dataOut		(node11_inst_in)		// 32-bit  Instruction
		);

	imem IM_node12 (
	.memAddr		(node12_pc_out[22:29]),	// Only 8-bits are used in this project
	.dataOut		(node12_inst_in)		// 32-bit  Instruction
		);

	imem IM_node13 (
	.memAddr		(node13_pc_out[22:29]),	// Only 8-bits are used in this project
	.dataOut		(node13_inst_in)		// 32-bit  Instruction
		);

	imem IM_node14 (
	.memAddr		(node14_pc_out[22:29]),	// Only 8-bits are used in this project
	.dataOut		(node14_inst_in)		// 32-bit  Instruction
		);

	imem IM_node15 (
	.memAddr		(node15_pc_out[22:29]),	// Only 8-bits are used in this project
	.dataOut		(node15_inst_in)		// 32-bit  Instruction
	);



// Data Memory Instance
	dmem DM_node0 (
		.clk        (CLK),              // System Clock
		.memEn      (node0_memEn),          // data-memory enable (to avoid spurious reads)
		.memWrEn    (node0_memWrEn),        // data-memory Write Enable
		.memAddr    (node0_addr_out[24:31]),    // 8-bit Memory address
		.dataIn     (node0_d_out),          // 64-bit data to data-memory
		.dataOut    (node0_d_in)            // 64-bit data from data-memory
	);

	dmem DM_node1 (
		.clk        (CLK),              // System Clock
		.memEn      (node1_memEn),          // data-memory enable (to avoid spurious reads)
		.memWrEn    (node1_memWrEn),        // data-memory Write Enable
		.memAddr    (node1_addr_out[24:31]),    // 8-bit Memory address
		.dataIn     (node1_d_out),          // 64-bit data to data-memory
		.dataOut    (node1_d_in)            // 64-bit data from data-memory
		);

	dmem DM_node2 (
		.clk        (CLK),              // System Clock
		.memEn      (node2_memEn),          // data-memory enable (to avoid spurious reads)
		.memWrEn    (node2_memWrEn),        // data-memory Write Enable
		.memAddr    (node2_addr_out[24:31]),    // 8-bit Memory address
		.dataIn     (node2_d_out),          // 64-bit data to data-memory
		.dataOut    (node2_d_in)            // 64-bit data from data-memory
		);

	dmem DM_node3 (
		.clk        (CLK),              // System Clock
		.memEn      (node3_memEn),          // data-memory enable (to avoid spurious reads)
		.memWrEn    (node3_memWrEn),        // data-memory Write Enable
		.memAddr    (node3_addr_out[24:31]),    // 8-bit Memory address
		.dataIn     (node3_d_out),          // 64-bit data to data-memory
		.dataOut    (node3_d_in)            // 64-bit data from data-memory
		);

	dmem DM_node4 (
		.clk        (CLK),              // System Clock
		.memEn      (node4_memEn),          // data-memory enable (to avoid spurious reads)
		.memWrEn    (node4_memWrEn),        // data-memory Write Enable
		.memAddr    (node4_addr_out[24:31]),    // 8-bit Memory address
		.dataIn     (node4_d_out),          // 64-bit data to data-memory
		.dataOut    (node4_d_in)            // 64-bit data from data-memory
		);

	dmem DM_node5 (
		.clk        (CLK),              // System Clock
		.memEn      (node5_memEn),          // data-memory enable (to avoid spurious reads)
		.memWrEn    (node5_memWrEn),        // data-memory Write Enable
		.memAddr    (node5_addr_out[24:31]),    // 8-bit Memory address
		.dataIn     (node5_d_out),          // 64-bit data to data-memory
		.dataOut    (node5_d_in)            // 64-bit data from data-memory
		);

	dmem DM_node6 (
		.clk        (CLK),              // System Clock
		.memEn      (node6_memEn),          // data-memory enable (to avoid spurious reads)
		.memWrEn    (node6_memWrEn),        // data-memory Write Enable
		.memAddr    (node6_addr_out[24:31]),    // 8-bit Memory address
		.dataIn     (node6_d_out),          // 64-bit data to data-memory
		.dataOut    (node6_d_in)            // 64-bit data from data-memory
		);

	dmem DM_node7 (
		.clk        (CLK),              // System Clock
		.memEn      (node7_memEn),          // data-memory enable (to avoid spurious reads)
		.memWrEn    (node7_memWrEn),        // data-memory Write Enable
		.memAddr    (node7_addr_out[24:31]),    // 8-bit Memory address
		.dataIn     (node7_d_out),          // 64-bit data to data-memory
		.dataOut    (node7_d_in)            // 64-bit data from data-memory
		);

	dmem DM_node8 (
		.clk        (CLK),              // System Clock
		.memEn      (node8_memEn),          // data-memory enable (to avoid spurious reads)
		.memWrEn    (node8_memWrEn),        // data-memory Write Enable
		.memAddr    (node8_addr_out[24:31]),    // 8-bit Memory address
		.dataIn     (node8_d_out),          // 64-bit data to data-memory
		.dataOut    (node8_d_in)            // 64-bit data from data-memory
		);

	dmem DM_node9 (
		.clk        (CLK),              // System Clock
		.memEn      (node9_memEn),          // data-memory enable (to avoid spurious reads)
		.memWrEn    (node9_memWrEn),        // data-memory Write Enable
		.memAddr    (node9_addr_out[24:31]),    // 8-bit Memory address
		.dataIn     (node9_d_out),          // 64-bit data to data-memory
		.dataOut    (node9_d_in)            // 64-bit data from data-memory
		);

	dmem DM_node10 (
		.clk        (CLK),              // System Clock
		.memEn      (node10_memEn),          // data-memory enable (to avoid spurious reads)
		.memWrEn    (node10_memWrEn),        // data-memory Write Enable
		.memAddr    (node10_addr_out[24:31]),    // 8-bit Memory address
		.dataIn     (node10_d_out),          // 64-bit data to data-memory
		.dataOut    (node10_d_in)            // 64-bit data from data-memory
		);

	dmem DM_node11 (
		.clk        (CLK),              // System Clock
		.memEn      (node11_memEn),          // data-memory enable (to avoid spurious reads)
		.memWrEn    (node11_memWrEn),        // data-memory Write Enable
		.memAddr    (node11_addr_out[24:31]),    // 8-bit Memory address
		.dataIn     (node11_d_out),          // 64-bit data to data-memory
		.dataOut    (node11_d_in)            // 64-bit data from data-memory
		);

	dmem DM_node12 (
		.clk        (CLK),              // System Clock
		.memEn      (node12_memEn),          // data-memory enable (to avoid spurious reads)
		.memWrEn    (node12_memWrEn),        // data-memory Write Enable
		.memAddr    (node12_addr_out[24:31]),    // 8-bit Memory address
		.dataIn     (node12_d_out),          // 64-bit data to data-memory
		.dataOut    (node12_d_in)            // 64-bit data from data-memory
		);

	dmem DM_node13 (
		.clk        (CLK),              // System Clock
		.memEn      (node13_memEn),          // data-memory enable (to avoid spurious reads)
		.memWrEn    (node13_memWrEn),        // data-memory Write Enable
		.memAddr    (node13_addr_out[24:31]),    // 8-bit Memory address
		.dataIn     (node13_d_out),          // 64-bit data to data-memory
		.dataOut    (node13_d_in)            // 64-bit data from data-memory
		);

	dmem DM_node14 (
		.clk        (CLK),              // System Clock
		.memEn      (node14_memEn),          // data-memory enable (to avoid spurious reads)
		.memWrEn    (node14_memWrEn),        // data-memory Write Enable
		.memAddr    (node14_addr_out[24:31]),    // 8-bit Memory address
		.dataIn     (node14_d_out),          // 64-bit data to data-memory
		.dataOut    (node14_d_in)            // 64-bit data from data-memory
		);

	dmem DM_node15 (
		.clk        (CLK),              // System Clock
		.memEn      (node15_memEn),          // data-memory enable (to avoid spurious reads)
		.memWrEn    (node15_memWrEn),        // data-memory Write Enable
		.memAddr    (node15_addr_out[24:31]),    // 8-bit Memory address
		.dataIn     (node15_d_out),          // 64-bit data to data-memory
		.dataOut    (node15_d_in)            // 64-bit data from data-memory
	);


	cardinal_cmp CMP(
		.clk(CLK),
		.reset(RESET),

		.node0_inst_in  (node0_inst_in  ),
		.node0_d_in     (node0_d_in ),
		.node0_pc_out   (node0_pc_out   ),
		.node0_d_out    (node0_d_out    ),
		.node0_addr_out (node0_addr_out ),
		.node0_memWrEn  (node0_memWrEn  ),
		.node0_memEn    (node0_memEn    ),
		.node0_addr_nic(),
		.node0_din_nic(),
		.node0_dout_nic(),
		.node0_nicEn(),
		.node0_nicWrEn(),

		.node1_inst_in  (node1_inst_in),
		.node1_d_in     (node1_d_in),
		.node1_pc_out   (node1_pc_out),
		.node1_d_out    (node1_d_out),
		.node1_addr_out (node1_addr_out),
		.node1_memWrEn  (node1_memWrEn),
		.node1_memEn    (node1_memEn),
		.node1_addr_nic(),
		.node1_din_nic(),
		.node1_dout_nic(),
		.node1_nicEn(),
		.node1_nicWrEn(),

		.node2_inst_in  (node2_inst_in),
		.node2_d_in     (node2_d_in),
		.node2_pc_out   (node2_pc_out),
		.node2_d_out    (node2_d_out),
		.node2_addr_out (node2_addr_out),
		.node2_memWrEn  (node2_memWrEn),
		.node2_memEn    (node2_memEn),
		.node2_addr_nic(),
		.node2_din_nic(),
		.node2_dout_nic(),
		.node2_nicEn(),
		.node2_nicWrEn(),

		.node3_inst_in  (node3_inst_in),
		.node3_d_in     (node3_d_in),
		.node3_pc_out   (node3_pc_out),
		.node3_d_out    (node3_d_out),
		.node3_addr_out (node3_addr_out),
		.node3_memWrEn  (node3_memWrEn),
		.node3_memEn    (node3_memEn),
		.node3_addr_nic(),
		.node3_din_nic(),
		.node3_dout_nic(),
		.node3_nicEn(),
		.node3_nicWrEn(),

		.node4_inst_in  (node4_inst_in),
		.node4_d_in     (node4_d_in),
		.node4_pc_out   (node4_pc_out),
		.node4_d_out    (node4_d_out),
		.node4_addr_out (node4_addr_out),
		.node4_memWrEn  (node4_memWrEn),
		.node4_memEn    (node4_memEn),
		.node4_addr_nic(),
		.node4_din_nic(),
		.node4_dout_nic(),
		.node4_nicEn(),
		.node4_nicWrEn(),

		.node5_inst_in  (node5_inst_in),
		.node5_d_in     (node5_d_in),
		.node5_pc_out   (node5_pc_out),
		.node5_d_out    (node5_d_out),
		.node5_addr_out (node5_addr_out),
		.node5_memWrEn  (node5_memWrEn),
		.node5_memEn    (node5_memEn),
		.node5_addr_nic(),
		.node5_din_nic(),
		.node5_dout_nic(),
		.node5_nicEn(),
		.node5_nicWrEn(),

		.node6_inst_in  (node6_inst_in),
		.node6_d_in     (node6_d_in),
		.node6_pc_out   (node6_pc_out),
		.node6_d_out    (node6_d_out),
		.node6_addr_out (node6_addr_out),
		.node6_memWrEn  (node6_memWrEn),
		.node6_memEn    (node6_memEn),
		.node6_addr_nic(),
		.node6_din_nic(),
		.node6_dout_nic(),
		.node6_nicEn(),
		.node6_nicWrEn(),

		.node7_inst_in  (node7_inst_in),
		.node7_d_in     (node7_d_in),
		.node7_pc_out   (node7_pc_out),
		.node7_d_out    (node7_d_out),
		.node7_addr_out (node7_addr_out),
		.node7_memWrEn  (node7_memWrEn),
		.node7_memEn    (node7_memEn),
		.node7_addr_nic(),
		.node7_din_nic(),
		.node7_dout_nic(),
		.node7_nicEn(),
		.node7_nicWrEn(),

		.node8_inst_in  (node8_inst_in),
		.node8_d_in     (node8_d_in),
		.node8_pc_out   (node8_pc_out),
		.node8_d_out    (node8_d_out),
		.node8_addr_out (node8_addr_out),
		.node8_memWrEn  (node8_memWrEn),
		.node8_memEn    (node8_memEn),
		.node8_addr_nic(),
		.node8_din_nic(),
		.node8_dout_nic(),
		.node8_nicEn(),
		.node8_nicWrEn(),

		.node9_inst_in  (node9_inst_in),
		.node9_d_in     (node9_d_in),
		.node9_pc_out   (node9_pc_out),
		.node9_d_out    (node9_d_out),
		.node9_addr_out (node9_addr_out),
		.node9_memWrEn  (node9_memWrEn),
		.node9_memEn    (node9_memEn),
		.node9_addr_nic(),
		.node9_din_nic(),
		.node9_dout_nic(),
		.node9_nicEn(),
		.node9_nicWrEn(),

		.node10_inst_in (node10_inst_in),
		.node10_d_in        (node10_d_in),
		.node10_pc_out      (node10_pc_out),
		.node10_d_out       (node10_d_out),
		.node10_addr_out    (node10_addr_out),
		.node10_memWrEn (node10_memWrEn),
		.node10_memEn    (node10_memEn),
		.node10_addr_nic(),
		.node10_din_nic(),
		.node10_dout_nic(),
		.node10_nicEn(),
		.node10_nicWrEn(),

		.node11_inst_in (node11_inst_in),
		.node11_d_in        (node11_d_in),
		.node11_pc_out      (node11_pc_out),
		.node11_d_out       (node11_d_out),
		.node11_addr_out    (node11_addr_out),
		.node11_memWrEn (node11_memWrEn),
		.node11_memEn    (node11_memEn),
		.node11_addr_nic(),
		.node11_din_nic(),
		.node11_dout_nic(),
		.node11_nicEn(),
		.node11_nicWrEn(),

		.node12_inst_in (node12_inst_in),
		.node12_d_in        (node12_d_in),
		.node12_pc_out      (node12_pc_out),
		.node12_d_out       (node12_d_out),
		.node12_addr_out    (node12_addr_out),
		.node12_memWrEn (node12_memWrEn),
		.node12_memEn    (node12_memEn),
		.node12_addr_nic(),
		.node12_din_nic(),
		.node12_dout_nic(),
		.node12_nicEn(),
		.node12_nicWrEn(),

		.node13_inst_in (node13_inst_in),
		.node13_d_in        (node13_d_in),
		.node13_pc_out      (node13_pc_out),
		.node13_d_out       (node13_d_out),
		.node13_addr_out    (node13_addr_out),
		.node13_memWrEn (node13_memWrEn),
		.node13_memEn    (node13_memEn),
		.node13_addr_nic(),
		.node13_din_nic(),
		.node13_dout_nic(),
		.node13_nicEn(),
		.node13_nicWrEn(),

		.node14_inst_in (node14_inst_in),
		.node14_d_in        (node14_d_in),
		.node14_pc_out      (node14_pc_out),
		.node14_d_out       (node14_d_out),
		.node14_addr_out    (node14_addr_out),
		.node14_memWrEn (node14_memWrEn),
		.node14_memEn    (node14_memEn),
		.node14_addr_nic(),
		.node14_din_nic(),
		.node14_dout_nic(),
		.node14_nicEn(),
		.node14_nicWrEn(),

		.node15_inst_in (node15_inst_in),
		.node15_d_in        (node15_d_in),
		.node15_pc_out      (node15_pc_out),
		.node15_d_out       (node15_d_out),
		.node15_addr_out    (node15_addr_out),
		.node15_memWrEn (node15_memWrEn),
		.node15_memEn    (node15_memEn),
		.node15_addr_nic(),
		.node15_din_nic(),
		.node15_dout_nic(),
		.node15_nicEn(),
		.node15_nicWrEn()


	);

	always #(`CYCLE_TIME / 2) CLK = ~CLK;

	initial begin
		#150000
		$finish;
	end

	initial
	begin
		$display("READMEMH\n\n\n");
		$readmemh("cmp_test.imem.0.fill", IM_node0.MEM);    // loading instruction memory into node0
		$readmemh("cmp_test.imem.1.fill", IM_node1.MEM);    // loading instruction memory into node1
		$readmemh("cmp_test.imem.2.fill", IM_node2.MEM);    // loading instruction memory into node0
		$readmemh("cmp_test.imem.3.fill", IM_node3.MEM);    // loading instruction memory into node1
		$readmemh("cmp_test.imem.4.fill", IM_node4.MEM);    // loading instruction memory into node0
		$readmemh("cmp_test.imem.5.fill", IM_node5.MEM);    // loading instruction memory into node1
		$readmemh("cmp_test.imem.6.fill", IM_node6.MEM);    // loading instruction memory into node0
		$readmemh("cmp_test.imem.7.fill", IM_node7.MEM);    // loading instruction memory into node1
		$readmemh("cmp_test.imem.8.fill", IM_node8.MEM);    // loading instruction memory into node0
		$readmemh("cmp_test.imem.9.fill", IM_node9.MEM);    // loading instruction memory into node1
		$readmemh("cmp_test.imem.10.fill", IM_node10.MEM);    // loading instruction memory into node0
		$readmemh("cmp_test.imem.11.fill", IM_node11.MEM);    // loading instruction memory into node1
		$readmemh("cmp_test.imem.12.fill", IM_node12.MEM);    // loading instruction memory into node0
		$readmemh("cmp_test.imem.13.fill", IM_node13.MEM);    // loading instruction memory into node1
		$readmemh("cmp_test.imem.14.fill", IM_node14.MEM);    // loading instruction memory into node0
		$readmemh("cmp_test.imem.15.fill", IM_node15.MEM);    // loading instruction memory into node1


		$readmemh("cmp_test.dmem.0.fill", DM_node0.MEM);    // loading data memory into node0
		$readmemh("cmp_test.dmem.1.fill", DM_node1.MEM);    // loading data memory into node15
		$readmemh("cmp_test.dmem.2.fill", DM_node2.MEM);    // loading data memory into node0
		$readmemh("cmp_test.dmem.3.fill", DM_node3.MEM);    // loading data memory into node15
		$readmemh("cmp_test.dmem.4.fill", DM_node4.MEM);    // loading data memory into node0
		$readmemh("cmp_test.dmem.5.fill", DM_node5.MEM);    // loading data memory into node15
		$readmemh("cmp_test.dmem.6.fill", DM_node6.MEM);    // loading data memory into node0
		$readmemh("cmp_test.dmem.7.fill", DM_node7.MEM);    // loading data memory into node15
		$readmemh("cmp_test.dmem.8.fill", DM_node8.MEM);    // loading data memory into node0
		$readmemh("cmp_test.dmem.9.fill", DM_node9.MEM);    // loading data memory into node15
		$readmemh("cmp_test.dmem.10.fill", DM_node10.MEM);    // loading data memory into node0
		$readmemh("cmp_test.dmem.11.fill", DM_node11.MEM);    // loading data memory into node15
		$readmemh("cmp_test.dmem.12.fill", DM_node12.MEM);    // loading data memory into node0
		$readmemh("cmp_test.dmem.13.fill", DM_node13.MEM);    // loading data memory into node15
		$readmemh("cmp_test.dmem.14.fill", DM_node14.MEM);    // loading data memory into node0
		$readmemh("cmp_test.dmem.15.fill", DM_node15.MEM);    // loading data memory into node15

		CLK <= 0;               // initialize Clock
		RESET <= 1'b1;              // reset the CPU
		repeat(5) @(negedge CLK);       // wait for 5 clock cycles
		RESET <= 1'b0;              // de-activate reset signal after 5ns

		// Convention for the last instruction
		// We would have a last instruction NOP  => 32'h00000000
		$display("The program started");
		wait (node0_inst_in == 32'h00000000 && node1_inst_in == 32'h00000000);
		// Let us see how much did you stall
		$display("The program completed in %d cycles", cycle_number);
		// Let us now flush the pipe line
		repeat(23) @(negedge CLK);  // wait for all instruction finished
		// Open file for output
		dmem0_dump_file = $fopen("cmp_test.dmem0.dump"); // assigning the channel descriptor for output file
		dmem1_dump_file = $fopen("cmp_test.dmem1.dump"); // assigning the channel descriptor for output file
		dmem2_dump_file = $fopen("cmp_test.dmem2.dump"); // assigning the channel descriptor for output file
		dmem3_dump_file = $fopen("cmp_test.dmem3.dump"); // assigning the channel descriptor for output file
		dmem4_dump_file = $fopen("cmp_test.dmem4.dump"); // assigning the channel descriptor for output file
		dmem5_dump_file = $fopen("cmp_test.dmem5.dump"); // assigning the channel descriptor for output file
		dmem6_dump_file = $fopen("cmp_test.dmem6.dump"); // assigning the channel descriptor for output file
		dmem7_dump_file = $fopen("cmp_test.dmem7.dump"); // assigning the channel descriptor for output file
		dmem8_dump_file = $fopen("cmp_test.dmem8.dump"); // assigning the channel descriptor for output file
		dmem9_dump_file = $fopen("cmp_test.dmem9.dump"); // assigning the channel descriptor for output file
		dmem10_dump_file = $fopen("cmp_test.dmem10.dump"); // assigning the channel descriptor for output file
		dmem11_dump_file = $fopen("cmp_test.dmem11.dump"); // assigning the channel descriptor for output file
		dmem12_dump_file = $fopen("cmp_test.dmem12.dump"); // assigning the channel descriptor for output file
		dmem13_dump_file = $fopen("cmp_test.dmem13.dump"); // assigning the channel descriptor for output file
		dmem14_dump_file = $fopen("cmp_test.dmem14.dump"); // assigning the channel descriptor for output file
		dmem15_dump_file = $fopen("cmp_test.dmem15.dump"); // assigning the channel descriptor for output file

		// Let us now dump all the locations of the data memory now
		for (i=0; i<128; i=i+1)
		begin
			$fdisplay(dmem0_dump_file, "Memory location #%d : %h ", i, DM_node0.MEM[i]);
			$fdisplay(dmem1_dump_file, "Memory location #%d : %h ", i, DM_node1.MEM[i]);
			$fdisplay(dmem2_dump_file, "Memory location #%d : %h ", i, DM_node2.MEM[i]);
			$fdisplay(dmem3_dump_file, "Memory location #%d : %h ", i, DM_node3.MEM[i]);
			$fdisplay(dmem4_dump_file, "Memory location #%d : %h ", i, DM_node4.MEM[i]);
			$fdisplay(dmem5_dump_file, "Memory location #%d : %h ", i, DM_node5.MEM[i]);
			$fdisplay(dmem6_dump_file, "Memory location #%d : %h ", i, DM_node6.MEM[i]);
			$fdisplay(dmem7_dump_file, "Memory location #%d : %h ", i, DM_node7.MEM[i]);
			$fdisplay(dmem8_dump_file, "Memory location #%d : %h ", i, DM_node8.MEM[i]);
			$fdisplay(dmem9_dump_file, "Memory location #%d : %h ", i, DM_node9.MEM[i]);
			$fdisplay(dmem10_dump_file, "Memory location #%d : %h ", i, DM_node10.MEM[i]);
			$fdisplay(dmem11_dump_file, "Memory location #%d : %h ", i, DM_node11.MEM[i]);
			$fdisplay(dmem12_dump_file, "Memory location #%d : %h ", i, DM_node12.MEM[i]);
			$fdisplay(dmem13_dump_file, "Memory location #%d : %h ", i, DM_node13.MEM[i]);
			$fdisplay(dmem14_dump_file, "Memory location #%d : %h ", i, DM_node14.MEM[i]);
			$fdisplay(dmem15_dump_file, "Memory location #%d : %h ", i, DM_node15.MEM[i]);

		end
		$fclose(dmem0_dump_file);
		$fclose(dmem1_dump_file);
		$fclose(dmem2_dump_file);
		$fclose(dmem3_dump_file);
		$fclose(dmem4_dump_file);
		$fclose(dmem5_dump_file);
		$fclose(dmem6_dump_file);
		$fclose(dmem7_dump_file);
		$fclose(dmem8_dump_file);
		$fclose(dmem9_dump_file);
		$fclose(dmem10_dump_file);
		$fclose(dmem11_dump_file);
		$fclose(dmem12_dump_file);
		$fclose(dmem13_dump_file);
		$fclose(dmem14_dump_file);
		$fclose(dmem15_dump_file);
		$finish;

	end // initial begin

//// ******************** Cycle Counter ******************** \\\\

	always @ (posedge CLK)
	begin
		if (RESET)
			cycle_number <= 0;
		else
			cycle_number <= cycle_number + 1;
	end

endmodule


