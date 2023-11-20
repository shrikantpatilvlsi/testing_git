// Request Generator
// Last Updated: 10/22/2023
// This module will take hop_count, direction bits, appropriate isfull flag
// Based on these inputs, it will generate request
// XY algorithm
// Direction Bits - 
// 		MSB - North (0), South (1)
// 		LSB - East  (0), West  (1)
// Hop Count - 
// 		MSB 4 bits - X hop count
// 		LSB 4 bits - Y hop count

module request_generator (req_north, req_east, req_south, req_west, req_peout, x_hopcount, y_hopcount, x_dir, y_dir, isfull);
	input [3:0] x_hopcount;
	input [3:0] y_hopcount;
	input x_dir;
	input y_dir;
	input isfull;

	output reg req_north;
	output reg req_east;
	output reg req_south;
	output reg req_west;
	output reg req_peout;
	
	always @* begin
		// to avoid latches
		req_north = 0;
		req_east  = 0;
		req_south = 0;
		req_west  = 0;
		req_peout = 0;
		if (isfull)
			if (x_hopcount[0])
				if (x_dir)	req_west  = 1;
				else		req_east  = 1;
			else if (y_hopcount[0])				// No xhops left, traverse for yhops
				if (y_dir)	req_south = 1;
				else		req_north = 1;
			else			req_peout = 1;		// Neither xhops, nor yhops; go to the processor!
	end
endmodule
