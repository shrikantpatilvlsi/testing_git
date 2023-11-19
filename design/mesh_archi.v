module mesh_archi (reset, clk,
	nic00_addr, nic01_addr, nic02_addr, nic03_addr,
	nic10_addr, nic11_addr, nic12_addr, nic13_addr,
	nic20_addr, nic21_addr, nic22_addr, nic23_addr,
	nic30_addr, nic31_addr, nic32_addr, nic33_addr,

	nic00_d_in, nic01_d_in, nic02_d_in, nic03_d_in,
	nic10_d_in, nic11_d_in, nic12_d_in, nic13_d_in,
	nic20_d_in, nic21_d_in, nic22_d_in, nic23_d_in,
	nic30_d_in, nic31_d_in, nic32_d_in, nic33_d_in,

	nic00_d_out, nic01_d_out, nic02_d_out, nic03_d_out,
	nic10_d_out, nic11_d_out, nic12_d_out, nic13_d_out,
	nic20_d_out, nic21_d_out, nic22_d_out, nic23_d_out,
	nic30_d_out, nic31_d_out, nic32_d_out, nic33_d_out,

	nic00_nicEn, nic01_nicEn, nic02_nicEn, nic03_nicEn,
	nic10_nicEn, nic11_nicEn, nic12_nicEn, nic13_nicEn,
	nic20_nicEn, nic21_nicEn, nic22_nicEn, nic23_nicEn,
	nic30_nicEn, nic31_nicEn, nic32_nicEn, nic33_nicEn,

	nic00_nicEnWr, nic01_nicEnWr, nic02_nicEnWr, nic03_nicEnWr,
	nic10_nicEnWr, nic11_nicEnWr, nic12_nicEnWr, nic13_nicEnWr,
	nic20_nicEnWr, nic21_nicEnWr, nic22_nicEnWr, nic23_nicEnWr,
	nic30_nicEnWr, nic31_nicEnWr, nic32_nicEnWr, nic33_nicEnWr
	);

	input reset; // The global synchronous reset
	input clk;	// The system clk
	input wire [0:1] nic00_addr, nic01_addr, nic02_addr, nic03_addr,
	nic10_addr, nic11_addr, nic12_addr, nic13_addr,
	nic20_addr, nic21_addr, nic22_addr, nic23_addr,
	nic30_addr, nic31_addr, nic32_addr, nic33_addr;

	input wire [0:63] nic00_d_in, nic01_d_in, nic02_d_in, nic03_d_in,
	nic10_d_in, nic11_d_in, nic12_d_in, nic13_d_in,
	nic20_d_in, nic21_d_in, nic22_d_in, nic23_d_in,
	nic30_d_in, nic31_d_in, nic32_d_in, nic33_d_in;

	output wire [0:63] nic00_d_out, nic01_d_out, nic02_d_out, nic03_d_out,
	nic10_d_out, nic11_d_out, nic12_d_out, nic13_d_out,
	nic20_d_out, nic21_d_out, nic22_d_out, nic23_d_out,
	nic30_d_out, nic31_d_out, nic32_d_out, nic33_d_out;

	input nic00_nicEn, nic01_nicEn, nic02_nicEn, nic03_nicEn,
	nic10_nicEn, nic11_nicEn, nic12_nicEn, nic13_nicEn,
	nic20_nicEn, nic21_nicEn, nic22_nicEn, nic23_nicEn,
	nic30_nicEn, nic31_nicEn, nic32_nicEn, nic33_nicEn;

	input nic00_nicEnWr, nic01_nicEnWr, nic02_nicEnWr, nic03_nicEnWr,
	nic10_nicEnWr, nic11_nicEnWr, nic12_nicEnWr, nic13_nicEnWr,
	nic20_nicEnWr, nic21_nicEnWr, nic22_nicEnWr, nic23_nicEnWr,
	nic30_nicEnWr, nic31_nicEnWr, nic32_nicEnWr, nic33_nicEnWr;

	parameter PKTWIDTH = 64;



	// router00
	wire [(PKTWIDTH - 1) : 0] r00_dataout_n;
	wire [(PKTWIDTH - 1) : 0] r00_dataout_e;
	wire [(PKTWIDTH - 1) : 0] r00_dataout_s;
	wire [(PKTWIDTH - 1) : 0] r00_dataout_w;
	wire [(PKTWIDTH - 1) : 0] r00_dataout_peout;
	wire r00_so_n;
	wire r00_so_e;
	wire r00_so_s;
	wire r00_so_w;
	wire r00_so_peout;
	wire r00_ri_n;
	wire r00_ri_e;
	wire r00_ri_s;
	wire r00_ri_w;
	wire r00_ri_pein;

	wire [(PKTWIDTH - 1) : 0] r00_datain_n;
	wire [(PKTWIDTH - 1) : 0] r00_datain_e;
	wire [(PKTWIDTH - 1) : 0] r00_datain_s;
	wire [(PKTWIDTH - 1) : 0] r00_datain_w;
	wire [(PKTWIDTH - 1) : 0] r00_datain_pein;
	wire r00_si_n;
	wire r00_si_e;
	wire r00_si_s;
	wire r00_si_w;
	wire r00_si_pein;
	wire r00_ro_n;
	wire r00_ro_e;
	wire r00_ro_s;
	wire r00_ro_w;
	wire r00_ro_peout;

	// router01
	wire [(PKTWIDTH - 1) : 0] r01_dataout_n;
	wire [(PKTWIDTH - 1) : 0] r01_dataout_e;
	wire [(PKTWIDTH - 1) : 0] r01_dataout_s;
	wire [(PKTWIDTH - 1) : 0] r01_dataout_w;
	wire [(PKTWIDTH - 1) : 0] r01_dataout_peout;
	wire r01_so_n;
	wire r01_so_e;
	wire r01_so_s;
	wire r01_so_w;
	wire r01_so_peout;
	wire r01_ri_n;
	wire r01_ri_e;
	wire r01_ri_s;
	wire r01_ri_w;
	wire r01_ri_pein;

	wire [(PKTWIDTH - 1) : 0] r01_datain_n;
	wire [(PKTWIDTH - 1) : 0] r01_datain_e;
	wire [(PKTWIDTH - 1) : 0] r01_datain_s;
	wire [(PKTWIDTH - 1) : 0] r01_datain_w;
	wire [(PKTWIDTH - 1) : 0] r01_datain_pein;
	wire r01_si_n;
	wire r01_si_e;
	wire r01_si_s;
	wire r01_si_w;
	wire r01_si_pein;
	wire r01_ro_n;
	wire r01_ro_e;
	wire r01_ro_s;
	wire r01_ro_w;
	wire r01_ro_peout;

	// router02
	wire [(PKTWIDTH - 1) : 0] r02_dataout_n;
	wire [(PKTWIDTH - 1) : 0] r02_dataout_e;
	wire [(PKTWIDTH - 1) : 0] r02_dataout_s;
	wire [(PKTWIDTH - 1) : 0] r02_dataout_w;
	wire [(PKTWIDTH - 1) : 0] r02_dataout_peout;
	wire r02_so_n;
	wire r02_so_e;
	wire r02_so_s;
	wire r02_so_w;
	wire r02_so_peout;
	wire r02_ri_n;
	wire r02_ri_e;
	wire r02_ri_s;
	wire r02_ri_w;
	wire r02_ri_pein;

	wire [(PKTWIDTH - 1) : 0] r02_datain_n;
	wire [(PKTWIDTH - 1) : 0] r02_datain_e;
	wire [(PKTWIDTH - 1) : 0] r02_datain_s;
	wire [(PKTWIDTH - 1) : 0] r02_datain_w;
	wire [(PKTWIDTH - 1) : 0] r02_datain_pein;
	wire r02_si_n;
	wire r02_si_e;
	wire r02_si_s;
	wire r02_si_w;
	wire r02_si_pein;
	wire r02_ro_n;
	wire r02_ro_e;
	wire r02_ro_s;
	wire r02_ro_w;
	wire r02_ro_peout;

	// router03
	wire [(PKTWIDTH - 1) : 0] r03_dataout_n;
	wire [(PKTWIDTH - 1) : 0] r03_dataout_e;
	wire [(PKTWIDTH - 1) : 0] r03_dataout_s;
	wire [(PKTWIDTH - 1) : 0] r03_dataout_w;
	wire [(PKTWIDTH - 1) : 0] r03_dataout_peout;
	wire r03_so_n;
	wire r03_so_e;
	wire r03_so_s;
	wire r03_so_w;
	wire r03_so_peout;
	wire r03_ri_n;
	wire r03_ri_e;
	wire r03_ri_s;
	wire r03_ri_w;
	wire r03_ri_pein;

	wire [(PKTWIDTH - 1) : 0] r03_datain_n;
	wire [(PKTWIDTH - 1) : 0] r03_datain_e;
	wire [(PKTWIDTH - 1) : 0] r03_datain_s;
	wire [(PKTWIDTH - 1) : 0] r03_datain_w;
	wire [(PKTWIDTH - 1) : 0] r03_datain_pein;
	wire r03_si_n;
	wire r03_si_e;
	wire r03_si_s;
	wire r03_si_w;
	wire r03_si_pein;
	wire r03_ro_n;
	wire r03_ro_e;
	wire r03_ro_s;
	wire r03_ro_w;
	wire r03_ro_peout;

	// router10
	wire [(PKTWIDTH - 1) : 0] r10_dataout_n;
	wire [(PKTWIDTH - 1) : 0] r10_dataout_e;
	wire [(PKTWIDTH - 1) : 0] r10_dataout_s;
	wire [(PKTWIDTH - 1) : 0] r10_dataout_w;
	wire [(PKTWIDTH - 1) : 0] r10_dataout_peout;
	wire r10_so_n;
	wire r10_so_e;
	wire r10_so_s;
	wire r10_so_w;
	wire r10_so_peout;
	wire r10_ri_n;
	wire r10_ri_e;
	wire r10_ri_s;
	wire r10_ri_w;
	wire r10_ri_pein;

	wire [(PKTWIDTH - 1) : 0] r10_datain_n;
	wire [(PKTWIDTH - 1) : 0] r10_datain_e;
	wire [(PKTWIDTH - 1) : 0] r10_datain_s;
	wire [(PKTWIDTH - 1) : 0] r10_datain_w;
	wire [(PKTWIDTH - 1) : 0] r10_datain_pein;
	wire r10_si_n;
	wire r10_si_e;
	wire r10_si_s;
	wire r10_si_w;
	wire r10_si_pein;
	wire r10_ro_n;
	wire r10_ro_e;
	wire r10_ro_s;
	wire r10_ro_w;
	wire r10_ro_peout;

	// router11
	wire [(PKTWIDTH - 1) : 0] r11_dataout_n;
	wire [(PKTWIDTH - 1) : 0] r11_dataout_e;
	wire [(PKTWIDTH - 1) : 0] r11_dataout_s;
	wire [(PKTWIDTH - 1) : 0] r11_dataout_w;
	wire [(PKTWIDTH - 1) : 0] r11_dataout_peout;
	wire r11_so_n;
	wire r11_so_e;
	wire r11_so_s;
	wire r11_so_w;
	wire r11_so_peout;
	wire r11_ri_n;
	wire r11_ri_e;
	wire r11_ri_s;
	wire r11_ri_w;
	wire r11_ri_pein;

	wire [(PKTWIDTH - 1) : 0] r11_datain_n;
	wire [(PKTWIDTH - 1) : 0] r11_datain_e;
	wire [(PKTWIDTH - 1) : 0] r11_datain_s;
	wire [(PKTWIDTH - 1) : 0] r11_datain_w;
	wire [(PKTWIDTH - 1) : 0] r11_datain_pein;
	wire r11_si_n;
	wire r11_si_e;
	wire r11_si_s;
	wire r11_si_w;
	wire r11_si_pein;
	wire r11_ro_n;
	wire r11_ro_e;
	wire r11_ro_s;
	wire r11_ro_w;
	wire r11_ro_peout;

	// router12
	wire [(PKTWIDTH - 1) : 0] r12_dataout_n;
	wire [(PKTWIDTH - 1) : 0] r12_dataout_e;
	wire [(PKTWIDTH - 1) : 0] r12_dataout_s;
	wire [(PKTWIDTH - 1) : 0] r12_dataout_w;
	wire [(PKTWIDTH - 1) : 0] r12_dataout_peout;
	wire r12_so_n;
	wire r12_so_e;
	wire r12_so_s;
	wire r12_so_w;
	wire r12_so_peout;
	wire r12_ri_n;
	wire r12_ri_e;
	wire r12_ri_s;
	wire r12_ri_w;
	wire r12_ri_pein;

	wire [(PKTWIDTH - 1) : 0] r12_datain_n;
	wire [(PKTWIDTH - 1) : 0] r12_datain_e;
	wire [(PKTWIDTH - 1) : 0] r12_datain_s;
	wire [(PKTWIDTH - 1) : 0] r12_datain_w;
	wire [(PKTWIDTH - 1) : 0] r12_datain_pein;
	wire r12_si_n;
	wire r12_si_e;
	wire r12_si_s;
	wire r12_si_w;
	wire r12_si_pein;
	wire r12_ro_n;
	wire r12_ro_e;
	wire r12_ro_s;
	wire r12_ro_w;
	wire r12_ro_peout;

	// router13
	wire [(PKTWIDTH - 1) : 0] r13_dataout_n;
	wire [(PKTWIDTH - 1) : 0] r13_dataout_e;
	wire [(PKTWIDTH - 1) : 0] r13_dataout_s;
	wire [(PKTWIDTH - 1) : 0] r13_dataout_w;
	wire [(PKTWIDTH - 1) : 0] r13_dataout_peout;
	wire r13_so_n;
	wire r13_so_e;
	wire r13_so_s;
	wire r13_so_w;
	wire r13_so_peout;
	wire r13_ri_n;
	wire r13_ri_e;
	wire r13_ri_s;
	wire r13_ri_w;
	wire r13_ri_pein;

	wire [(PKTWIDTH - 1) : 0] r13_datain_n;
	wire [(PKTWIDTH - 1) : 0] r13_datain_e;
	wire [(PKTWIDTH - 1) : 0] r13_datain_s;
	wire [(PKTWIDTH - 1) : 0] r13_datain_w;
	wire [(PKTWIDTH - 1) : 0] r13_datain_pein;
	wire r13_si_n;
	wire r13_si_e;
	wire r13_si_s;
	wire r13_si_w;
	wire r13_si_pein;
	wire r13_ro_n;
	wire r13_ro_e;
	wire r13_ro_s;
	wire r13_ro_w;
	wire r13_ro_peout;

	// router20
	wire [(PKTWIDTH - 1) : 0] r20_dataout_n;
	wire [(PKTWIDTH - 1) : 0] r20_dataout_e;
	wire [(PKTWIDTH - 1) : 0] r20_dataout_s;
	wire [(PKTWIDTH - 1) : 0] r20_dataout_w;
	wire [(PKTWIDTH - 1) : 0] r20_dataout_peout;
	wire r20_so_n;
	wire r20_so_e;
	wire r20_so_s;
	wire r20_so_w;
	wire r20_so_peout;
	wire r20_ri_n;
	wire r20_ri_e;
	wire r20_ri_s;
	wire r20_ri_w;
	wire r20_ri_pein;

	wire [(PKTWIDTH - 1) : 0] r20_datain_n;
	wire [(PKTWIDTH - 1) : 0] r20_datain_e;
	wire [(PKTWIDTH - 1) : 0] r20_datain_s;
	wire [(PKTWIDTH - 1) : 0] r20_datain_w;
	wire [(PKTWIDTH - 1) : 0] r20_datain_pein;
	wire r20_si_n;
	wire r20_si_e;
	wire r20_si_s;
	wire r20_si_w;
	wire r20_si_pein;
	wire r20_ro_n;
	wire r20_ro_e;
	wire r20_ro_s;
	wire r20_ro_w;
	wire r20_ro_peout;

	// router21
	wire [(PKTWIDTH - 1) : 0] r21_dataout_n;
	wire [(PKTWIDTH - 1) : 0] r21_dataout_e;
	wire [(PKTWIDTH - 1) : 0] r21_dataout_s;
	wire [(PKTWIDTH - 1) : 0] r21_dataout_w;
	wire [(PKTWIDTH - 1) : 0] r21_dataout_peout;
	wire r21_so_n;
	wire r21_so_e;
	wire r21_so_s;
	wire r21_so_w;
	wire r21_so_peout;
	wire r21_ri_n;
	wire r21_ri_e;
	wire r21_ri_s;
	wire r21_ri_w;
	wire r21_ri_pein;

	wire [(PKTWIDTH - 1) : 0] r21_datain_n;
	wire [(PKTWIDTH - 1) : 0] r21_datain_e;
	wire [(PKTWIDTH - 1) : 0] r21_datain_s;
	wire [(PKTWIDTH - 1) : 0] r21_datain_w;
	wire [(PKTWIDTH - 1) : 0] r21_datain_pein;
	wire r21_si_n;
	wire r21_si_e;
	wire r21_si_s;
	wire r21_si_w;
	wire r21_si_pein;
	wire r21_ro_n;
	wire r21_ro_e;
	wire r21_ro_s;
	wire r21_ro_w;
	wire r21_ro_peout;

	// router22
	wire [(PKTWIDTH - 1) : 0] r22_dataout_n;
	wire [(PKTWIDTH - 1) : 0] r22_dataout_e;
	wire [(PKTWIDTH - 1) : 0] r22_dataout_s;
	wire [(PKTWIDTH - 1) : 0] r22_dataout_w;
	wire [(PKTWIDTH - 1) : 0] r22_dataout_peout;
	wire r22_so_n;
	wire r22_so_e;
	wire r22_so_s;
	wire r22_so_w;
	wire r22_so_peout;
	wire r22_ri_n;
	wire r22_ri_e;
	wire r22_ri_s;
	wire r22_ri_w;
	wire r22_ri_pein;

	wire [(PKTWIDTH - 1) : 0] r22_datain_n;
	wire [(PKTWIDTH - 1) : 0] r22_datain_e;
	wire [(PKTWIDTH - 1) : 0] r22_datain_s;
	wire [(PKTWIDTH - 1) : 0] r22_datain_w;
	wire [(PKTWIDTH - 1) : 0] r22_datain_pein;
	wire r22_si_n;
	wire r22_si_e;
	wire r22_si_s;
	wire r22_si_w;
	wire r22_si_pein;
	wire r22_ro_n;
	wire r22_ro_e;
	wire r22_ro_s;
	wire r22_ro_w;
	wire r22_ro_peout;

	// router23
	wire [(PKTWIDTH - 1) : 0] r23_dataout_n;
	wire [(PKTWIDTH - 1) : 0] r23_dataout_e;
	wire [(PKTWIDTH - 1) : 0] r23_dataout_s;
	wire [(PKTWIDTH - 1) : 0] r23_dataout_w;
	wire [(PKTWIDTH - 1) : 0] r23_dataout_peout;
	wire r23_so_n;
	wire r23_so_e;
	wire r23_so_s;
	wire r23_so_w;
	wire r23_so_peout;
	wire r23_ri_n;
	wire r23_ri_e;
	wire r23_ri_s;
	wire r23_ri_w;
	wire r23_ri_pein;

	wire [(PKTWIDTH - 1) : 0] r23_datain_n;
	wire [(PKTWIDTH - 1) : 0] r23_datain_e;
	wire [(PKTWIDTH - 1) : 0] r23_datain_s;
	wire [(PKTWIDTH - 1) : 0] r23_datain_w;
	wire [(PKTWIDTH - 1) : 0] r23_datain_pein;
	wire r23_si_n;
	wire r23_si_e;
	wire r23_si_s;
	wire r23_si_w;
	wire r23_si_pein;
	wire r23_ro_n;
	wire r23_ro_e;
	wire r23_ro_s;
	wire r23_ro_w;
	wire r23_ro_peout;


	// router30
	wire [(PKTWIDTH - 1) : 0] r30_dataout_n;
	wire [(PKTWIDTH - 1) : 0] r30_dataout_e;
	wire [(PKTWIDTH - 1) : 0] r30_dataout_s;
	wire [(PKTWIDTH - 1) : 0] r30_dataout_w;
	wire [(PKTWIDTH - 1) : 0] r30_dataout_peout;
	wire r30_so_n;
	wire r30_so_e;
	wire r30_so_s;
	wire r30_so_w;
	wire r30_so_peout;
	wire r30_ri_n;
	wire r30_ri_e;
	wire r30_ri_s;
	wire r30_ri_w;
	wire r30_ri_pein;

	wire [(PKTWIDTH - 1) : 0] r30_datain_n;
	wire [(PKTWIDTH - 1) : 0] r30_datain_e;
	wire [(PKTWIDTH - 1) : 0] r30_datain_s;
	wire [(PKTWIDTH - 1) : 0] r30_datain_w;
	wire [(PKTWIDTH - 1) : 0] r30_datain_pein;
	wire r30_si_n;
	wire r30_si_e;
	wire r30_si_s;
	wire r30_si_w;
	wire r30_si_pein;
	wire r30_ro_n;
	wire r30_ro_e;
	wire r30_ro_s;
	wire r30_ro_w;
	wire r30_ro_peout;

	// router31
	wire [(PKTWIDTH - 1) : 0] r31_dataout_n;
	wire [(PKTWIDTH - 1) : 0] r31_dataout_e;
	wire [(PKTWIDTH - 1) : 0] r31_dataout_s;
	wire [(PKTWIDTH - 1) : 0] r31_dataout_w;
	wire [(PKTWIDTH - 1) : 0] r31_dataout_peout;
	wire r31_so_n;
	wire r31_so_e;
	wire r31_so_s;
	wire r31_so_w;
	wire r31_so_peout;
	wire r31_ri_n;
	wire r31_ri_e;
	wire r31_ri_s;
	wire r31_ri_w;
	wire r31_ri_pein;

	wire [(PKTWIDTH - 1) : 0] r31_datain_n;
	wire [(PKTWIDTH - 1) : 0] r31_datain_e;
	wire [(PKTWIDTH - 1) : 0] r31_datain_s;
	wire [(PKTWIDTH - 1) : 0] r31_datain_w;
	wire [(PKTWIDTH - 1) : 0] r31_datain_pein;
	wire r31_si_n;
	wire r31_si_e;
	wire r31_si_s;
	wire r31_si_w;
	wire r31_si_pein;
	wire r31_ro_n;
	wire r31_ro_e;
	wire r31_ro_s;
	wire r31_ro_w;
	wire r31_ro_peout;

	// router32
	wire [(PKTWIDTH - 1) : 0] r32_dataout_n;
	wire [(PKTWIDTH - 1) : 0] r32_dataout_e;
	wire [(PKTWIDTH - 1) : 0] r32_dataout_s;
	wire [(PKTWIDTH - 1) : 0] r32_dataout_w;
	wire [(PKTWIDTH - 1) : 0] r32_dataout_peout;
	wire r32_so_n;
	wire r32_so_e;
	wire r32_so_s;
	wire r32_so_w;
	wire r32_so_peout;
	wire r32_ri_n;
	wire r32_ri_e;
	wire r32_ri_s;
	wire r32_ri_w;
	wire r32_ri_pein;


	wire [(PKTWIDTH - 1) : 0] r32_datain_n;
	wire [(PKTWIDTH - 1) : 0] r32_datain_e;
	wire [(PKTWIDTH - 1) : 0] r32_datain_s;
	wire [(PKTWIDTH - 1) : 0] r32_datain_w;
	wire [(PKTWIDTH - 1) : 0] r32_datain_pein;
	wire r32_si_n;
	wire r32_si_e;
	wire r32_si_s;
	wire r32_si_w;
	wire r32_si_pein;
	wire r32_ro_n;
	wire r32_ro_e;
	wire r32_ro_s;
	wire r32_ro_w;
	wire r32_ro_peout;

	// router33
	wire [(PKTWIDTH - 1) : 0] r33_dataout_n;
	wire [(PKTWIDTH - 1) : 0] r33_dataout_e;
	wire [(PKTWIDTH - 1) : 0] r33_dataout_s;
	wire [(PKTWIDTH - 1) : 0] r33_dataout_w;
	wire [(PKTWIDTH - 1) : 0] r33_dataout_peout;
	wire r33_so_n;
	wire r33_so_e;
	wire r33_so_s;
	wire r33_so_w;
	wire r33_so_peout;
	wire r33_ri_n;
	wire r33_ri_e;
	wire r33_ri_s;
	wire r33_ri_w;
	wire r33_ri_pein;
	wire r33_polarity;

	wire [(PKTWIDTH - 1) : 0] r33_datain_n;
	wire [(PKTWIDTH - 1) : 0] r33_datain_e;
	wire [(PKTWIDTH - 1) : 0] r33_datain_s;
	wire [(PKTWIDTH - 1) : 0] r33_datain_w;
	wire [(PKTWIDTH - 1) : 0] r33_datain_pein;
	wire r33_si_n;
	wire r33_si_e;
	wire r33_si_s;
	wire r33_si_w;
	wire r33_si_pein;
	wire r33_ro_n;
	wire r33_ro_e;
	wire r33_ro_s;
	wire r33_ro_w;
	wire r33_ro_peout;

	wire nic00_net_polarity;
	wire nic01_net_polarity;
	wire nic02_net_polarity;
	wire nic03_net_polarity;

	wire nic10_net_polarity;
	wire nic11_net_polarity;
	wire nic12_net_polarity;
	wire nic13_net_polarity;

	wire nic20_net_polarity;
	wire nic21_net_polarity;
	wire nic22_net_polarity;
	wire nic23_net_polarity;

	wire nic30_net_polarity;
	wire nic31_net_polarity;
	wire nic32_net_polarity;
	wire nic33_net_polarity;

