 module register_file#(parameter DATA_N = 32,SIZE = 32)
 (
	 input logic clk, wr_en,
	 input logic [4:0] w_addr, r0_addr, r1_addr,
	 input logic [DATA_N-1:0] w_data,
	 output logic [DATA_N-1:0] r8,r11,
	 output logic [DATA_N-1:0] r0_data, r1_data
 );
 
logic [DATA_N-1:0] regs [0:SIZE-1];

assign r8 = regs[8];
assign r11 = regs[11];

always_ff @(posedge clk) begin 
	if (wr_en) begin
		regs[w_addr] <= w_data; end
		end
		
assign r0_data = regs[r0_addr];
assign r1_data = regs[r1_addr];
 
endmodule 
