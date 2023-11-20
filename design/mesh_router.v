// Mesh NOC Router
// Group1
// Last Updated: 10/23/2023
// naming convenstion - element_even/odd_direction

module mesh_router #(parameter PKTWIDTH = 64)
					(dataout_north, dataout_east, dataout_south, dataout_west, dataout_peout,
					 so_north, so_east, so_south, so_west, so_peout,
					 ri_north, ri_east, ri_south, ri_west, ri_pein,
					 datain_north, datain_east, datain_south, datain_west, datain_pein,
					 si_north, si_east, si_south, si_west, si_pein,
					 ro_north, ro_east, ro_south, ro_west, ro_peout,
					 polarity, reset, clk);

	parameter PRIOWIDTH = 4;

	output reg [(PKTWIDTH - 1) : 0] dataout_north, dataout_east, dataout_south, dataout_west, dataout_peout;
	output reg so_north, so_east, so_south, so_west, so_peout;
	output reg ri_north, ri_east, ri_south, ri_west, ri_pein;
	output reg polarity;

	input  [(PKTWIDTH - 1) : 0] datain_north, datain_east, datain_south, datain_west, datain_pein;
	input si_north, si_east, si_south, si_west, si_pein;
	input ro_north, ro_east, ro_south, ro_west, ro_peout;
	input reset; // The global synchronous reset
	input clk;	// The system clk


	wire reqnorth_n, reqeast_n, reqsouth_n, reqwest_n, reqpeout_n;
	reg inpbufisfull_n;
	reg [3:0] xhop_n;
	reg [3:0] yhop_n;
	reg xdir_n, ydir_n;

	wire reqnorth_e, reqeast_e, reqsouth_e, reqwest_e, reqpeout_e;
	reg inpbufisfull_e;
	reg [3:0] xhop_e;
	reg [3:0] yhop_e;
	reg xdir_e, ydir_e;

	wire reqnorth_s, reqeast_s, reqsouth_s, reqwest_s, reqpeout_s;
	reg inpbufisfull_s;
	reg [3:0] xhop_s;
	reg [3:0] yhop_s;
	reg xdir_s, ydir_s;

	wire reqnorth_w, reqeast_w, reqsouth_w, reqwest_w, reqpeout_w;
	reg inpbufisfull_w;
    reg [3:0] xhop_w;
	reg [3:0] yhop_w;
	reg xdir_w, ydir_w;

	wire reqnorth_pein, reqeast_pein, reqsouth_pein, reqwest_pein, reqpeout_pein;
	reg inpbufisfull_pein;
	reg [3:0] xhop_pein;
	reg [3:0] yhop_pein;
	reg xdir_pein, ydir_pein;


	reg ipbufnorth_isfull;
	reg ipbufeast_isfull;
	reg ipbufsouth_isfull;
	reg ipbufwest_isfull;
	reg ipbufpein_isfull;

	wire ipbufnorth_flag;
	wire ipbufeast_flag;
	wire ipbufsouth_flag;
	wire ipbufwest_flag;
	wire ipbufpein_flag;


	reg opbufisfull_n;
	reg opbufisfull_e;
	reg opbufisfull_s;
	reg opbufisfull_w;
	reg opbufisfull_peout;

	reg [(PKTWIDTH - 1) : 0]internalforward_north;
	reg [(PKTWIDTH - 1) : 0]internalforward_east;
	reg [(PKTWIDTH - 1) : 0]internalforward_south;
	reg [(PKTWIDTH - 1) : 0]internalforward_west;
	reg [(PKTWIDTH - 1) : 0]internalforward_pein;

	reg [(PKTWIDTH - 1) : 0] opbufnorth_in;
	reg [(PKTWIDTH - 1) : 0] opbufeast_in;
	reg [(PKTWIDTH - 1) : 0] opbufsouth_in;
	reg [(PKTWIDTH - 1) : 0] opbufwest_in;
	reg [(PKTWIDTH - 1) : 0] opbufpeout_in;

	//grant signals
	wire opbufnorth_grants;
	wire opbufeast_grants;
	wire opbufsouth_grants;
	wire opbufwest_grants;
	wire opbufpeout_grants;

