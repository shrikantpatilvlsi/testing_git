
`timescale 1ns / 100ps
module tb;
	parameter PKTWIDTH=64;
	reg tb_clk;
	reg tb_reset;
	wire tb_polarity;

	reg [PKTWIDTH-1:0] Edin;
	reg [PKTWIDTH-1:0] Ndin;
	reg [PKTWIDTH-1:0] Wdin;
	reg [PKTWIDTH-1:0] Sdin;
	reg [PKTWIDTH-1:0] Pdin;

	wire [PKTWIDTH-1:0] Edout;
	wire [PKTWIDTH-1:0] Ndout;
	wire [PKTWIDTH-1:0] Sdout;
	wire [PKTWIDTH-1:0] Wdout;
	wire [PKTWIDTH-1:0] Pdout;

	reg Nro;
	reg Wro;
	reg Ero;
	reg Sro;
	reg Pro;

	wire Nri;
	wire Wri;
	wire Eri;
	wire Sri;
	wire Pri;

	wire Nso;
	wire Eso;
	wire Wso;
	wire Sso;
	wire Pso;

	reg Nsi;
	reg Esi;
	reg Wsi;
	reg Ssi;
	reg Psi;


	mesh_router m1(.clk(tb_clk),.polarity(tb_polarity),.reset(tb_reset),
			.datain_east(Edin),.datain_north(Ndin),.datain_pein(Pdin),.datain_south(Sdin),.datain_west(Wdin),
			.dataout_east(Edout),.dataout_north(Ndout),.dataout_peout(Pdout),.dataout_south(Sdout),.dataout_west(Wdout),
			.ri_east(Eri),.ri_north(Nri),.ri_pein(Pri),.ri_south(Sri),.ri_west(Wri),
			.ro_east(Ero),.ro_north(Nro),.ro_peout(Pro),.ro_south(Sro),.ro_west(Wro),
			.si_east(Esi),.si_north(Nsi),.si_pein(Psi),.si_south(Ssi),.si_west(Wsi),
			.so_east(Eso),.so_north(Nso),.so_peout(Pso),.so_south(Sso),.so_west(Wso));

	initial begin
                  tb_clk=1'b0; tb_reset=1'b1;
                  Edin=64'b0; Ndin=64'b0; Wdin=64'b0; Sdin=64'b0; Pdin=64'b0;
                  Nro=1'b0; Wro=1'b0; Ero=1'b0; Sro=1'b0; Pro=1'b0;
                  Nsi=1'b0; Esi=1'b0; Wsi=1'b0; Ssi=1'b0; Psi=1'b0;
                  @(posedge tb_clk);
                  @(posedge tb_clk);
                  tb_reset=1'b1;
                  @(posedge tb_clk);
                  tb_reset=1'b0;
                  //from North to PE
                  Edin=64'b0; Ndin=64'd0; Wdin=64'd0; Sdin=64'd0; Pdin=64'd0;
                  Nro=1'b0; Wro=1'b0; Ero=1'b0; Sro=1'b0; Pro=1'b0;
                  Nsi=1'b0; Esi=1'b0; Wsi=1'b0; Ssi=1'b0; Psi=1'b0;
                  @(posedge tb_clk);
				  Edin=64'd25; Ndin=64'd09; Wdin=64'd36; Sdin=64'd12; Pdin=64'd88;
                  Nro=1'b0; Wro=1'b0; Ero=1'b0; Sro=1'b0; Pro=1'b0;
                  Nsi=1'b0; Esi=1'b0; Wsi=1'b0; Ssi=1'b0; Psi=1'b0;
                  repeat(10) begin
                  	@(posedge tb_clk);
                  end
                  //Congestion testing
                  Edin=64'h2001DDDDAAAAAAAA; Ndin=64'h2001BBBBCCCCCCCC; Wdin=64'd36; Sdin=64'd12; Pdin=64'd88;
                  Nro=1'b0; Wro=1'b0; Ero=1'b0; Sro=1'b0; Pro=1'b0;
                  Nsi=1'b1; Esi=1'b1; Wsi=1'b0; Ssi=1'b0; Psi=1'b0;
                  @(posedge tb_clk);
                  Edin=64'h2001DDDDAAAAAAAA; Ndin=64'h2001BBBBCCCCCCCC; Wdin=64'd36; Sdin=64'd12; Pdin=64'd88;
                  Nro=1'b0; Wro=1'b0; Ero=1'b0; Sro=1'b0; Pro=1'b0;
                  Nsi=1'b0; Esi=1'b0; Wsi=1'b0; Ssi=1'b0; Psi=1'b0;
                  @(posedge tb_clk);
                  Edin=64'h2001DDDDAAAAAAAA; Ndin=64'h2001BBBBCCCCCCCC; Wdin=64'd36; Sdin=64'd12; Pdin=64'd88;
                  Nro=1'b0; Wro=1'b0; Ero=1'b0; Sro=1'b1; Pro=1'b0;
                  Nsi=1'b0; Esi=1'b0; Wsi=1'b0; Ssi=1'b0; Psi=1'b0;
                  @(posedge tb_clk);
                  @(posedge tb_clk);
                  Edin=64'h2001DDDDAAAAAAAA; Ndin=64'h2001BBBBCCCCCCCC; Wdin=64'd36; Sdin=64'd12; Pdin=64'd88;
                  Nro=1'b0; Wro=1'b0; Ero=1'b0; Sro=1'b1; Pro=1'b0;
                  Nsi=1'b0; Esi=1'b0; Wsi=1'b0; Ssi=1'b0; Psi=1'b0;
                  @(posedge tb_clk);
                  @(posedge tb_clk);

                  repeat(10) begin
                  	@(posedge tb_clk);
                  end
                  $finish;

	end
	always begin
		#4 tb_clk = ~tb_clk;
	end
endmodule