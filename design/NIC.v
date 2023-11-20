//Group Number 1

module nic_mesh(addr,d_in,d_out,nicEn,nicEnWr,net_si,net_ri,net_di,net_so,net_ro,net_do_rev,net_polarity,clk,reset);
	input [0:1] addr;
	input [0:63] d_in;
	input net_polarity;
	input clk;
	input reset;
	input nicEn;
	input nicEnWr;
	input net_si;
	input [63:0] net_di;
	input net_ro;
	output reg net_so;
	output net_ri;
	output reg [0:63] d_out;

	//output reg [0:63] net_do;
	output [63:0] net_do_rev;

	//declare buffer registers
	reg [0:63] net_do;
	reg [0:63] inp_buffer;
	reg [0:63] out_buffer;
	reg inp_sts;
	reg out_sts;

	wire [0:63] net_di_rev;

	//temporary variables


	//reversing logic instantiations
	swapbits do_rev (.ip(net_do),.op(net_do_rev));
	swapbits di_rev (.ip(net_di),.op(net_di_rev));
	//Logic for Write to output channel buffer mechanism
	//Data Packet going from Processor to NIC
	//sets the out_sts
	//sets the out_buffer
	//clears out_sts on read
	always@(posedge clk) begin
		if (reset) begin
			out_buffer <= 64'b0;
			out_sts <= 1'b0;
		end else begin
			if(nicEn) begin
				case(addr)
					2'b10: begin
						if(nicEnWr) begin
							if(~out_sts || (net_ro && out_sts)) begin
								out_sts <= 1'b1;
								out_buffer <= d_in;
							end
						end
					end
					default: begin
					end
				endcase
			end
			if(net_ro && out_sts && ~(nicEn && nicEnWr && (addr==2'b10))) begin
				out_sts <= 1'b0;
			end
		end
	end

	//Logic for Read from input channel buffer mechanism
	//Data packet going from NIC to Processor
	always@(*) begin
		if(nicEn) begin
			if(~nicEnWr) begin
				case(addr)
					2'b00: begin
						d_out = inp_buffer;
					end
					2'b01: begin
						d_out = {63'b0, inp_sts};
					end
					2'b10: begin
						d_out = out_buffer;
					end
					2'b11: begin
						d_out = {63'b0, out_sts};
					end
				endcase
			end else begin

			end
		end else begin
			d_out= inp_buffer;
		end
	end

	//Clear the input buffer status register
	//set the input buffer status register
	always@(posedge clk) begin
	if(reset) begin
		inp_sts = 1'b0;
	end else begin
		if(nicEn && ~nicEnWr && inp_sts) begin
			inp_sts <= 1'b0;
		end
		if(net_si) begin
			inp_sts <= 1'b1;
		end
	end

	end

	//Logic for Read from output channel buffer mechanism
	//Data Packet going from NIC to router
	//Logic to set net_so

	always@(*) begin
		net_so = net_ro & out_sts;
		if(net_so) begin
			net_do = {out_buffer[0:62],~net_polarity};
		end else begin
			net_do = out_buffer;
		end
	end

	//Logic for Write to input channel buffer mechanism
	//Data Packet going from router to NIC

	always@(posedge clk) begin
		if(reset)begin
			inp_buffer <= 64'b0;
		end else begin
			if(net_si && ~inp_sts) begin
				inp_buffer <= net_di_rev;
			end
		end
	end

	//Set the ready flag to indicate buffer is free to be written
	assign net_ri = ~inp_sts;
endmodule