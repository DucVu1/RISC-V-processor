module Forwarding_MUX_Comparator #(parameter Depth = 32)(
	input logic [Depth - 1:0] ALU_data, register_data, Memory_data,
	input logic [1:0] Mux_control,
	output logic [Depth - 1:0] Data_out
);

always_comb begin : MUX_3_1
	case (Mux_control) 
		2'b00 : Data_out = register_data;
		2'b10 : Data_out = ALU_data;
		2'b01 : Data_out = Memory_data;
	default Data_out = register_data;
	endcase
end
endmodule
