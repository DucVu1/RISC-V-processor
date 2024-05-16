module Data_memory#(parameter Width = 8, parameter Numbit =32)(
	input logic clk, MemWrite, MemRead,
	input logic [2:0] funct3,
	input logic [Numbit-1:0] Write_data, Address,
	output logic [Numbit-1:0] Read_data
);

logic [Width -1: 0] mem [2048- 1:0];


always_ff @(posedge clk) begin : Data_memory
	if (MemWrite) begin 
		case(funct3) 
		3'd0: begin // byte
			mem[Address] <= Write_data[7:0]; end
		3'd1: begin // half word
			mem[Address] <= Write_data[7:0];
			mem[Address + 1] <= Write_data[15:8]; end
		3'd2: begin // word
			mem[Address] <= Write_data[7:0];
			mem[Address + 1] <= Write_data[15:8]; 
			mem[Address + 2] <= Write_data[23:16];
			mem[Address + 3] <= Write_data[31:24];  end
		default: begin 
			mem[Address] <= Write_data[7:0];
			mem[Address + 1] <= Write_data[15:8]; 
			mem[Address + 2] <= Write_data[23:16];
			mem[Address + 3] <= Write_data[31:24]; end
		endcase
		end
	end
always @(*)begin
	if (MemRead) begin
		case(funct3) 
		3'd0: begin // byte
			Read_data[7:0] = mem[Address];
			Read_data[31:8] = {24{Read_data[15]}}; end
		3'd1: begin // half word
			Read_data[7:0] = mem[Address];
			Read_data[15:8] = mem[Address +1];
			Read_data[31:16] = {16{Read_data[15]}}; end
		3'd2: begin // word
			Read_data[7:0] = mem[Address];
			Read_data[15:8] = mem[Address+1];
			Read_data[23:16] = mem[Address+2];
			Read_data[31:24]= mem[Address+3]; end
		3'd4: begin // Unsigned byte
			Read_data[7:0] = mem[Address];
			Read_data[31:8] = 24'd0; end
		3'd5: begin // Unsigned half word
			Read_data[7:0] = mem[Address];
			Read_data[15:8] = mem[Address +1];
			Read_data[31:16] = 16'd0; end
		default: begin 
			Read_data[7:0] = mem[Address];
			Read_data[15:8] = mem[Address+1];
			Read_data[23:16] = mem[Address+2];
			Read_data[31:24]= mem[Address+3]; end
		endcase
	end
	else
		Read_data[7:0] = 8'd0;
		Read_data[15:8] = 8'd0;
		Read_data[23:16] = 8'd0;
		Read_data[31:24]= 8'd0;
	end
endmodule