//******** Router ***********//

	// Row0
	mesh_router #(.PKTWIDTH(PKTWIDTH)) r00 (r00_dataout_n,
										  r00_dataout_e,
										  r00_dataout_s,
										  r00_dataout_w,
										  r00_dataout_peout,
										  r00_so_n,
										  r00_so_e,
										  r00_so_s,
										  r00_so_w,
										  r00_so_peout,
										  r00_ri_n,
										  r00_ri_e,
										  r00_ri_s,
										  r00_ri_w,
										  r00_ri_pein,
										  r00_datain_n,
										  r00_datain_e,
										  r00_datain_s,
										  r00_datain_w,
										  r00_datain_pein,
										  r00_si_n,
										  r00_si_e,
										  r00_si_s,
										  r00_si_w,
										  r00_si_pein,
										  r00_ro_n,
										  r00_ro_e,
										  r00_ro_s,
										  r00_ro_w,
										  r00_ro_peout,
										  nic00_net_polarity, reset, clk);


	mesh_router #(.PKTWIDTH(PKTWIDTH)) r01 (r01_dataout_n,
										  r01_dataout_e,
										  r01_dataout_s,
										  r01_dataout_w,
										  r01_dataout_peout,
										  r01_so_n,
										  r01_so_e,
										  r01_so_s,
										  r01_so_w,
										  r01_so_peout,
										  r01_ri_n,
										  r01_ri_e,
										  r01_ri_s,
										  r01_ri_w,
										  r01_ri_pein,
										  r01_datain_n,
										  r01_datain_e,
										  r01_datain_s,
										  r01_datain_w,
										  r01_datain_pein,
										  r01_si_n,
										  r01_si_e,
										  r01_si_s,
										  r01_si_w,
										  r01_si_pein,
										  r01_ro_n,
										  r01_ro_e,
										  r01_ro_s,
										  r01_ro_w,
										  r01_ro_peout,
										  nic01_net_polarity, reset, clk);


	mesh_router #(.PKTWIDTH(PKTWIDTH)) r02 (r02_dataout_n,
										  r02_dataout_e,
										  r02_dataout_s,
										  r02_dataout_w,
										  r02_dataout_peout,
										  r02_so_n,
										  r02_so_e,
										  r02_so_s,
										  r02_so_w,
										  r02_so_peout,
										  r02_ri_n,
										  r02_ri_e,
										  r02_ri_s,
										  r02_ri_w,
										  r02_ri_pein,
										  r02_datain_n,
										  r02_datain_e,
										  r02_datain_s,
										  r02_datain_w,
										  r02_datain_pein,
										  r02_si_n,
										  r02_si_e,
										  r02_si_s,
										  r02_si_w,
										  r02_si_pein,
										  r02_ro_n,
										  r02_ro_e,
										  r02_ro_s,
										  r02_ro_w,
										  r02_ro_peout,
										  nic02_net_polarity, reset, clk);

	mesh_router #(.PKTWIDTH(PKTWIDTH)) r03 (r03_dataout_n,
										  r03_dataout_e,
										  r03_dataout_s,
										  r03_dataout_w,
										  r03_dataout_peout,
										  r03_so_n,
										  r03_so_e,
										  r03_so_s,
										  r03_so_w,
										  r03_so_peout,
										  r03_ri_n,
										  r03_ri_e,
										  r03_ri_s,
										  r03_ri_w,
										  r03_ri_pein,
										  r03_datain_n,
										  r03_datain_e,
										  r03_datain_s,
										  r03_datain_w,
										  r03_datain_pein,
										  r03_si_n,
										  r03_si_e,
										  r03_si_s,
										  r03_si_w,
										  r03_si_pein,
										  r03_ro_n,
										  r03_ro_e,
										  r03_ro_s,
										  r03_ro_w,
										  r03_ro_peout,
										  nic03_net_polarity, reset, clk);


	// Row1
	mesh_router #(.PKTWIDTH(PKTWIDTH)) r10 (r10_dataout_n,
										  r10_dataout_e,
										  r10_dataout_s,
										  r10_dataout_w,
										  r10_dataout_peout,
										  r10_so_n,
										  r10_so_e,
										  r10_so_s,
										  r10_so_w,
										  r10_so_peout,
										  r10_ri_n,
										  r10_ri_e,
										  r10_ri_s,
										  r10_ri_w,
										  r10_ri_pein,
										  r10_datain_n,
										  r10_datain_e,
										  r10_datain_s,
										  r10_datain_w,
										  r10_datain_pein,
										  r10_si_n,
										  r10_si_e,
										  r10_si_s,
										  r10_si_w,
										  r10_si_pein,
										  r10_ro_n,
										  r10_ro_e,
										  r10_ro_s,
										  r10_ro_w,
										  r10_ro_peout,
										  nic10_net_polarity, reset, clk);


	mesh_router #(.PKTWIDTH(PKTWIDTH)) r11 (r11_dataout_n,
										  r11_dataout_e,
										  r11_dataout_s,
										  r11_dataout_w,
										  r11_dataout_peout,
										  r11_so_n,
										  r11_so_e,
										  r11_so_s,
										  r11_so_w,
										  r11_so_peout,
										  r11_ri_n,
										  r11_ri_e,
										  r11_ri_s,
										  r11_ri_w,
										  r11_ri_pein,
										  r11_datain_n,
										  r11_datain_e,
										  r11_datain_s,
										  r11_datain_w,
										  r11_datain_pein,
										  r11_si_n,
										  r11_si_e,
										  r11_si_s,
										  r11_si_w,
										  r11_si_pein,
										  r11_ro_n,
										  r11_ro_e,
										  r11_ro_s,
										  r11_ro_w,
										  r11_ro_peout,
										  nic11_net_polarity, reset, clk);


	mesh_router #(.PKTWIDTH(PKTWIDTH)) r12 (r12_dataout_n,
										  r12_dataout_e,
										  r12_dataout_s,
										  r12_dataout_w,
										  r12_dataout_peout,
										  r12_so_n,
										  r12_so_e,
										  r12_so_s,
										  r12_so_w,
										  r12_so_peout,
										  r12_ri_n,
										  r12_ri_e,
										  r12_ri_s,
										  r12_ri_w,
										  r12_ri_pein,
										  r12_datain_n,
										  r12_datain_e,
										  r12_datain_s,
										  r12_datain_w,
										  r12_datain_pein,
										  r12_si_n,
										  r12_si_e,
										  r12_si_s,
										  r12_si_w,
										  r12_si_pein,
										  r12_ro_n,
										  r12_ro_e,
										  r12_ro_s,
										  r12_ro_w,
										  r12_ro_peout,
										  nic12_net_polarity, reset, clk);

	mesh_router #(.PKTWIDTH(PKTWIDTH)) r13 (r13_dataout_n,
										  r13_dataout_e,
										  r13_dataout_s,
										  r13_dataout_w,
										  r13_dataout_peout,
										  r13_so_n,
										  r13_so_e,
										  r13_so_s,
										  r13_so_w,
										  r13_so_peout,
										  r13_ri_n,
										  r13_ri_e,
										  r13_ri_s,
										  r13_ri_w,
										  r13_ri_pein,
										  r13_datain_n,
										  r13_datain_e,
										  r13_datain_s,
										  r13_datain_w,
										  r13_datain_pein,
										  r13_si_n,
										  r13_si_e,
										  r13_si_s,
										  r13_si_w,
										  r13_si_pein,
										  r13_ro_n,
										  r13_ro_e,
										  r13_ro_s,
										  r13_ro_w,
										  r13_ro_peout,
										  nic13_net_polarity, reset, clk);

	// Row2
	mesh_router #(.PKTWIDTH(PKTWIDTH)) r20 (r20_dataout_n,
										  r20_dataout_e,
										  r20_dataout_s,
										  r20_dataout_w,
										  r20_dataout_peout,
										  r20_so_n,
										  r20_so_e,
										  r20_so_s,
										  r20_so_w,
										  r20_so_peout,
										  r20_ri_n,
										  r20_ri_e,
										  r20_ri_s,
										  r20_ri_w,
										  r20_ri_pein,
										  r20_datain_n,
										  r20_datain_e,
										  r20_datain_s,
										  r20_datain_w,
										  r20_datain_pein,
										  r20_si_n,
										  r20_si_e,
										  r20_si_s,
										  r20_si_w,
										  r20_si_pein,
										  r20_ro_n,
										  r20_ro_e,
										  r20_ro_s,
										  r20_ro_w,
										  r20_ro_peout,
										  nic20_net_polarity, reset, clk);


	mesh_router #(.PKTWIDTH(PKTWIDTH)) r21 (r21_dataout_n,
										  r21_dataout_e,
										  r21_dataout_s,
										  r21_dataout_w,
										  r21_dataout_peout,
										  r21_so_n,
										  r21_so_e,
										  r21_so_s,
										  r21_so_w,
										  r21_so_peout,
										  r21_ri_n,
										  r21_ri_e,
										  r21_ri_s,
										  r21_ri_w,
										  r21_ri_pein,
										  r21_datain_n,
										  r21_datain_e,
										  r21_datain_s,
										  r21_datain_w,
										  r21_datain_pein,
										  r21_si_n,
										  r21_si_e,
										  r21_si_s,
										  r21_si_w,
										  r21_si_pein,
										  r21_ro_n,
										  r21_ro_e,
										  r21_ro_s,
										  r21_ro_w,
										  r21_ro_peout,
										  nic21_net_polarity, reset, clk);


	mesh_router #(.PKTWIDTH(PKTWIDTH)) r22 (r22_dataout_n,
										  r22_dataout_e,
										  r22_dataout_s,
										  r22_dataout_w,
										  r22_dataout_peout,
										  r22_so_n,
										  r22_so_e,
										  r22_so_s,
										  r22_so_w,
										  r22_so_peout,
										  r22_ri_n,
										  r22_ri_e,
										  r22_ri_s,
										  r22_ri_w,
										  r22_ri_pein,
										  r22_datain_n,
										  r22_datain_e,
										  r22_datain_s,
										  r22_datain_w,
										  r22_datain_pein,
										  r22_si_n,
										  r22_si_e,
										  r22_si_s,
										  r22_si_w,
										  r22_si_pein,
										  r22_ro_n,
										  r22_ro_e,
										  r22_ro_s,
										  r22_ro_w,
										  r22_ro_peout,
										  nic22_net_polarity, reset, clk);

	mesh_router #(.PKTWIDTH(PKTWIDTH)) r23 (r23_dataout_n,
										  r23_dataout_e,
										  r23_dataout_s,
										  r23_dataout_w,
										  r23_dataout_peout,
										  r23_so_n,
										  r23_so_e,
										  r23_so_s,
										  r23_so_w,
										  r23_so_peout,
										  r23_ri_n,
										  r23_ri_e,
										  r23_ri_s,
										  r23_ri_w,
										  r23_ri_pein,
										  r23_datain_n,
										  r23_datain_e,
										  r23_datain_s,
										  r23_datain_w,
										  r23_datain_pein,
										  r23_si_n,
										  r23_si_e,
										  r23_si_s,
										  r23_si_w,
										  r23_si_pein,
										  r23_ro_n,
										  r23_ro_e,
										  r23_ro_s,
										  r23_ro_w,
										  r23_ro_peout,
										  nic23_net_polarity, reset, clk);

	// Row3
	mesh_router #(.PKTWIDTH(PKTWIDTH)) r30 (r30_dataout_n,
										  r30_dataout_e,
										  r30_dataout_s,
										  r30_dataout_w,
										  r30_dataout_peout,
										  r30_so_n,
										  r30_so_e,
										  r30_so_s,
										  r30_so_w,
										  r30_so_peout,
										  r30_ri_n,
										  r30_ri_e,
										  r30_ri_s,
										  r30_ri_w,
										  r30_ri_pein,
										  r30_datain_n,
										  r30_datain_e,
										  r30_datain_s,
										  r30_datain_w,
										  r30_datain_pein,
										  r30_si_n,
										  r30_si_e,
										  r30_si_s,
										  r30_si_w,
										  r30_si_pein,
										  r30_ro_n,
										  r30_ro_e,
										  r30_ro_s,
										  r30_ro_w,
										  r30_ro_peout,
										  nic30_net_polarity, reset, clk);


	mesh_router #(.PKTWIDTH(PKTWIDTH)) r31 (r31_dataout_n,
										  r31_dataout_e,
										  r31_dataout_s,
										  r31_dataout_w,
										  r31_dataout_peout,
										  r31_so_n,
										  r31_so_e,
										  r31_so_s,
										  r31_so_w,
										  r31_so_peout,
										  r31_ri_n,
										  r31_ri_e,
										  r31_ri_s,
										  r31_ri_w,
										  r31_ri_pein,
										  r31_datain_n,
										  r31_datain_e,
										  r31_datain_s,
										  r31_datain_w,
										  r31_datain_pein,
										  r31_si_n,
										  r31_si_e,
										  r31_si_s,
										  r31_si_w,
										  r31_si_pein,
										  r31_ro_n,
										  r31_ro_e,
										  r31_ro_s,
										  r31_ro_w,
										  r31_ro_peout,
										  nic31_net_polarity, reset, clk);


	mesh_router #(.PKTWIDTH(PKTWIDTH)) r32 (r32_dataout_n,
										  r32_dataout_e,
										  r32_dataout_s,
										  r32_dataout_w,
										  r32_dataout_peout,
										  r32_so_n,
										  r32_so_e,
										  r32_so_s,
										  r32_so_w,
										  r32_so_peout,
										  r32_ri_n,
										  r32_ri_e,
										  r32_ri_s,
										  r32_ri_w,
										  r32_ri_pein,
										  r32_datain_n,
										  r32_datain_e,
										  r32_datain_s,
										  r32_datain_w,
										  r32_datain_pein,
										  r32_si_n,
										  r32_si_e,
										  r32_si_s,
										  r32_si_w,
										  r32_si_pein,
										  r32_ro_n,
										  r32_ro_e,
										  r32_ro_s,
										  r32_ro_w,
										  r32_ro_peout,
										  nic32_net_polarity, reset, clk);

	mesh_router #(.PKTWIDTH(PKTWIDTH)) r33 (r33_dataout_n,
										  r33_dataout_e,
										  r33_dataout_s,
										  r33_dataout_w,
										  r33_dataout_peout,
										  r33_so_n,
										  r33_so_e,
										  r33_so_s,
										  r33_so_w,
										  r33_so_peout,
										  r33_ri_n,
										  r33_ri_e,
										  r33_ri_s,
										  r33_ri_w,
										  r33_ri_pein,
										  r33_datain_n,
										  r33_datain_e,
										  r33_datain_s,
										  r33_datain_w,
										  r33_datain_pein,
										  r33_si_n,
										  r33_si_e,
										  r33_si_s,
										  r33_si_w,
										  r33_si_pein,
										  r33_ro_n,
										  r33_ro_e,
										  r33_ro_s,
										  r33_ro_w,
										  r33_ro_peout,
										  nic33_net_polarity, reset, clk);


