module Control_unit(
	input logic [6:0] Opcode,
	output logic ALUSrc,MemtoReg,RegWrite, MemRead, MemWrite, Branch,
	output logic [1:0] Aluop
);
always_comb begin
    case (Opcode)
      7'b0000011: //ld
        begin
          ALUSrc = 1'b1;
          MemtoReg = 1'b1;
          RegWrite = 1'b1;
          MemRead = 1'b1;
          MemWrite = 1'b0;
          Branch = 1'b0;
          Aluop = 2'b00;
        end

      7'b0100011: //sd
        begin
          ALUSrc = 1'b1;
          MemtoReg = 1'bx;
          RegWrite = 1'b0;
          MemRead = 1'b0;
          MemWrite = 1'b1;
          Branch = 1'b0;
          Aluop = 2'b00;
        end

      7'b0110011: //R-format
        begin
          ALUSrc = 1'b0;
          MemtoReg = 1'b0;
          RegWrite = 1'b1;
          MemRead = 1'b0;
          MemWrite = 1'b0;
          Branch = 1'b0;
          Aluop[1:0] = 2'b10;
        end

      7'b1100011:  //beq
        begin
          ALUSrc = 1'b0;
          MemtoReg = 1'bx;
          RegWrite = 1'b0;
          MemRead = 1'b0;
          MemWrite = 1'b0;
          Branch = 1'b1;
          Aluop[1:0] = 2'b01;
        end

      7'b0010011:
        begin
          ALUSrc = 1'b1;
          MemtoReg = 1'b0;
          RegWrite = 1'b1;
          MemRead = 1'b0;
          MemWrite = 1'b0;
          Branch = 1'b0;
          Aluop = 2'b00;
        end
      default:
        begin
          ALUSrc = 1'b0;
          MemtoReg = 1'b0;
          RegWrite = 1'b0;
          MemRead = 1'b0;
          MemWrite = 1'b0;
          Branch = 1'b0;
          Aluop = 2'b00;
        end
    endcase

end
endmodule
