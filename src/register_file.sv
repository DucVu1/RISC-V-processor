module register_file #(parameter DATA_N = 32, SIZE = 32)
(
    input logic clk, wr_en,
    input logic [4:0] w_addr, r0_addr, r1_addr,
    input logic [DATA_N-1:0] w_data,
    output logic [DATA_N-1:0] r8, r11,
    output logic [DATA_N-1:0] r0_data, r1_data
);
logic [4:0] ignor_regs = 5'd0;
logic [DATA_N-1:0] regs [0:SIZE-1];

 // Initial block to assign initial value to regs[11]
initial begin
	for(int i = 0; i<32; i++) begin 
		if(i == 11) 
			regs[i] = 32'd5;
		else
			regs[i] = 32'd0;
			end
end

always_ff @(posedge clk) begin
  if (wr_en) begin
		regs[w_addr] <= (w_addr == ignor_regs) ? 32'd0 : w_data;
  end
end

assign r8 = regs[5'd8];
assign r11 = regs[5'd11];

assign r0_data = regs[r0_addr];
assign r1_data = regs[r1_addr];

endmodule