//***************** BUFFERS ********************//

	// NOTE: Half of these buffer ins and outs might become inputs/ouputs
	// Inputs of the ipbufs would be router's inputs
	// Outputs of the opbufs would be router's outputs
	// Rest would be internal wires

	// North port wires
	wire [(PKTWIDTH - 1) : 0] ipbufevennorth_out;
	wire [(PKTWIDTH - 1) : 0] ipbufevennorth_in;
	wire [(PKTWIDTH - 1) : 0] ipbufoddnorth_out;
	wire [(PKTWIDTH - 1) : 0] ipbufoddnorth_in;
	wire ipbufevennorth_isfull;
	reg ipbufevennorth_writeen;
	reg ipbufevennorth_flag;
	wire ipbufoddnorth_isfull;
	reg ipbufoddnorth_writeen;
	reg ipbufoddnorth_flag;
	wire [(PKTWIDTH - 1) : 0] opbufevennorth_out;
	wire [(PKTWIDTH - 1) : 0] opbufevennorth_in;
	wire [(PKTWIDTH - 1) : 0] opbufoddnorth_out;
	wire [(PKTWIDTH - 1) : 0] opbufoddnorth_in;
	wire opbufevennorth_isfull;
	reg opbufevennorth_writeen;
	reg opbufevennorth_flag;
	wire opbufoddnorth_isfull;
	reg opbufoddnorth_writeen;
	reg opbufoddnorth_flag;

	// East port wires
	wire [(PKTWIDTH - 1) : 0] ipbufeveneast_out;
	wire [(PKTWIDTH - 1) : 0] ipbufeveneast_in;
	wire [(PKTWIDTH - 1) : 0] ipbufoddeast_out;
	wire [(PKTWIDTH - 1) : 0] ipbufoddeast_in;
	wire ipbufeveneast_isfull;
	reg ipbufeveneast_writeen;
	reg ipbufeveneast_flag;
	wire ipbufoddeast_isfull;
	reg ipbufoddeast_writeen;
	reg ipbufoddeast_flag;
	wire [(PKTWIDTH - 1) : 0] opbufeveneast_out;
	wire [(PKTWIDTH - 1) : 0] opbufeveneast_in;
	wire [(PKTWIDTH - 1) : 0] opbufoddeast_out;
	wire [(PKTWIDTH - 1) : 0] opbufoddeast_in;
	wire opbufeveneast_isfull;
	reg opbufeveneast_writeen;
	reg opbufeveneast_flag;
	wire opbufoddeast_isfull;
	reg opbufoddeast_writeen;
	reg opbufoddeast_flag;

	// South port wires
	wire [(PKTWIDTH - 1) : 0] ipbufevensouth_out;
	wire [(PKTWIDTH - 1) : 0] ipbufevensouth_in;
	wire [(PKTWIDTH - 1) : 0] ipbufoddsouth_out;
	wire [(PKTWIDTH - 1) : 0] ipbufoddsouth_in;
	wire ipbufevensouth_isfull;
	reg ipbufevensouth_writeen;
	reg ipbufevensouth_flag;
	wire ipbufoddsouth_isfull;
	reg ipbufoddsouth_writeen;
	reg ipbufoddsouth_flag;
	wire [(PKTWIDTH - 1) : 0] opbufevensouth_out;
	wire [(PKTWIDTH - 1) : 0] opbufevensouth_in;
	wire [(PKTWIDTH - 1) : 0] opbufoddsouth_out;
	wire [(PKTWIDTH - 1) : 0] opbufoddsouth_in;
	wire opbufevensouth_isfull;
	reg opbufevensouth_writeen;
	reg opbufevensouth_flag;
	wire opbufoddsouth_isfull;
	reg opbufoddsouth_writeen;
	reg opbufoddsouth_flag;

	// West port wires
	wire [(PKTWIDTH - 1) : 0] ipbufevenwest_out;
	wire [(PKTWIDTH - 1) : 0] ipbufevenwest_in;
	wire [(PKTWIDTH - 1) : 0] ipbufoddwest_out;
	wire [(PKTWIDTH - 1) : 0] ipbufoddwest_in;
	wire ipbufevenwest_isfull;
	reg ipbufevenwest_writeen;
	reg ipbufevenwest_flag;
	wire ipbufoddwest_isfull;
	reg ipbufoddwest_writeen;
	reg ipbufoddwest_flag;
	wire [(PKTWIDTH - 1) : 0] opbufevenwest_out;
	wire [(PKTWIDTH - 1) : 0] opbufevenwest_in;
	wire [(PKTWIDTH - 1) : 0] opbufoddwest_out;
	wire [(PKTWIDTH - 1) : 0] opbufoddwest_in;
	wire opbufevenwest_isfull;
	reg opbufevenwest_writeen;
	reg opbufevenwest_flag;
	wire opbufoddwest_isfull;
	reg opbufoddwest_writeen;
	reg opbufoddwest_flag;

	// Pein port wires
	wire [(PKTWIDTH - 1) : 0] ipbufevenpein_out;
	wire [(PKTWIDTH - 1) : 0] ipbufevenpein_in;
	wire [(PKTWIDTH - 1) : 0] ipbufoddpein_out;
	wire [(PKTWIDTH - 1) : 0] ipbufoddpein_in;
	wire ipbufevenpein_isfull;
	reg ipbufevenpein_writeen;
	reg ipbufevenpein_flag;
	wire ipbufoddpein_isfull;
	reg ipbufoddpein_writeen;
	reg ipbufoddpein_flag;

	// Peout port wires
	wire [(PKTWIDTH - 1) : 0] opbufevenpeout_out;
	wire [(PKTWIDTH - 1) : 0] opbufevenpeout_in;
	wire [(PKTWIDTH - 1) : 0] opbufoddpeout_out;
	wire [(PKTWIDTH - 1) : 0] opbufoddpeout_in;
	wire opbufevenpeout_isfull;
	reg opbufevenpeout_writeen;
	reg opbufevenpeout_flag;
	wire opbufoddpeout_isfull;
	reg opbufoddpeout_writeen;
	reg opbufoddpeout_flag;


	assign ipbufevennorth_in = datain_north;
	assign ipbufoddnorth_in  = datain_north;
	assign ipbufeveneast_in = datain_east;
	assign ipbufoddeast_in  = datain_east;
	assign ipbufevensouth_in = datain_south;
	assign ipbufoddsouth_in  = datain_south;
	assign ipbufevenwest_in = datain_west;
	assign ipbufoddwest_in  = datain_west;
	assign ipbufevenpein_in = datain_pein;
	assign ipbufoddpein_in  = datain_pein;



	// North Port
	channel_buffer #(.WIDTH(PKTWIDTH)) ipbuf_even_north (ipbufevennorth_out,  ipbufevennorth_isfull,
														 ipbufevennorth_in,   ipbufevennorth_writeen,
														 ipbufevennorth_flag, reset, clk);
	channel_buffer #(.WIDTH(PKTWIDTH)) ipbuf_odd_north  (ipbufoddnorth_out,   ipbufoddnorth_isfull,
														 ipbufoddnorth_in,    ipbufoddnorth_writeen,
														 ipbufoddnorth_flag,  reset, clk);
	channel_buffer #(.WIDTH(PKTWIDTH)) opbuf_even_north (opbufevennorth_out,  opbufevennorth_isfull,
														 opbufevennorth_in,   opbufevennorth_writeen,
														 opbufevennorth_flag, reset, clk);
	channel_buffer #(.WIDTH(PKTWIDTH)) opbuf_odd_north  (opbufoddnorth_out,   opbufoddnorth_isfull,
														 opbufoddnorth_in,    opbufoddnorth_writeen,
														 opbufoddnorth_flag,  reset, clk);

	// East Port
	channel_buffer #(.WIDTH(PKTWIDTH)) ipbuf_even_east (ipbufeveneast_out,  ipbufeveneast_isfull,
														ipbufeveneast_in,   ipbufeveneast_writeen,
														ipbufeveneast_flag, reset, clk);
	channel_buffer #(.WIDTH(PKTWIDTH)) ipbuf_odd_east  (ipbufoddeast_out,   ipbufoddeast_isfull,
														ipbufoddeast_in,    ipbufoddeast_writeen,
														ipbufoddeast_flag,  reset, clk);
	channel_buffer #(.WIDTH(PKTWIDTH)) opbuf_even_east (opbufeveneast_out,  opbufeveneast_isfull,
														opbufeveneast_in,   opbufeveneast_writeen,
														opbufeveneast_flag, reset, clk);
	channel_buffer #(.WIDTH(PKTWIDTH)) opbuf_odd_east  (opbufoddeast_out,   opbufoddeast_isfull,
														opbufoddeast_in,    opbufoddeast_writeen,
														opbufoddeast_flag,  reset, clk);

	// South Port
	channel_buffer #(.WIDTH(PKTWIDTH)) ipbuf_even_south (ipbufevensouth_out,  ipbufevensouth_isfull,
														 ipbufevensouth_in,   ipbufevensouth_writeen,
														 ipbufevensouth_flag, reset, clk);
	channel_buffer #(.WIDTH(PKTWIDTH)) ipbuf_odd_south  (ipbufoddsouth_out,   ipbufoddsouth_isfull,
														 ipbufoddsouth_in,    ipbufoddsouth_writeen,
														 ipbufoddsouth_flag,  reset, clk);
	channel_buffer #(.WIDTH(PKTWIDTH)) opbuf_even_south (opbufevensouth_out,  opbufevensouth_isfull,
														 opbufevensouth_in,   opbufevensouth_writeen,
														 opbufevensouth_flag, reset, clk);
	channel_buffer #(.WIDTH(PKTWIDTH)) opbuf_odd_south  (opbufoddsouth_out,   opbufoddsouth_isfull,
														 opbufoddsouth_in,    opbufoddsouth_writeen,
														 opbufoddsouth_flag,  reset, clk);

	// West Port
	channel_buffer #(.WIDTH(PKTWIDTH)) ipbuf_even_west (ipbufevenwest_out,  ipbufevenwest_isfull,
														ipbufevenwest_in,   ipbufevenwest_writeen,
														ipbufevenwest_flag, reset, clk);
	channel_buffer #(.WIDTH(PKTWIDTH)) ipbuf_odd_west  (ipbufoddwest_out,   ipbufoddwest_isfull,
														ipbufoddwest_in,    ipbufoddwest_writeen,
														ipbufoddwest_flag,  reset, clk);
	channel_buffer #(.WIDTH(PKTWIDTH)) opbuf_even_west (opbufevenwest_out,  opbufevenwest_isfull,
														opbufevenwest_in,   opbufevenwest_writeen,
														opbufevenwest_flag, reset, clk);
	channel_buffer #(.WIDTH(PKTWIDTH)) opbuf_odd_west  (opbufoddwest_out,   opbufoddwest_isfull,
														opbufoddwest_in,    opbufoddwest_writeen,
														opbufoddwest_flag,  reset, clk);

	// PE Input Port
	channel_buffer #(.WIDTH(PKTWIDTH)) ipbuf_even_pe (ipbufevenpein_out,  ipbufevenpein_isfull,
													  ipbufevenpein_in,   ipbufevenpein_writeen,
													  ipbufevenpein_flag, reset, clk);
	channel_buffer #(.WIDTH(PKTWIDTH)) ipbuf_odd_pe  (ipbufoddpein_out,   ipbufoddpein_isfull,
													  ipbufoddpein_in,    ipbufoddpein_writeen,
													  ipbufoddpein_flag,  reset, clk);

	// PE Output Port
	channel_buffer #(.WIDTH(PKTWIDTH)) opbuf_even_pe (opbufevenpeout_out,  opbufevenpeout_isfull,
													  opbufevenpeout_in,   opbufevenpeout_writeen,
													  opbufevenpeout_flag, reset, clk);
	channel_buffer #(.WIDTH(PKTWIDTH)) opbuf_odd_pe  (opbufoddpeout_out,   opbufoddpeout_isfull,
													  opbufoddpeout_in,    opbufoddpeout_writeen,
													  opbufoddpeout_flag,  reset, clk);


