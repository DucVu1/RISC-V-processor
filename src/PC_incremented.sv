module PC_incremented#(parameter N = 32)(
	input logic [N-1:0] PC_in,
	output logic [N-1:0] PC_out
);
logic Not_used;
FA_32bit PC_incremented(
	.A(PC_in),.B(32'h4),.Cin(1'b0),.S(PC_out), .Cout(Not_used)
);
endmodule
