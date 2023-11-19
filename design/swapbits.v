module swapbits (op, ip);
	input [63:0] ip;
	output reg [63:0] op;
	integer i;
	always @* begin
		for (i = 0; i < 64; i = i + 1)
			op[63 - i] = ip[i];
	end
endmodule
