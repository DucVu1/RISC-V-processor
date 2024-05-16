module CLA_16bit#(parameter Width = 16)(
	input logic [Width - 1: 0] A, B,
	input logic Cin, 
	output logic p,g,
	output logic [Width - 1: 0] Sum
);
logic [3:0] P, G, C;
generate
	genvar i;
	for (i = 0; i < 4; i = i+1) begin : generate_16bit_CLA
		if( i == 0) begin
		CLA_4bit CLA(.A(A[4*i + 3: 4*i]), .B(B[4*i + 3: 4*i]), .Cin(Cin), .p(P[i]), .g(G[i]), .Sum(Sum[4*i + 3: 4*i]));
		end
		else begin
		CLA_4bit CLA(.A(A[4*i + 3: 4*i]), .B(B[4*i + 3: 4*i]), .Cin(C[i-1]), .p(P[i]), .g(G[i]), .Sum(Sum[4*i + 3: 4*i]));
		end
	end
endgenerate
assign p = P[0] & P[1] & P[2] & P[3];

assign C[0] = G[0] | (P[0] & Cin); //1
assign C[1] = G[1] | (P[1] & G[0]) | (P[1]&P[0]&Cin); //2
assign C[2] = G[2] | (P[2] & G[1]) | (P[2]&P[1]&G[0]) | (P[2]&P[1]&P[0]&Cin); //3
assign C[3]= G[3] | (P[3] & G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]) | (P[3]&P[2]&P[1]&P[0]&Cin); //4

assign g = C[3];
endmodule