//************** GENERATING RI SIGNALS ************//
	always @* begin
		if (polarity) begin
			ri_north = ~ipbufevennorth_isfull;
			ri_east  = ~ipbufeveneast_isfull;
			ri_south = ~ipbufevensouth_isfull;
			ri_west  = ~ipbufevenwest_isfull;
			ri_pein  = ~ipbufevenpein_isfull;
		end
		else begin
			ri_north = ~ipbufoddnorth_isfull;
			ri_east  = ~ipbufoddeast_isfull;
			ri_south = ~ipbufoddsouth_isfull;
			ri_west  = ~ipbufoddwest_isfull;
			ri_pein  = ~ipbufoddpein_isfull;
		end
	end


//******** INPUT CONTROLS FOR INPUT BUFFERS *******//

	wire ipbufsouth_north_chosen, ipbufeast_north_chosen, ipbufwest_north_chosen,
	ipbufpein_north_chosen;

	wire ipbufwest_east_chosen, ipbufsouth_east_chosen, ipbufnorth_east_chosen,
	ipbufpein_east_chosen;

	wire ipbufnorth_south_chosen, ipbufwest_south_chosen, ipbufeast_south_chosen,
	ipbufpein_south_chosen;

	wire ipbufeast_west_chosen, ipbufnorth_west_chosen, ipbufsouth_west_chosen,
	ipbufpein_west_chosen;

	wire ipbufnorth_peout_chosen, ipbufeast_peout_chosen, ipbufsouth_peout_chosen,
	ipbufwest_peout_chosen;

	wire ipbufsouth_chosen;
	wire ipbufnorth_chosen;
	wire ipbufeast_chosen;
	wire ipbufwest_chosen;
	wire ipbufpein_chosen;

	wire ipbufnorth_sending;
	wire ipbufsouth_sending;
	wire ipbufeast_sending;
	wire ipbufwest_sending;
	wire ipbufpein_sending;


	wire ipbufnorth_writeen;
	wire ipbufeast_writeen;
	wire ipbufsouth_writeen;
	wire ipbufwest_writeen;
	wire ipbufpein_writeen;
