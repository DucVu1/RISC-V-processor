module ALU_1bit_Cin(
	input logic A,B,Ainvert, Binvert, Less, Cin,
	input logic [1:0] Operation,
	output logic Result, Cout
);
logic Adder_Result;
logic B_checked, A_checked;
always_comb begin
	case(Operation)
		2'b00: Result = A_checked & B_checked ;
		2'b01: Result = A_checked | B_checked;
		2'b10: Result = Adder_Result;
	default: Result = Less;
	endcase
end
assign B_checked = (B^Binvert);
assign A_checked = A^Ainvert;
FA_1bit F(.A(A_checked),.B(B_checked),.Cin(Cin),.S(Adder_Result),.Cout(Cout));
endmodule
