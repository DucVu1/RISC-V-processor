module Immediate_generatord#(
	parameter InputWidth =  12,
	parameter OutputWidth = 32
)(
	input logic [InputWidth - 1: 0] in,
	output logic [OutputWidth -1: 0] out
);
//first we calculate the difference and replicated the sign bit then concatenate
assign out = {{(OutputWidth - InputWidth){in[InputWidth -1]}}, in};
endmodule