// Only 1 ipcontrol for 1 port
// Based on the polarity, you select the signals that should get into the
// control and into the buffer from the control

	// Outputs demuxing
	always @* begin
		if (~polarity) begin
			ipbufoddnorth_writeen  = ipbufnorth_writeen;
			ipbufoddeast_writeen   = ipbufeast_writeen;
			ipbufoddsouth_writeen  = ipbufsouth_writeen;
			ipbufoddwest_writeen   = ipbufwest_writeen;
			ipbufoddpein_writeen   = ipbufpein_writeen;

			ipbufevennorth_writeen = 0;
			ipbufeveneast_writeen  = 0;
			ipbufevensouth_writeen = 0;
			ipbufevenwest_writeen  = 0;
			ipbufevenpein_writeen  = 0;
		end
		else begin
			ipbufoddnorth_writeen  = 0;
			ipbufoddeast_writeen   = 0;
			ipbufoddsouth_writeen  = 0;
			ipbufoddwest_writeen   = 0;
			ipbufoddpein_writeen   = 0;

			ipbufevennorth_writeen = ipbufnorth_writeen;
			ipbufeveneast_writeen  = ipbufeast_writeen;
			ipbufevensouth_writeen = ipbufsouth_writeen;
			ipbufevenwest_writeen  = ipbufwest_writeen;
			ipbufevenpein_writeen  = ipbufpein_writeen;
		end
	end

	// INPUTS MUXing
	always @* begin
		if (~polarity) begin
			ipbufnorth_isfull = ipbufoddnorth_isfull;
			ipbufeast_isfull  = ipbufoddeast_isfull;
			ipbufsouth_isfull = ipbufoddsouth_isfull;
			ipbufwest_isfull  = ipbufoddwest_isfull;
			ipbufpein_isfull  = ipbufoddpein_isfull;
		end
		else begin
			ipbufnorth_isfull = ipbufevennorth_isfull;
			ipbufeast_isfull  = ipbufeveneast_isfull;
			ipbufsouth_isfull = ipbufevensouth_isfull;
			ipbufwest_isfull  = ipbufevenwest_isfull;
			ipbufpein_isfull  = ipbufevenpein_isfull;
		end
	end

	assign ipbufpein_sending = si_pein;
	assign ipbufnorth_sending = si_north;
	assign ipbufwest_sending = si_west;
	assign ipbufeast_sending = si_east;
	assign ipbufsouth_sending = si_south;

	// NORTH Port
	input_control ipcontrol_north (ipbufnorth_writeen, ipbufnorth_flag,
								   ipbufnorth_isfull,  ipbufnorth_sending,
								   ipbufnorth_chosen,  reset, clk);

	// EAST Port
	input_control ipcontrol_east (ipbufeast_writeen, ipbufeast_flag,
								  ipbufeast_isfull,  ipbufeast_sending,
								  ipbufeast_chosen,  reset, clk);

	// SOUTH Port
	input_control ipcontrol_south (ipbufsouth_writeen, ipbufsouth_flag,
								   ipbufsouth_isfull,  ipbufsouth_sending,
								   ipbufsouth_chosen,  reset, clk);

	// WEST Port
	input_control ipcontrol_west (ipbufwest_writeen, ipbufwest_flag,
								  ipbufwest_isfull,  ipbufwest_sending,
								  ipbufwest_chosen,  reset, clk);

	// PE input Port
	input_control ipcontrol_pe (ipbufpein_writeen, ipbufpein_flag,
								ipbufpein_isfull,  ipbufpein_sending,
								ipbufpein_chosen,  reset, clk);


