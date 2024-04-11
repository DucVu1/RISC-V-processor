module IFID_register#(parameter Width = 32, parameter Depth = 32)(
	input logic clk, flush,
	input logic [Width - 1: 0] Address_in,
	input logic [Depth - 1: 0] Instruction_in,
	output logic [Width - 1: 0] Address_out,
	output logic [Depth -1: 0] Instruction_out
);

always_ff @(posedge clk) begin 
	if(!flush) begin 
		Address_out <= Address_in;
		Instruction_out <= Instruction_in;
	end
	else begin
		Address_out <= 32'd0;
		Instruction_out <= 32'd0;
end
end
endmodule
