module FA_1bit(
	input logic A,B,Cin,
	output logic S, Cout
);
always_comb begin
	S = (A^B)^Cin;
	Cout = (A&B) | Cin&(A^B);
	end
endmodule