//******* INPUT BUFFERS' REQUEST GENERATORS *******//

	always @* begin
		if (polarity) begin
			xhop_n = ipbufoddnorth_out[55:52];
			yhop_n = ipbufoddnorth_out[51:48];
			xdir_n = ipbufoddnorth_out[62];
			ydir_n = ipbufoddnorth_out[61];

			xhop_e = ipbufoddeast_out[55:52];
			yhop_e = ipbufoddeast_out[51:48];
			xdir_e = ipbufoddeast_out[62];
			ydir_e = ipbufoddeast_out[61];

			xhop_s = ipbufoddsouth_out[55:52];
			yhop_s = ipbufoddsouth_out[51:48];
			xdir_s = ipbufoddsouth_out[62];
			ydir_s = ipbufoddsouth_out[61];

			xhop_w = ipbufoddwest_out[55:52];
			yhop_w = ipbufoddwest_out[51:48];
			xdir_w = ipbufoddwest_out[62];
			ydir_w = ipbufoddwest_out[61];

			xhop_pein = ipbufoddpein_out[55:52];
			yhop_pein = ipbufoddpein_out[51:48];
			xdir_pein = ipbufoddpein_out[62];
			ydir_pein = ipbufoddpein_out[61];
		end
		else begin
			xhop_n = ipbufevennorth_out[55:52];
			yhop_n = ipbufevennorth_out[51:48];
			xdir_n = ipbufevennorth_out[62];
			ydir_n = ipbufevennorth_out[61];

			xhop_e = ipbufeveneast_out[55:52];
			yhop_e = ipbufeveneast_out[51:48];
			xdir_e = ipbufeveneast_out[62];
			ydir_e = ipbufeveneast_out[61];

			xhop_s = ipbufevensouth_out[55:52];
			yhop_s = ipbufevensouth_out[51:48];
			xdir_s = ipbufevensouth_out[62];
			ydir_s = ipbufevensouth_out[61];

			xhop_w = ipbufevenwest_out[55:52];
			yhop_w = ipbufevenwest_out[51:48];
			xdir_w = ipbufevenwest_out[62];
			ydir_w = ipbufevenwest_out[61];

			xhop_pein = ipbufevenpein_out[55:52];
			yhop_pein = ipbufevenpein_out[51:48];
			xdir_pein = ipbufevenpein_out[62];
			ydir_pein = ipbufevenpein_out[61];
		end
	end

	always @* begin
		if (polarity) begin
			inpbufisfull_n 	  = ipbufoddnorth_isfull;
			inpbufisfull_e 	  = ipbufoddeast_isfull;
			inpbufisfull_s 	  = ipbufoddsouth_isfull;
			inpbufisfull_w 	  = ipbufoddwest_isfull;
			inpbufisfull_pein = ipbufoddpein_isfull;
		end
		else begin
			inpbufisfull_n 	  = ipbufevennorth_isfull;
			inpbufisfull_e 	  = ipbufeveneast_isfull;
			inpbufisfull_s 	  = ipbufevensouth_isfull;
			inpbufisfull_w 	  = ipbufevenwest_isfull;
			inpbufisfull_pein = ipbufevenpein_isfull;
		end
	end

	// North Port
	request_generator reqgen_north (reqnorth_n, reqeast_n, reqsouth_n, reqwest_n, reqpeout_n,
									xhop_n, yhop_n, xdir_n, ydir_n, inpbufisfull_n);

	// East Port
	request_generator reqgen_east (reqnorth_e, reqeast_e, reqsouth_e, reqwest_e, reqpeout_e,
									xhop_e, yhop_e, xdir_e, ydir_e, inpbufisfull_e);

	// North Port
	request_generator reqgen_south (reqnorth_s, reqeast_s, reqsouth_s, reqwest_s, reqpeout_s,
									xhop_s, yhop_s, xdir_s, ydir_s, inpbufisfull_s);

	// West Port
	request_generator reqgen_west (reqnorth_w, reqeast_w, reqsouth_w, reqwest_w, reqpeout_w,
									xhop_w, yhop_w, xdir_w, ydir_w, inpbufisfull_w);

	// PE-In Port
	request_generator reqgen_pein (reqnorth_pein, reqeast_pein, reqsouth_pein, reqwest_pein, reqpeout_pein,
									xhop_pein, yhop_pein, xdir_pein, ydir_pein, inpbufisfull_pein);

//******** ARBITER'S PRIORITY_DECIDERS ************//

	// Below prioval_xxxx will be read by arbiters
	wire [(PRIOWIDTH - 1) : 0] prioval_north;
	wire [(PRIOWIDTH - 1) : 0] prioval_east;
	wire [(PRIOWIDTH - 1) : 0] prioval_south;
	wire [(PRIOWIDTH - 1) : 0] prioval_west;
	wire [(PRIOWIDTH - 1) : 0] prioval_peout;

	// changeprio_xxx will be output from arbiters which will change the
	// priority order for particular output arbiter
	wire changeprio_north;
	wire changeprio_east;
	wire changeprio_south;
	wire changeprio_west;
	wire changeprio_peout;

	// North arbiter's priority decider
	priority_decider priodecider_north (prioval_north, changeprio_north, reset, clk);

	// East arbiter's priority decider
	priority_decider priodecider_east (prioval_east, changeprio_east, reset, clk);

	// South arbiter's priority decider
	priority_decider priodecider_south (prioval_south, changeprio_south, reset, clk);

	// West arbiter's priority decider
	priority_decider priodecider_west (prioval_west, changeprio_west, reset, clk);

	// PE Output arbiter's priority decider
	priority_decider priodecider_peout (prioval_peout, changeprio_peout, reset, clk);


//****************** ARBITERS ********************//

