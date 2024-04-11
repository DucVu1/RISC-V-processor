module Forwarding_MUX #(parameter Depth = 32)(
	input logic [Depth - 1:0] EXMEM_register_data, IDEX_register_data, MEMWB_register_data,
	input logic [1:0] Mux_control,
	output logic [Depth - 1:0] Data_out
);

always_comb begin : MUX_3_1
	case (Mux_control) 
		2'b00 : Data_out = IDEX_register_data;
		2'b10 : Data_out = EXMEM_register_data;
		2'b01 : Data_out = MEMWB_register_data;
	default Data_out = IDEX_register_data;
	endcase
end
endmodule
