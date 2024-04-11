module Data_memory#(parameter Width = 8, parameter Numbit =32)(
	input logic clk, MemWrite, MemRead,
	input logic [Numbit-1:0] Write_data, Address,
	output logic [Numbit-1:0] Read_data
);

logic [Width -1: 0] mem [1024 - 1:0];


always_ff @(posedge clk) begin : Data_memory
	if (MemWrite) begin 
		mem[Address] <= Write_data[7:0];
		mem[Address+1] <=Write_data[15:8] ;
		mem[Address+2] <=Write_data[23:16] ;
		mem[Address+3] <=Write_data[31:24];
		end
	end
always @(*)begin
	if (MemRead) begin
		Read_data[7:0] = mem[Address];
		Read_data[15:8] = mem[Address+1];
		Read_data[23:16] = mem[Address+2];
		Read_data[31:24]= mem[Address+3];
	end
	else
		Read_data[7:0] = 8'd0;
		Read_data[15:8] = 8'd0;
		Read_data[23:16] = 8'd0;
		Read_data[31:24]= 8'd0;
	end
endmodule


