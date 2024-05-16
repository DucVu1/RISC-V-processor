module AU #(parameter Width = 32 ) (
	input logic [Width - 1: 0] A, B,
	input logic Cin,
	output logic Cout,
	output logic [Width - 1: 0] Sum
);
logic [1:0] P,G,C;
logic [Width - 1:0] B_checked;
generate
	genvar k;
		for (k = 0; k < Width ; k = k + 1) begin : generate_B_checked
		assign B_checked[k] = B[k] ^ Cin;
	end
endgenerate

CLA_16bit CLA0(.A(A[15:0]), .B(B_checked[15:0]), .Cin(Cin), .p(P[0]), .g(G[0]), .Sum(Sum[15:0]));
CLA_16bit CLA1(.A(A[31:16]), .B(B_checked[31:16]), .Cin(C[0]), .p(P[1]), .g(G[1]), .Sum(Sum[31:16]));


assign C[0] = G[0] | (P[0] & Cin); //1
assign C[1] = G[1] | (P[1] & G[0]) | (P[1]&P[0]&Cin); //2

assign Cout = (~C[1]) & Cin;

endmodule
