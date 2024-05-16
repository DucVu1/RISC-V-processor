module SMcomparator#(parameter N = 32)(
	input Cout,
	input logic [N-1:0] A, B,
	output logic less_than
);
always_comb begin 
	if(A[N-1] & ~B[N-1])
		less_than = 1'b1;
	else if(~A[N-1] & B[N-1])
		less_than = 1'b0;
	else
		less_than = Cout;
	end
endmodule