// QUALIFY ISFULL SIGNALS!

	always @* begin
		if (polarity) begin
			opbufisfull_n 	  = opbufoddnorth_isfull;
			opbufisfull_e 	  = opbufoddeast_isfull;
			opbufisfull_s 	  = opbufoddsouth_isfull;
			opbufisfull_w 	  = opbufoddwest_isfull;
			opbufisfull_peout = opbufoddpeout_isfull;
		end
		else begin
			opbufisfull_n 	  = opbufevennorth_isfull;
			opbufisfull_e 	  = opbufeveneast_isfull;
			opbufisfull_s 	  = opbufevensouth_isfull;
			opbufisfull_w 	  = opbufevenwest_isfull;
			opbufisfull_peout = opbufevenpeout_isfull;
		end
	end

	// Playing with the input buf flag
	always @* begin
		if (polarity) begin
			ipbufevennorth_flag = ipbufnorth_flag;
			ipbufeveneast_flag  = ipbufeast_flag;
			ipbufevensouth_flag = ipbufsouth_flag;
			ipbufevenwest_flag  = ipbufwest_flag;
			ipbufevenpein_flag  = ipbufpein_flag;

			if(ipbufnorth_chosen)	ipbufoddnorth_flag = 0;
			else					ipbufoddnorth_flag = ipbufoddnorth_isfull;
			if(ipbufeast_chosen)	ipbufoddeast_flag  = 0;
			else					ipbufoddeast_flag  = ipbufoddeast_isfull;
			if(ipbufnorth_chosen)	ipbufoddsouth_flag = 0;
			else					ipbufoddsouth_flag = ipbufoddsouth_isfull;
			if(ipbufwest_chosen)	ipbufoddwest_flag  = 0;
			else					ipbufoddwest_flag  = ipbufoddwest_isfull;
			if(ipbufpein_chosen)	ipbufoddpein_flag  = 0;
			else					ipbufoddpein_flag  = ipbufoddpein_isfull;
		end
		else begin
			ipbufoddnorth_flag = ipbufnorth_flag;
			ipbufoddeast_flag  = ipbufeast_flag;
			ipbufoddsouth_flag = ipbufsouth_flag;
			ipbufoddwest_flag  = ipbufwest_flag;
			ipbufoddpein_flag  = ipbufpein_flag;

			if(ipbufnorth_chosen)	ipbufevennorth_flag = 0;
			else					ipbufevennorth_flag = ipbufevennorth_isfull;
			if(ipbufeast_chosen)	ipbufeveneast_flag  = 0;
			else					ipbufeveneast_flag  = ipbufeveneast_isfull;
			if(ipbufsouth_chosen)	ipbufevensouth_flag = 0;
			else					ipbufevensouth_flag = ipbufevensouth_isfull;
			if(ipbufwest_chosen)	ipbufevenwest_flag  = 0;
			else					ipbufevenwest_flag  = ipbufevenwest_isfull;
			if(ipbufpein_chosen)	ipbufevenpein_flag  = 0;
			else					ipbufevenpein_flag  = ipbufevenpein_isfull;
		end
	end

	// North gets request from South, East, West, PE in that order
	output_arbiter oparb_north (ipbufsouth_north_chosen, ipbufeast_north_chosen, ipbufwest_north_chosen,
								ipbufpein_north_chosen, changeprio_north,
								opbufisfull_n, reqnorth_s, reqnorth_e, reqnorth_w,
								reqnorth_pein, prioval_north);

	// East gets request from West, South, North, PE in that order
	output_arbiter oparb_east  (ipbufwest_east_chosen, ipbufsouth_east_chosen, ipbufnorth_east_chosen,
								ipbufpein_east_chosen, changeprio_east,
								opbufisfull_e, reqeast_w, reqeast_s, reqeast_n,
								reqeast_pein, prioval_east);

	// South gets request from North, West, East, PE in that order
	output_arbiter oparb_south (ipbufnorth_south_chosen, ipbufwest_south_chosen, ipbufeast_south_chosen,
								ipbufpein_south_chosen, changeprio_south,
								opbufisfull_s, reqsouth_n, reqsouth_w, reqsouth_e,
								reqsouth_pein, prioval_south);

	// West gets request from East, North, South, PE in that order
	output_arbiter oparb_west  (ipbufeast_west_chosen, ipbufnorth_west_chosen, ipbufsouth_west_chosen,
								ipbufpein_west_chosen, changeprio_west,
								opbufisfull_w, reqwest_e, reqwest_n, reqwest_s,
								reqwest_pein, prioval_west);

	// Peout gets request from North, East, South, West in that order
	output_arbiter oparb_peout (ipbufnorth_peout_chosen, ipbufeast_peout_chosen, ipbufsouth_peout_chosen,
								ipbufwest_peout_chosen, changeprio_peout,
								opbufisfull_peout, reqpeout_n, reqpeout_e, reqpeout_s,
								reqpeout_w, prioval_peout);


	assign ipbufnorth_chosen = ipbufnorth_east_chosen | ipbufnorth_south_chosen | ipbufnorth_west_chosen | ipbufnorth_peout_chosen;
	assign ipbufsouth_chosen = ipbufsouth_east_chosen | ipbufsouth_north_chosen | ipbufsouth_west_chosen | ipbufsouth_peout_chosen;
	assign ipbufeast_chosen = ipbufeast_north_chosen | ipbufeast_south_chosen | ipbufeast_west_chosen | ipbufeast_peout_chosen;
	assign ipbufwest_chosen = ipbufwest_north_chosen | ipbufwest_south_chosen | ipbufwest_east_chosen | ipbufwest_peout_chosen;
	assign ipbufpein_chosen = ipbufpein_north_chosen | ipbufpein_south_chosen | ipbufpein_west_chosen | ipbufpein_east_chosen;

