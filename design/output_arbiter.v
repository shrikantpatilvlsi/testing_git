// Output arbiter
// Last Updated: 10/22/2023

module output_arbiter (granttoone, granttotwo, granttothree, granttofour,
					   change_prio, isfull, reqfromone, reqfromtwo,
					   reqfromthree, reqfromfour, priority_val);

	input isfull;
	input reqfromone;
	input reqfromtwo;
	input reqfromthree;
	input reqfromfour;
	input [3:0] priority_val;

	output reg granttoone;
	output reg granttotwo;
	output reg granttothree;
	output reg granttofour;
	output reg change_prio;

	wire [3:0] combinereq;

	assign combinereq = {reqfromone, reqfromtwo, reqfromthree, reqfromfour};

	always @* begin
		// to avoid latch
		granttoone   = 0;
		granttotwo   = 0;
		granttothree = 0;
		granttofour  = 0;
		change_prio  = 0;
		// if someone requests and we have space to ack that request only then
		// we grantto the resource
		if ((reqfromone || reqfromtwo || reqfromthree || reqfromfour) && (~isfull)) begin
			// more than 1 request
			// grantto based on priority value and set change_prio signal
			if (~((combinereq == 4'b0001) || (combinereq == 4'b0010) ||
				  (combinereq == 4'b0100) || (combinereq == 4'b1000))) begin
				case (priority_val)
					4'b0001:	granttoone   = 1;
					4'b0010:	granttotwo   = 1;
					4'b0100:	granttothree = 1;
					4'b1000:	granttofour  = 1;
				endcase
				change_prio = 1;
			end
			// only 1 requester, grant him access
			else begin
				case (1'b1)
					reqfromone:   granttoone   = 1;
					reqfromtwo:   granttotwo   = 1;
					reqfromthree: granttothree = 1;
					reqfromfour:  granttofour  = 1;
				endcase
			end
		end
	end

endmodule
