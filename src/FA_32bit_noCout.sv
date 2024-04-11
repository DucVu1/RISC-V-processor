module FA_32bit_noCout #(
    parameter N = 32
)(
    input logic [N-1:0] A, B,
    input logic Cin,
    output logic [N-1:0] S,
);
    logic [N-1:0] Carry;
    logic [N-1:0] B_checked;

    // Continuous assignment for B_checked
    generate
        genvar k;
        for (k = 0; k < N; k = k + 1) begin : generate_B_checked
            assign B_checked[k] = B[k] ^ Cin;
        end
    endgenerate

    // Generate adders
    generate
        genvar i;
        for (i = 0; i < N; i = i + 1) begin : generate_64bit_adder
            if (i == 0) begin
                FA_1bit F(.A(A[i]), .B(B_checked[i]), .Cin(Cin), .S(S[i]), .Cout(Carry[i]));
            end else begin
                FA_1bit F(.A(A[i]), .B(B_checked[i]), .Cin(Carry[i-1]), .S(S[i]), .Cout(Carry[i]));
            end
        end
    endgenerate

    assign Cout = (~Carry[N-1])&Cin;
endmodule
