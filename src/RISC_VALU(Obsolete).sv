module RISC_VALU#(parameter N = 32)(
	input logic [N-1:0] A,B,
	input logic [3:0] Operation,
	output logic [N-1:0] Result
);
logic [N-1:0] CarryOut;
logic Set_Value;
generate
	genvar i;
	for (i = 0; i < N; i= i + 1) begin : generate_32bit_ALU
		if (i == 0) begin
			ALU_1bit ALU(.A(A[i]),.B(B[i]),.Ainvert(Operation[3]),.Binvert(Operation[2]),.Less(Set_Value)
			,.Operation(Operation[1:0]),.Result(Result[i]),.Cout(CarryOut[i])); end
		else if (i == N-1) begin
			ALU_1bit_SET ALU(.A(A[i]),.B(B[i]),.Ainvert(Operation[3]),.Binvert(Operation[2]),.Less(1'b0),.Cin(CarryOut[i-1])
			,.Operation(Operation[1:0]),.Result(Result[i]),.Cout(CarryOut[i]),.Set(Set_Value));
		end
		else begin 
			ALU_1bit_Cin ALU(.A(A[i]),.B(B[i]),.Ainvert(Operation[3]),.Binvert(Operation[2]),.Less(1'b0),.Cin(CarryOut[i-1])
			,.Operation(Operation[1:0]),.Result(Result[i]),.Cout(CarryOut[i]));
		end
	end
endgenerate
//assign Overflow = Result[N-1]^Result[N-2];
endmodule
