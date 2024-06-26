module EXMEM_register #(parameter Width = 32, parameter Depth = 32)(
	input logic clk, Branch, MemRead, MemWrite, RegWrite, MemtoReg,flush,
	input logic [Width - 1:0] PC_calculated,
	input logic [Depth - 1:0] ALU_result, Read_data1, 
	input logic [4:0] Register_dest,
	input logic [2:0] funct3_in,
	output logic [Width - 1:0] PC_calculated_out,
	output logic Branch_out, MemRead_out, MemWrite_out, RegWrite_out, MemtoReg_out,
	output logic [Depth - 1:0] ALU_result_out, Read_data1_out,
	output logic [2:0] funct3_out,
	output logic [4:0] Register_dest_out
);

always_ff @(posedge clk) begin 
	if(!flush) begin
		PC_calculated_out <= PC_calculated;
		ALU_result_out <= ALU_result;
		Read_data1_out <= Read_data1;
		Register_dest_out <= Register_dest;
		Branch_out <= Branch;
		MemRead_out <= MemRead;
		MemWrite_out <= MemWrite;
		RegWrite_out <= RegWrite;
		MemtoReg_out <= MemtoReg;
		funct3_out <= funct3_in;
	end
	else begin
		PC_calculated_out <= 32'd0;
		ALU_result_out <= 32'd0;
		Read_data1_out <= 32'd0;
		Register_dest_out <= 5'b0;
		Branch_out <= 1'b0;
		MemRead_out <= 1'b0;
		MemWrite_out <= 1'b0;
		RegWrite_out <= 1'b0;
		MemtoReg_out <= 1'b0;
		funct3_out <= 3'd0;
	end
end
endmodule
