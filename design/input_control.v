// Input control for every buffer
// Last updated: 10/21/2023
// What it does -
// Controls the controls required by the input buffer - write_en and flag

module input_control (write_en, flagtobuf, isfull, sending, chosen_one, reset, clk);

	output reg write_en;	// going to write_en of the ip buffer
	output reg flagtobuf;	// going to the isfull reg in ip buffer

	input isfull;		// coming from the input buffer
	input sending;		// coming from outside the router
	input chosen_one;	// coming from the arbiter
	input reset;
	input clk;

	always @* begin
		write_en = 0;
		flagtobuf = isfull;
		if ((sending) & ~(isfull)) begin	// if someone is sending the data to ipbuf and it is empty
			write_en = 1;
			flagtobuf = 1;
		end
//		if (chosen_one & (isfull)) 			// if chosen_one to read, and has data then make it empty
//			flagtobuf = 0;
	end

endmodule