// ********** NIC **************** //

	// Row0
	wire nic00_nicEn;
	wire nic00_nicEnWr;
	wire nic00_net_si;
	wire [0:63] nic00_net_di;
	wire nic00_net_so;
	wire nic00_net_ri;
	wire [0:63] nic00_net_do;



	wire nic01_nicEn;
	wire nic01_nicEnWr;
	wire nic01_net_si;
	wire [0:63] nic01_net_di;
	wire nic01_net_so;
	wire nic01_net_ri;
	wire [0:63] nic01_net_do;




	wire nic02_nicEn;
	wire nic02_nicEnWr;
	wire nic02_net_si;
	wire [0:63] nic02_net_di;
	wire nic02_net_so;
	wire nic02_net_ri;
	wire [0:63] nic02_net_do;




	wire nic03_nicEn;
	wire nic03_nicEnWr;
	wire nic03_net_si;
	wire [0:63] nic03_net_di;
	wire nic03_net_so;
	wire nic03_net_ri;
	wire [0:63] nic03_net_do;

	// Row1



	wire nic10_nicEn;
	wire nic10_nicEnWr;
	wire nic10_net_si;
	wire [0:63] nic10_net_di;
	wire nic10_net_so;
	wire nic10_net_ri;
	wire [0:63] nic10_net_do;




	wire nic11_nicEn;
	wire nic11_nicEnWr;
	wire nic11_net_si;
	wire [0:63] nic11_net_di;
	wire nic11_net_so;
	wire nic11_net_ri;
	wire [0:63] nic11_net_do;




	wire nic12_nicEn;
	wire nic12_nicEnWr;
	wire nic12_net_si;
	wire [0:63] nic12_net_di;
	wire nic12_net_so;
	wire nic12_net_ri;
	wire [0:63] nic12_net_do;




	wire nic13_nicEn;
	wire nic13_nicEnWr;
	wire nic13_net_si;
	wire [0:63] nic13_net_di;
	wire nic13_net_so;
	wire nic13_net_ri;
	wire [0:63] nic13_net_do;

	// Row2



	wire nic20_nicEn;
	wire nic20_nicEnWr;
	wire nic20_net_si;
	wire [0:63] nic20_net_di;
	wire nic20_net_so;
	wire nic20_net_ri;
	wire [0:63] nic20_net_do;




	wire nic21_nicEn;
	wire nic21_nicEnWr;
	wire nic21_net_si;
	wire [0:63] nic21_net_di;
	wire nic21_net_so;
	wire nic21_net_ri;
	wire [0:63] nic21_net_do;




	wire nic22_nicEn;
	wire nic22_nicEnWr;
	wire nic22_net_si;
	wire [0:63] nic22_net_di;
	wire nic22_net_so;
	wire nic22_net_ri;
	wire [0:63] nic22_net_do;




	wire nic23_nicEn;
	wire nic23_nicEnWr;
	wire nic23_net_si;
	wire [0:63] nic23_net_di;
	wire nic23_net_so;
	wire nic23_net_ri;
	wire [0:63] nic23_net_do;

	// Row3



	wire nic30_nicEn;
	wire nic30_nicEnWr;
	wire nic30_net_si;
	wire [0:63] nic30_net_di;
	wire nic30_net_so;
	wire nic30_net_ri;
	wire [0:63] nic30_net_do;




	wire nic31_nicEn;
	wire nic31_nicEnWr;
	wire nic31_net_si;
	wire [0:63] nic31_net_di;
	wire nic31_net_so;
	wire nic31_net_ri;
	wire [0:63] nic31_net_do;




	wire nic32_nicEn;
	wire nic32_nicEnWr;
	wire nic32_net_si;
	wire [0:63] nic32_net_di;
	wire nic32_net_so;
	wire nic32_net_ri;
	wire [0:63] nic32_net_do;




	wire nic33_nicEn;
	wire nic33_nicEnWr;
	wire nic33_net_si;
	wire [0:63] nic33_net_di;
	wire nic33_net_so;
	wire nic33_net_ri;
	wire [0:63] nic33_net_do;

	// Row0
	nic_mesh nic00 (nic00_addr,nic00_d_in,nic00_d_out,nic00_nicEn,nic00_nicEnWr,r00_so_peout,nic00_net_ri,r00_dataout_peout,r00_si_pein,r00_ri_pein,r00_datain_pein,nic00_net_polarity,clk,reset);

	nic_mesh nic01 (nic01_addr,nic01_d_in,nic01_d_out,nic01_nicEn,nic01_nicEnWr,r01_so_peout,nic01_net_ri,r01_dataout_peout,r01_si_pein,r01_ri_pein,r01_datain_pein,nic01_net_polarity,clk,reset);

	nic_mesh nic02 (nic02_addr,nic02_d_in,nic02_d_out,nic02_nicEn,nic02_nicEnWr,r02_so_peout,nic02_net_ri,r02_dataout_peout,r02_si_pein,r02_ri_pein,r02_datain_pein,nic02_net_polarity,clk,reset);

	nic_mesh nic03 (nic03_addr,nic03_d_in,nic03_d_out,nic03_nicEn,nic03_nicEnWr,r03_so_peout,nic03_net_ri,r03_dataout_peout,r03_si_pein,r03_ri_pein,r03_datain_pein,nic03_net_polarity,clk,reset);

	// Row1
	nic_mesh nic10 (nic10_addr,nic10_d_in,nic10_d_out,nic10_nicEn,nic10_nicEnWr,r10_so_peout,nic10_net_ri,r10_dataout_peout,r10_si_pein,r10_ri_pein,r10_datain_pein,nic10_net_polarity,clk,reset);

	nic_mesh nic11 (nic11_addr,nic11_d_in,nic11_d_out,nic11_nicEn,nic11_nicEnWr,r11_so_peout,nic11_net_ri,r11_dataout_peout,r11_si_pein,r11_ri_pein,r11_datain_pein,nic11_net_polarity,clk,reset);

	nic_mesh nic12 (nic12_addr,nic12_d_in,nic12_d_out,nic12_nicEn,nic12_nicEnWr,r12_so_peout,nic12_net_ri,r12_dataout_peout,r12_si_pein,r12_ri_pein,r12_datain_pein,nic12_net_polarity,clk,reset);

	nic_mesh nic13 (nic13_addr,nic13_d_in,nic13_d_out,nic13_nicEn,nic13_nicEnWr,r13_so_peout,nic13_net_ri,r13_dataout_peout,r13_si_pein,r13_ri_pein,r13_datain_pein,nic13_net_polarity,clk,reset);

	// Row2
	nic_mesh nic20 (nic20_addr,nic20_d_in,nic20_d_out,nic20_nicEn,nic20_nicEnWr,r20_so_peout,nic20_net_ri,r20_dataout_peout,r20_si_pein,r20_ri_pein,r20_datain_pein,nic20_net_polarity,clk,reset);

	nic_mesh nic21 (nic21_addr,nic21_d_in,nic21_d_out,nic21_nicEn,nic21_nicEnWr,r21_so_peout,nic21_net_ri,r21_dataout_peout,r21_si_pein,r21_ri_pein,r21_datain_pein,nic21_net_polarity,clk,reset);

	nic_mesh nic22 (nic22_addr,nic22_d_in,nic22_d_out,nic22_nicEn,nic22_nicEnWr,r22_so_peout,nic22_net_ri,r22_dataout_peout,r22_si_pein,r22_ri_pein,r22_datain_pein,nic22_net_polarity,clk,reset);

	nic_mesh nic23 (nic23_addr,nic23_d_in,nic23_d_out,nic23_nicEn,nic23_nicEnWr,r23_so_peout,nic23_net_ri,r23_dataout_peout,r23_si_pein,r23_ri_pein,r23_datain_pein,nic23_net_polarity,clk,reset);

	// Row3
	nic_mesh nic30 (nic30_addr,nic30_d_in,nic30_d_out,nic30_nicEn,nic30_nicEnWr,r30_so_peout,nic30_net_ri,r30_dataout_peout,r30_si_pein,r30_ri_pein,r30_datain_pein,nic30_net_polarity,clk,reset);

	nic_mesh nic31 (nic31_addr,nic31_d_in,nic31_d_out,nic31_nicEn,nic31_nicEnWr,r31_so_peout,nic31_net_ri,r31_dataout_peout,r31_si_pein,r31_ri_pein,r31_datain_pein,nic31_net_polarity,clk,reset);

	nic_mesh nic32 (nic32_addr,nic32_d_in,nic32_d_out,nic32_nicEn,nic32_nicEnWr,r32_so_peout,nic32_net_ri,r32_dataout_peout,r32_si_pein,r32_ri_pein,r32_datain_pein,nic32_net_polarity,clk,reset);

	nic_mesh nic33 (nic33_addr,nic33_d_in,nic33_d_out,nic33_nicEn,nic33_nicEnWr,r33_so_peout,nic33_net_ri,r33_dataout_peout,r33_si_pein,r33_ri_pein,r33_datain_pein,nic33_net_polarity,clk,reset);


