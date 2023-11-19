// Priority decider to change the priority for a particular arbiter/output
// controller
// Last Udpated: 10/20/2023

module priority_decider (priority_val, change_prio, reset, clk);
	
	parameter PRIOWIDTH = 4;

	// change_prio send by the arbiter whenever there is more than 1 
	// buffer wanting to send the data to this arbiter's output buffer
	input change_prio;	
	input reset;
	input clk;
	
	output reg [(PRIOWIDTH - 1) : 0] priority_val;

	always @ (posedge clk)
		if (reset)				priority_val <= 4'b0001;	// load with default value as 0001
		else if (change_prio)	priority_val <= {priority_val[2:0], priority_val[3]};	// rotate left
	
endmodule
