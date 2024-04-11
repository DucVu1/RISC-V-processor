module Control_Mux21(
input logic ALUSrc,MemtoReg,RegWrite, MemRead, MemWrite, Branch, Stall,
input logic [1:0] ALUOp,
output logic ALUSrc_out, MemtoReg_out, RegWrite_out, MemRead_out, MemWrite_out, Branch_out,
output logic [1:0] ALUOp_out
);

always_comb begin
	if(Stall) begin 
		ALUSrc_out = 1'b0;
		MemtoReg_out = 1'b0;
		RegWrite_out = 1'b0;
		MemRead_out = 1'b0;
		MemWrite_out = 1'b0;
		Branch_out = 1'b0;
		ALUOp_out = 2'b0;
	end
	else begin 
		ALUSrc_out = ALUSrc;
		MemtoReg_out = MemtoReg;
		RegWrite_out = RegWrite;
		MemRead_out = MemRead;
		MemWrite_out = MemWrite;
		Branch_out = Branch;
		ALUOp_out = ALUOp;
	end
end
endmodule