//********* Datapath for output buffer flag ********//

	assign opbufnorth_grants = ipbufsouth_north_chosen | ipbufeast_north_chosen | ipbufwest_north_chosen |
							   ipbufpein_north_chosen;
	assign opbufeast_grants  = ipbufwest_east_chosen | ipbufsouth_east_chosen | ipbufnorth_east_chosen |
							   ipbufpein_east_chosen;
	assign opbufsouth_grants = ipbufnorth_south_chosen | ipbufwest_south_chosen | ipbufeast_south_chosen |
							   ipbufpein_south_chosen;
	assign opbufwest_grants  = ipbufeast_west_chosen | ipbufnorth_west_chosen | ipbufsouth_west_chosen |
							   ipbufpein_west_chosen;
	assign opbufpeout_grants = ipbufnorth_peout_chosen | ipbufeast_peout_chosen | ipbufsouth_peout_chosen |
								ipbufwest_peout_chosen;

	//****** Always block for flags *******//
	always @* begin
		if (polarity) begin		// dealing with the odd part internally
		// in odd cycle, we set the odd_flag if we granted access to the
		// requesting input

			//**** RESETTING THE EVENs ****//
			// NORTH opbuf clearing the flag from outside world
			if (so_north)	opbufevennorth_flag = 0;
			else			opbufevennorth_flag = opbufevennorth_isfull;

			// EAST opbuf
			if (so_east)	opbufeveneast_flag = 0;
			else			opbufeveneast_flag = opbufeveneast_isfull;

			// SOUTH opbuf
			if (so_south)	opbufevensouth_flag = 0;
			else			opbufevensouth_flag = opbufevensouth_isfull;

			// WEST opbuf
			if (so_west)	opbufevenwest_flag = 0;
			else			opbufevenwest_flag = opbufevenwest_isfull;

			// PEOUT opbuf
			if (so_peout)	opbufevenpeout_flag = 0;
			else			opbufevenpeout_flag = opbufevenpeout_isfull;

			//**** SETTING THE ODDs ****//
			// NORTH opbuf setting the flag from inside world
			if (opbufnorth_grants)	opbufoddnorth_flag = 1;
			else					opbufoddnorth_flag = opbufoddnorth_isfull;

			// EAST opbuf
			if (opbufeast_grants)	opbufoddeast_flag  = 1;
			else					opbufoddeast_flag  = opbufoddeast_isfull;

			// SOUTH opbuf
			if (opbufsouth_grants)	opbufoddsouth_flag = 1;
			else					opbufoddsouth_flag = opbufoddsouth_isfull;

			// WEST opbuf
			if (opbufwest_grants)	opbufoddwest_flag  = 1;
			else					opbufoddwest_flag  = opbufoddwest_isfull;

			// PEOUT opbuf
			if (opbufpeout_grants)	opbufoddpeout_flag = 1;
			else					opbufoddpeout_flag = opbufoddpeout_isfull;

		end
		else begin			// dealing with the even part
		// in even cycle, we set the even_flag if we granted access to the
		// requesting input

			//**** RESETTING THE ODDs ****//
			// NORTH opbuf clearing the flag from outside world
			if (so_north)	opbufoddnorth_flag = 0;
			else			opbufoddnorth_flag = opbufoddnorth_isfull;

			// EAST opbuf
			if (so_east)	opbufoddeast_flag  = 0;
			else			opbufoddeast_flag  = opbufoddeast_isfull;

			// SOUTH opbuf
			if (so_south)	opbufoddsouth_flag = 0;
			else			opbufoddsouth_flag = opbufoddsouth_isfull;

			// WEST opbuf
			if (so_west)	opbufoddwest_flag  = 0;
			else			opbufoddwest_flag  = opbufoddwest_isfull;

			// PEOUT opbuf
			if (so_peout)	opbufoddpeout_flag = 0;
			else			opbufoddpeout_flag = opbufoddpeout_isfull;

			//**** SETTING THE EVENs ****//
			// NORTH opbuf setting the flag from inside world
			if (opbufnorth_grants)	opbufevennorth_flag = 1;
			else					opbufevennorth_flag = opbufevennorth_isfull;

			// EAST opbuf
			if (opbufeast_grants)	opbufeveneast_flag  = 1;
			else					opbufeveneast_flag  = opbufeveneast_isfull;

			// SOUTH opbuf
			if (opbufsouth_grants)	opbufevensouth_flag = 1;
			else					opbufevensouth_flag = opbufevensouth_isfull;

			// WEST opbuf
			if (opbufwest_grants)	opbufevenwest_flag  = 1;
			else					opbufevenwest_flag  = opbufevenwest_isfull;

			// PEOUT opbuf
			if (opbufpeout_grants)	opbufevenpeout_flag = 1;
			else					opbufevenpeout_flag = opbufevenpeout_isfull;
		end
	end

	//***** Always for write enables ****//
	always @* begin
		opbufoddnorth_writeen  = 0;
		opbufoddeast_writeen   = 0;
		opbufoddsouth_writeen  = 0;
		opbufoddwest_writeen   = 0;
		opbufoddpeout_writeen  = 0;
		opbufevennorth_writeen = 0;
		opbufeveneast_writeen  = 0;
		opbufevensouth_writeen = 0;
		opbufevenwest_writeen  = 0;
		opbufevenpeout_writeen = 0;
		if (polarity) begin
			opbufoddnorth_writeen  = opbufnorth_grants;
        	opbufoddeast_writeen   = opbufeast_grants;
        	opbufoddsouth_writeen  = opbufsouth_grants;
        	opbufoddwest_writeen   = opbufwest_grants;
        	opbufoddpeout_writeen  = opbufpeout_grants;
		end
		else begin
			opbufevennorth_writeen  = opbufnorth_grants;
			opbufeveneast_writeen   = opbufeast_grants;
			opbufevensouth_writeen  = opbufsouth_grants;
			opbufevenwest_writeen   = opbufwest_grants;
			opbufevenpeout_writeen  = opbufpeout_grants;
		end
	end

	//***** Always for internal forwarding ****//

	// Generating correct set of inputs to be forwarded
	always @* begin
		if (polarity) begin
			internalforward_north = ipbufoddnorth_out;
			internalforward_east  = ipbufoddeast_out;
			internalforward_south = ipbufoddsouth_out;
			internalforward_west  = ipbufoddwest_out;
			internalforward_pein  = ipbufoddpein_out;
		end
		else begin
			internalforward_north = ipbufevennorth_out;
			internalforward_east  = ipbufeveneast_out;
			internalforward_south = ipbufevensouth_out;
			internalforward_west  = ipbufevenwest_out;
			internalforward_pein  = ipbufevenpein_out;
		end
	end

	// Selecting correct output based on the chosen_one signals
	always @* begin
		// North output buffer
		case ({ipbufsouth_chosen, ipbufeast_chosen, ipbufwest_chosen, ipbufpein_chosen})
			4'b1000: opbufnorth_in = {internalforward_south[63:52], (internalforward_south[51:48] >> 1), internalforward_south[47:0]};
			4'b0100: opbufnorth_in = {internalforward_east[63:52], (internalforward_east[51:48] >> 1), internalforward_east[47:0]};
			4'b0010: opbufnorth_in = {internalforward_west[63:52], (internalforward_west[51:48] >> 1), internalforward_west[47:0]};
			4'b0001: opbufnorth_in = {internalforward_pein[63:52], (internalforward_pein[51:48] >> 1), internalforward_pein[47:0]};
			default: opbufnorth_in = dataout_north;		// default won't be hit. But if it did, send the polarized output back to it
		endcase
		// South output buffer
		case ({ipbufnorth_chosen, ipbufwest_chosen, ipbufeast_chosen, ipbufpein_chosen})
			4'b1000: opbufsouth_in = {internalforward_north[63:52], (internalforward_north[51:48] >> 1), internalforward_north[47:0]};
			4'b0100: opbufsouth_in = {internalforward_west[63:52], (internalforward_west[51:48] >> 1), internalforward_west[47:0]};
			4'b0010: opbufsouth_in = {internalforward_east[63:52], (internalforward_east[51:48] >> 1), internalforward_east[47:0]};
			4'b0001: opbufsouth_in = {internalforward_pein[63:52], (internalforward_pein[51:48] >> 1), internalforward_pein[47:0]};
			default: opbufsouth_in = dataout_south;
		endcase
		// East output buffer
		case ({ipbufwest_chosen, ipbufsouth_chosen, ipbufnorth_chosen, ipbufpein_chosen})
			4'b1000: opbufeast_in = {internalforward_west[63:56], (internalforward_west[55:52] >> 1), internalforward_west[51:0]};
			4'b0100: opbufeast_in = {internalforward_south[63:56], (internalforward_south[55:52] >> 1), internalforward_south[51:0]};
			4'b0010: opbufeast_in = {internalforward_north[63:56], (internalforward_north[55:52] >> 1), internalforward_north[51:0]};
			4'b0001: opbufeast_in = {internalforward_pein[63:56], (internalforward_pein[55:52] >> 1), internalforward_pein[51:0]};
			default: opbufeast_in = dataout_east;
		endcase
		// West output buffer
		case ({ipbufeast_chosen, ipbufnorth_chosen, ipbufsouth_chosen, ipbufpein_chosen})
			4'b1000: opbufwest_in = {internalforward_east[63:56], (internalforward_east[55:52] >> 1), internalforward_east[51:0]};
			4'b0100: opbufwest_in = {internalforward_north[63:56], (internalforward_north[55:52] >> 1), internalforward_north[51:0]};
			4'b0010: opbufwest_in = {internalforward_south[63:56], (internalforward_south[55:52] >> 1), internalforward_south[51:0]};
			4'b0001: opbufwest_in = {internalforward_pein[63:56], (internalforward_pein[55:52] >> 1), internalforward_pein[51:0]};
			default: opbufwest_in = dataout_west;
		endcase
		// Peout output buffer
		case ({ipbufnorth_chosen, ipbufeast_chosen, ipbufsouth_chosen, ipbufwest_chosen})
			4'b1000: opbufpeout_in = internalforward_north;
			4'b0100: opbufpeout_in = internalforward_east;
			4'b0010: opbufpeout_in = internalforward_south;
			4'b0001: opbufpeout_in = internalforward_west;
			default: opbufpeout_in = dataout_peout;
		endcase
	end

	// Once selected correct output to be forwarded,
	// need to modify hopcounts!
