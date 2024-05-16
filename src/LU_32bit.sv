module LU_32bit#(parameter N = 32)(
	input logic [N-1:0] A,B,
	input logic [1:0] Operation,
	output logic [N-1:0] Result
);

generate
	genvar i;
	for (i = 0; i < N; i= i + 1) begin : generate_32bit_LU
		LU_1bit LU(.A(A[i]), .B(B[i]), .Operation(Operation), .Result(Result[i]));
	end
endgenerate

endmodule
