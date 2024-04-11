module IDEX_register#(parameter Width = 32, parameter Depth = 32)(
	input logic clk, funct7,ALUSrc, Branch, MemRead, MemWrite, RegWrite, MemtoReg, flush,
	input logic [1:0] ALUOp,
	input logic [Width - 1:0] Address_in, Immediate_value,
	input logic [Depth - 1:0] Read_data0,Read_data1,
	input logic [2:0] funct3,
	input logic [4:0] Register_dest, IFID_registerRs1, IFID_registerRs2,
	output logic [Width - 1:0] Address_out, Immediate_value_out,
	output logic [Depth - 1:0] Read_data0_out, Read_data1_out,
	output logic funct7_out, ALUSrc_out, Branch_out, MemRead_out, MemWrite_out, RegWrite_out, MemtoReg_out,
	output logic [1:0] ALUOp_out,
	output logic [2:0] funct3_out,
	output logic [4:0] Register_dest_out, Rs1, Rs2 // Instruction_out also is the Rd input for the Forwarding Unit
);
always_ff @(posedge clk) begin 
	if(!flush) begin
		Address_out <= Address_in;
		Read_data0_out <= Read_data0;
		Read_data1_out <= Read_data1;
		Immediate_value_out <= Immediate_value;
		funct7_out <= funct7;
		funct3_out <= funct3;
		Register_dest_out <= Register_dest;
		ALUSrc_out <= ALUSrc_out <= ALUSrc;
		Branch_out <= Branch;
		MemRead_out <= MemRead;
		MemWrite_out <= MemWrite;
		RegWrite_out <= RegWrite;
		MemtoReg_out <= MemtoReg;
		ALUOp_out <= ALUOp;
		Rs1 <= IFID_registerRs1;
		Rs2 <= IFID_registerRs2;
	end
	else begin
		Address_out <= 32'd0;
		Read_data0_out <= 32'd0;
		Read_data1_out <= 32'd0;
		Immediate_value_out <= 32'd0;
		funct7_out <= 1'd0;
		funct3_out <= 3'd0;
		Register_dest_out <= 5'd0;
		ALUSrc_out <= ALUSrc_out <= 1'd0;
		Branch_out <= 1'd0;
		MemRead_out <= 1'd0;
		MemWrite_out <= 1'd0;
		RegWrite_out <= 1'd0;
		MemtoReg_out <= 1'd0;
		ALUOp_out <= 2'd0;
		Rs1 <= 5'd0;
		Rs2 <= 5'd0;
end
end
endmodule
