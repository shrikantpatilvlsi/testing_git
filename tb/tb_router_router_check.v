

`timescale 1ns / 100ps
module tb;
	parameter PKTWIDTH=64;
	reg tb_clk;
	reg tb_reset;

	reg [(PKTWIDTH-1):0] tb_r00_datain_pein;
	reg tb_r00_si_pein;
	router_router r1(.clk(tb_clk),.r00_datain_pein(tb_r00_datain_pein),.r00_si_pein(tb_r00_si_pein),.reset(tb_reset));
	initial begin
                  tb_clk=1'b0; tb_reset=1'b1;
                  @(posedge tb_clk);
                  @(posedge tb_clk);
                  tb_reset=1'b0;
                  @(posedge tb_clk);
                  tb_r00_datain_pein = 64'h2010DDDDAAAAAAAA;
				  tb_r00_si_pein = 1'b1;
				  @(posedge tb_clk);
				  tb_r00_si_pein = 1'b0;
                  repeat(10) begin
                  	@(posedge tb_clk);
                  end
                  $finish;

	end
	always begin
		#4 tb_clk = ~tb_clk;
	end
endmodule