//	always @* begin
//		//opbufnorth_in[55:52] = (opbufnorth_in[55:52] >>1);	// modify xhopcount
//		//opbufnorth_in[51:48] = (opbufnorth_in[51:48] >> 1); // modify yhopcount
//		opbufeast_in[55:52]  = (opbufeast_in[55:52]  >> 1);	// modify xhopcount
//		opbufeast_in[51:48]  = (opbufeast_in[51:48]  >> 1); // modify yhopcount
//		opbufsouth_in[55:52] = (opbufsouth_in[55:52] >> 1);	// modify xhopcount
//		opbufsouth_in[51:48] = (opbufsouth_in[51:48] >> 1); // modify yhopcount
//		opbufwest_in[55:52]  = (opbufwest_in[55:52]  >> 1);	// modify xhopcount
//		opbufwest_in[51:48]  = (opbufwest_in[51:48]  >> 1); // modify yhopcount
//		opbufpeout_in[55:52] = (opbufpeout_in[55:52] >> 1);	// modify xhopcount
//		opbufpeout_in[51:48] = (opbufpeout_in[51:48] >> 1); // modify yhopcount
//	end

	// Put these values into opbuffers
	// writeenbles will select the appropriate opbuf to put the values

	assign opbufevennorth_in = opbufnorth_in;
	assign opbufoddnorth_in  = opbufnorth_in;
	assign opbufeveneast_in  = opbufeast_in;
	assign opbufoddeast_in   = opbufeast_in;
	assign opbufevensouth_in = opbufsouth_in;
	assign opbufoddsouth_in  = opbufsouth_in;
	assign opbufevenwest_in  = opbufwest_in;
	assign opbufoddwest_in  =  opbufwest_in;
	assign opbufevenpeout_in = opbufpeout_in;
	assign opbufoddpeout_in =  opbufpeout_in;

//************** GENERATING SO SIGNALS ************//

	always @* begin
		if (polarity) begin
			so_north = opbufevennorth_isfull & ro_north;
			so_east  = opbufeveneast_isfull  & ro_east;
			so_south = opbufevensouth_isfull & ro_south;
			so_west  = opbufevenwest_isfull  & ro_west;
			so_peout = opbufevenpeout_isfull & ro_peout;
		end
		else begin
			so_north = opbufoddnorth_isfull & ro_north;
			so_east  = opbufoddeast_isfull  & ro_east;
			so_south = opbufoddsouth_isfull & ro_south;
			so_west  = opbufoddwest_isfull  & ro_west;
			so_peout = opbufoddpeout_isfull & ro_peout;
		end
	end


//********* GENERATING DATA OUT SIGNALS ************//

	always @* begin
		if (polarity) begin
			dataout_north = opbufevennorth_out;
			dataout_east  = opbufeveneast_out;
			dataout_south = opbufevensouth_out;
			dataout_west  = opbufevenwest_out;
			dataout_peout = opbufevenpeout_out;
		end
		else begin
			dataout_north = opbufoddnorth_out;
			dataout_east  = opbufoddeast_out;
			dataout_south = opbufoddsouth_out;
			dataout_west  = opbufoddwest_out;
			dataout_peout = opbufoddpeout_out;
		end
	end


//********* TOGGLING POLARITY FUNCTION **********//

	always @ (posedge clk) begin
		if (reset)		polarity <= 0;
		else 			polarity <= ~polarity;
	end

endmodule

