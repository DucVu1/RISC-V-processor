module LU_1bit(
	input logic A,B,
	input logic [1:0] Operation,
	output logic Result
);
always_comb begin
	case(Operation)
		2'b00: Result = A & B ;
		2'b01: Result = A | B;
		2'b10: Result = A ^ B;
	default: Result = 0;
	endcase
end
endmodule
