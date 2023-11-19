// Channel Buffer
// Last Updated: 10/20/2023

module channel_buffer #(parameter WIDTH = 64) (buf_out, isfull, buf_in, write_en, flag, reset, clk);

	input [(WIDTH-1) : 0] buf_in;
	input write_en;
	input flag;			// buffer empty (0) or buffer full (1) isfull
	input reset;		// synchronous reset
	input clk;

	output reg [(WIDTH-1) : 0] buf_out;
	output reg isfull;

	always @ (posedge clk) begin
		if (reset) begin
			buf_out <= 0;
			isfull 	<= 0;
		end
		else if (write_en) begin
			buf_out <= buf_in;
			isfull <= 1'b1;
		end
		else
			isfull <= flag;			// isfull will become 0 when we read the data, thus taking it outside write_en
	end

endmodule
