module Shift_left_1bit #(parameter N = 32)(
	input logic [N-1:0] in,
	output logic [N-1:0] out
);

assign out = in<<1;
endmodule
