module program_counter#(parameter Width = 32)(
	input logic clk, rst, Stall,
	input logic [Width - 1:0] PC_in,
	output logic [Width - 1:0] PC_out
);
logic [Width - 1:0] PC_saved;
always_ff@(posedge clk) begin: program_counter
	if(rst) begin 
		PC_out <= 32'd0;
		PC_saved <= 32'd0;
	end
	else begin
		if (!Stall) begin 
			PC_out <= PC_in; 
			PC_saved <= PC_in;
			end
		else begin 
			PC_out <= PC_saved;
			end
	end
end
endmodule
	
