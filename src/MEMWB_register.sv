module MEMWB_register #(parameter Width = 32, parameter Depth = 32)(
	input logic clk, RegWrite, MemtoReg,
	input logic [Depth - 1:0] Read_data,
	input logic [Width -1:0] ALU_result,
	input logic [4:0] Register_dest,
	output logic RegWrite_out, MemtoReg_out,
	output logic [Depth - 1:0] Read_data_out,
	output logic [Width - 1:0] ALU_result_out,
	output logic [4:0] Register_dest_out
);

always_ff @(posedge clk) begin 
		Read_data_out <= Read_data;
		ALU_result_out <= ALU_result;
		Register_dest_out <= Register_dest;
		RegWrite_out <= RegWrite;
		MemtoReg_out <= MemtoReg;
	end
endmodule