//********** ROUTER-ROUTER CONNECTIONS ************//

	// ROW0
	//
	// r00 west and north not connected!

	// East connections
	assign r01_datain_w = r00_dataout_e;
	assign r00_datain_e = r01_dataout_w;

	assign r00_si_e	= r01_so_w; //sending signals
	assign r01_si_w	= r00_so_e; //sending signals

	assign r01_ro_w = r00_ri_e;	//ready signals		// NOTE THE REVERSE
	assign r00_ro_e = r01_ri_w;	//ready signals		// NOTE THE REVERSE

	assign r00_ro_peout = nic00_net_ri;

	// South connections
	assign r10_datain_n = r00_dataout_s;
	assign r10_datain_s = r00_dataout_n;

	assign r10_si_n = r00_so_s; //sending signals
	assign r00_si_s = r10_so_n;	//sending signals

	assign r00_ro_n = r10_ri_s; //ready signals
	assign r00_ro_s = r10_ri_n;	//ready signals

	// r01
	// East connections
	assign r02_datain_w = r01_dataout_e;
	assign r01_datain_e = r02_dataout_w;

	assign r02_si_w = r01_so_e; //sending signals
	assign r01_si_e	= r02_so_w; //sending signals

	assign r02_ro_w = r01_ri_e;	//ready signals	// NOTE THE REVERSE
	assign r01_ro_e = r02_ri_w; //ready signals

	assign r01_ro_peout = nic01_net_ri;

	// South connections
	assign r11_datain_n = r01_dataout_s;
	assign r11_datain_s = r01_dataout_n;

	assign r11_si_n = r01_so_s; //sending signals
	assign r01_si_s = r11_so_n; //sending signals

	assign r01_ro_n = r11_ri_s; //ready signals
	assign r01_ro_s = r11_ri_n; //ready signals

	// r02
	// East connections

	assign r03_si_w = r02_so_e; //sending signals
	assign r02_si_e	= r03_so_w; //sending signals

	assign r02_ro_e = r03_ri_w; //ready signals
	assign r03_ro_w = r02_ri_e;	//ready signals			// NOTE THE REVERSE

	assign r02_ro_peout = nic02_net_ri;

	assign r03_datain_w = r02_dataout_e;
	assign r02_datain_e = r03_dataout_w;

	// South connections

	assign r12_si_n = r02_so_s; //sending signals
	assign r02_si_s = r12_so_n; //sending signals

	assign r12_datain_s = r02_dataout_n;
	assign r12_datain_n = r02_dataout_s;

	assign r02_ro_s = r12_ri_n; //ready signals
	assign r02_ro_n = r12_ri_s; //ready signals

	// r03
	// South connections
	assign r13_si_n = r03_si_s; //sending signals
	assign r03_si_s = r13_so_n; //sending signals

	assign r13_datain_s = r03_dataout_n;
	assign r13_datain_n = r03_dataout_s;

	assign r03_ro_n = r13_ri_s; //ready signals
	assign r03_ro_s = r13_ri_n; //ready signals

	assign r03_ro_peout = nic03_net_ri;

	// ROW1
	//
	// r10
	// East connections

	assign r10_ro_e = r11_ri_w; //ready signals			// NOTE THE REVERSE
	assign r11_ro_w = r10_ri_e;	//ready signals			// NOTE THE REVERSE

	assign r10_datain_e = r11_dataout_w;
	assign r11_datain_w = r10_dataout_e;

	assign r10_si_e	= r11_so_w; //sending signals
	assign r11_si_w	= r10_so_e; //sending signals

	assign r10_ro_peout = nic10_net_ri;

	// South connections

	assign r20_si_n = r10_so_s; //sending signals
	assign r10_si_s = r20_so_n; //sending signals

	assign r20_datain_s = r10_dataout_n;
	assign r20_datain_n = r10_dataout_s;

	assign r10_ro_s = r20_ri_n; //ready signals
	assign r10_ro_n = r20_ri_s; //ready signals

	// r11
	// East connections

	assign r12_si_w = r11_so_e; //sending signals
	assign r11_si_e	= r12_so_w; //sending signals

	assign r11_datain_e = r12_dataout_w; //ready signals
	assign r12_datain_w = r11_dataout_e; //ready signals

	assign r12_ro_w = r11_ri_e; //ready signals				// NOTE THE REVERSE
	assign r11_ro_e = r12_ri_w; //ready signals

	assign r11_ro_peout = nic11_net_ri;

	// South connections

	assign r21_si_n = r11_si_s; //sending signals
	assign r11_si_s = r21_si_n; //sending signals

	assign r21_datain_s = r11_dataout_n;
	assign r21_datain_n = r11_dataout_s;

	assign r11_ro_n = r21_ri_s; //ready signals
	assign r11_ro_s = r21_ri_n; //ready signals

	// r12
	// East connections

	assign r13_si_w = r12_so_e;
	assign r12_si_e	= r13_so_w;

	assign r12_datain_e = r13_dataout_w;
	assign r13_datain_w = r12_dataout_e;

	assign r13_ro_w = r12_ri_e;	//ready signals			// NOTE THE REVERSE
	assign r12_ro_e = r13_ri_w; //ready signals

	assign r12_ro_peout = nic12_net_ri;

	// South connections

	assign r22_si_n = r12_so_s;
	assign r12_si_s = r22_so_n;

	assign r22_datain_s = r12_dataout_n;
	assign r22_datain_n = r12_dataout_s;

	assign r12_ro_n = r22_ri_s; //ready signals
	assign r12_ro_s = r22_ri_n; //ready signals

	// r13
	// South connections

	assign r23_si_n = r13_so_s;
	assign r13_si_s = r23_so_n;

	assign r23_datain_s = r13_dataout_n;
	assign r23_datain_n = r13_dataout_s;

	assign r13_ro_n = r23_ri_s; //ready signals
	assign r13_ro_s = r23_ri_n; //ready signals

	assign r13_ro_peout = nic13_net_ri;

	// Row2
	//
	// r20
	// East connections

	assign r21_si_w	= r20_so_e;
	assign r20_si_e	= r21_so_w;

	assign r21_ro_w = r20_ri_e;				// NOTE THE REVERSE
	assign r20_ro_e = r21_ri_w;				// NOTE THE REVERSE

	assign r20_datain_e = r21_dataout_w;
	assign r21_datain_w = r20_dataout_e;

	assign r20_ro_peout = nic20_net_ri;

	// South connections

	assign r20_ro_n = r30_ri_s; //ready signals
	assign r20_ro_s = r30_ri_n; //ready signals

	assign r30_datain_s = r20_dataout_n;
	assign r30_datain_n = r20_dataout_s;

	assign r20_si_s = r30_so_n;
	assign r30_si_n = r20_so_s;

	// r21
	// East connections

	assign r22_si_w = r21_so_e;
	assign r21_si_e	= r22_so_w;

	assign r21_datain_e = r22_dataout_w;
	assign r22_datain_w = r21_dataout_e;

	assign r22_ro_w = r21_ri_e; //ready signals				// NOTE THE REVERSE
	assign r21_ro_e = r22_ri_w; //ready signals

	assign r21_ro_peout = nic21_net_ri;

	// South connections

	assign r31_si_n = r21_so_s;
	assign r21_si_s = r31_so_n;

	assign r31_datain_s = r21_dataout_n;
	assign r31_datain_n = r21_dataout_s;

	assign r21_ro_n = r31_ri_s; //ready signals
	assign r21_ro_s = r31_ri_n; //ready signals

	// r22
	// East connections

	assign r23_si_w = r22_so_e;
	assign r22_si_e	= r23_so_w;

	assign r22_datain_e = r23_dataout_w;
	assign r23_datain_w = r22_dataout_e;

	assign r23_ro_w = r22_ri_e;	//ready signals			// NOTE THE REVERSE
	assign r22_ro_e = r23_ri_w; //ready signals

	assign r22_ro_peout = nic22_net_ri;

	// South connections

	assign r32_si_n = r22_so_s;
	assign r22_si_s = r32_so_n;

	assign r32_datain_s = r22_dataout_n;
	assign r32_datain_n = r22_dataout_s;

	assign r22_ro_n = r32_ri_s; //ready signals
	assign r22_ro_s = r32_ri_n; //ready signals

	// r23
	// South connections

	assign r33_si_n = r23_so_s;
	assign r23_si_s = r33_so_n;

	assign r33_datain_s = r23_dataout_n;
	assign r33_datain_n = r23_dataout_s;

	assign r23_ro_n = r33_ri_s; //ready signals
	assign r23_ro_s = r33_ri_n; //ready signals

	assign r23_ro_peout = nic23_net_ri;

	// Row3
	//
	// r30
	// East connections

	assign r30_ro_e = r31_ri_w; //ready signals			// NOTE THE REVERSE
	assign r31_ro_w = r30_ri_e;	//ready signals			// NOTE THE REVERSE

	assign r30_datain_e = r31_dataout_w;
	assign r31_datain_w = r30_dataout_e;

	assign r30_si_e	= r31_so_w;
	assign r31_si_w	= r30_so_e;

	assign r30_ro_peout = nic30_net_ri;

	// r31
	// East connections

	assign r32_si_w = r31_so_e;
	assign r31_si_e	= r32_so_w;

	assign r31_datain_e = r32_dataout_w;
	assign r32_datain_w = r31_dataout_e;

	assign r32_ro_w = r31_ri_e;	//ready signals	// NOTE THE REVERSE
	assign r31_ro_e = r32_ri_w; //ready signals

	assign r31_ro_peout = nic31_net_ri;

	// r32
	// East connections

	assign r33_si_w = r32_so_e;
	assign r32_si_e	= r33_so_w;

	assign r32_datain_e = r33_dataout_w;
	assign r33_datain_w = r32_dataout_e;

	assign r33_ro_w = r32_ri_e;	//ready signals			// NOTE THE REVERSE
	assign r32_ro_e = r33_ri_w; //ready signals

	assign r32_ro_peout = nic32_net_ri;

	//r33 all connections already there! :)
	assign r33_ro_peout = nic33_net_ri;

//********** ROUTER-NIC CONNECTIONS ************//









endmodule
