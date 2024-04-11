module MUX4_1#(parameter Width = 32)(
	input logic muxselect, jump,
	input logic [Width-1: 0] PC_added, PC_branch, PC_jump,
	output logic [Width - 1:0]PC_out,
	output logic flush
);
always_comb begin
	case(muxselect) 
		1'b1:begin
		 PC_out = PC_branch;
		 flush = 1'b0;	end
		1'b0: begin 
			if(jump) begin
				PC_out = PC_jump;
				flush = 1'b1;
				 end
			else begin
				PC_out = PC_added;
				flush = 1'b0;
				end
		end
	endcase
end
endmodule
