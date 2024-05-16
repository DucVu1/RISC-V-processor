module ALU_Control(
	input logic [1:0] ALUOp,
	input logic funct7,
	input logic [2:0] funct3,
	output logic [3:0] Operation // [3:1] = Operation [0] = Cin
);
always_comb begin
	case(ALUOp)
		2'b00: Operation = 4'b0010;//2
		2'b01: Operation = 4'b0110;//6
		2'b10: begin //R - I instruction
				  case(funct3)
						3'b000: Operation = funct7 ? 4'b0111 : 4'b0110;//0 ADD, funct 7 =1 -> SUB
						3'b001: Operation = 4'b1010;//1 Shift left
						3'b010: Operation = 4'b1101;//2 SLT
						3'b011: Operation = 4'b1111;//3 SLT Signed
						3'b100: Operation = 4'b0100;//4 XOR
						3'b101: Operation = funct7 ?4'b1001 : 4'b1000;//5 Shift right (funct7 =1 -> arithmetic) logical
						3'b110: Operation = 4'b0010;//6 OR
						3'b111: Operation = 4'b0000;//7 AND
					endcase
					end
		2'b11: begin 
			 if(!funct7) begin
				  case(funct3)
						3'b000: Operation = 4'b0010;
						3'b111: Operation = 4'b0000;
						3'b110: Operation = 4'b0001;
					default : Operation = 4'b0000;
					endcase
					end
				else
				Operation = 4'b0100;
				end
		default: Operation = 4'b0000;
	endcase
end
endmodule	
