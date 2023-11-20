
`timescale 1ns / 100ps
module nictb;
	reg [0:1] addr_tb;
	reg [0:63] d_in_tb;
	reg net_polarity_tb;
	reg clk_tb;
	reg reset_tb;
	reg nicEn_tb;
	reg nicEnWr_tb;
	reg net_si_tb;
	reg [0:63] net_di_tb;
	reg net_ro_tb;
	wire net_so_tb;
	wire net_ri_tb;
	wire [0:63] d_out_tb;
	wire [0:63] net_do_tb;

nic_mesh n1 (.addr(addr_tb),.d_in(d_in_tb),
			 .net_polarity(net_polarity_tb),
			 .clk(clk_tb),.reset(reset_tb),
			 .nicEn(nicEn_tb),.nicEnWr(nicEnWr_tb),
			 .net_si(net_si_tb),.net_di(net_di_tb),
			 .net_ro(net_ro_tb),.net_so(net_so_tb),
			 .net_ri(net_ri_tb),.d_out(d_out_tb),
			 .net_do_rev(net_do_tb)
	);

initial begin
	//initialize and reset
	clk_tb=1'b1;reset_tb=1'b1;
	addr_tb =2'b00; d_in_tb=64'b0; nicEn_tb=1'b0; nicEnWr_tb=1'b0;
	net_ro_tb=1'b0; net_polarity_tb=1'b0; net_si_tb=1'b0; net_di_tb=64'b0;
	#20;
	reset_tb=1'b0;
	@(negedge clk_tb);
	//Write to output channel buffer
	addr_tb =2'b10; d_in_tb=64'd32; nicEn_tb=1'b1; nicEnWr_tb=1'b1;
	net_ro_tb=1'b0; net_polarity_tb=1'b0; net_si_tb=1'b0; net_di_tb=64'b0;
	@(negedge clk_tb);
	// read by processor
	addr_tb =2'b10; d_in_tb=64'd32; nicEn_tb=1'b1; nicEnWr_tb=1'b0;
	net_ro_tb=1'b0; net_polarity_tb=1'b0; net_si_tb=1'b0; net_di_tb=64'b0;
	@(negedge clk_tb);
	// read by router
	addr_tb =2'b10; d_in_tb=64'd32; nicEn_tb=1'b0; nicEnWr_tb=1'b0;
	net_ro_tb=1'b1; net_polarity_tb=1'b0; net_si_tb=1'b0; net_di_tb=64'b0;
	@(negedge clk_tb);
	// read by processor
	addr_tb =2'b10; d_in_tb=64'd32; nicEn_tb=1'b1; nicEnWr_tb=1'b0;
	net_ro_tb=1'b0; net_polarity_tb=1'b0; net_si_tb=1'b0; net_di_tb=64'b0;
	//read by router
	@(negedge clk_tb);
	addr_tb =2'b10; d_in_tb=64'd32; nicEn_tb=1'b0; nicEnWr_tb=1'b0;
	net_ro_tb=1'b1; net_polarity_tb=1'b0; net_si_tb=1'b0; net_di_tb=64'b0;
	// write by router
	@(negedge clk_tb);
	addr_tb =2'b10; d_in_tb=64'd32; nicEn_tb=1'b0; nicEnWr_tb=1'b0;
	net_ro_tb=1'b0; net_polarity_tb=1'b0; net_si_tb=1'b1; net_di_tb=64'd132;
	//Write to output channel buffer
	@(negedge clk_tb);
	addr_tb =2'b10; d_in_tb=64'd66; nicEn_tb=1'b1; nicEnWr_tb=1'b1;
	net_ro_tb=1'b0; net_polarity_tb=1'b0; net_si_tb=1'b0; net_di_tb=64'b0;
	//write to out buffer as well as read out
	@(negedge clk_tb);
	addr_tb =2'b10; d_in_tb=64'd11; nicEn_tb=1'b1; nicEnWr_tb=1'b1;
	net_ro_tb=1'b1; net_polarity_tb=1'b1; net_si_tb=1'b0; net_di_tb=64'b0;
	#10;
	$finish;
end

always begin
	#4 clk_tb = ~ clk_tb;
end
endmodule