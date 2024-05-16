module CLA_4bit(
	input logic [3:0] A, B,
	input logic Cin,
	output logic p, g,
	output logic [3:0] Sum
);
logic [3:0] C;
logic [3:0] P, G;
	 
assign P[0] = A[0] | B[0];
assign P[1] = A[1] | B[1];
assign P[2] = A[2] | B[2];
assign P[3] = A[3] | B[3];

assign p = P[0] & P[1] & P[2] & P[3];

assign G[0] = A[0] & B[0];
assign G[1] = A[1] & B[1];
assign G[2] = A[2] & B[2];
assign G[3] = A[3] & B[3];


assign C[0] = G[0] | (P[0] & Cin); //1
assign C[1] = G[1] | (P[1] & G[0]) | (P[1]&P[0]&Cin); //2
assign C[2] = G[2] | (P[2] & G[1]) | (P[2]&P[1]&G[0]) | (P[2]&P[1]&P[0]&Cin); //3
assign C[3]= G[3] | (P[3] & G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]) | (P[3]&P[2]&P[1]&P[0]&Cin); //4

assign g = C[3]; 

	
assign Sum[0] = A[0] ^ B[0] ^ Cin;
assign Sum[1] = A[1] ^ B[1] ^ C[0]; 
assign Sum[2] = A[2] ^ B[2] ^ C[1]; 
assign Sum[3] = A[3] ^ B[3] ^ C[2]; 

endmodule
