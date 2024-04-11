module ALU_Control(
	input logic [1:0] ALUOp,
	input logic funct7,
	input logic [2:0] funct3,
	output logic [3:0] Operation
);
/*always_comb begin
	case ({ALUOp, funct7, funct3})
		12'b00_xxxxxxx_xxx : Operation = 4'b0010;
		12'bx1_xxxxxxx_xxx : Operation = 4'b0110;
		12'b1x_0000000_000 : Operation = 4'b0010;
		12'b1x_0100000_000 : Operation = 4'b0110;
		12'b1x_0000000_111 : Operation = 4'b0000;
		12'b1x_0000000_110 : Operation = 4'b0001;
	endcase
end
endmodule*/
always_comb begin
	case(ALUOp)
		2'b00: Operation = 4'b0010;
		2'b01: Operation = 4'b0110;
		2'b10: begin 
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