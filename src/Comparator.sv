module Comparator(
	input logic [2:0] funct3,
	input logic [31:0] ReadData0, ReadData1,
	output logic Muxselect
);

always_comb begin 
	case(funct3)
		3'b000: Muxselect = (ReadData0 == ReadData1)? 1'b1:1'b0;
		3'b001: Muxselect = (ReadData0 != ReadData1) ?1'b1:1'b0;
		3'b100: Muxselect = (ReadData0 < ReadData1) ? 1'b1 : 1'b0;
		3'b101: Muxselect = (ReadData0 >= ReadData1) ? 1'b1: 1'b0;
		3'b110: Muxselect = (ReadData0 < ReadData1) ? 1'b1: 1'b0;
		3'b111: Muxselect = (ReadData0 >= ReadData1) ? 1'b1: 1'b0;
		default: Muxselect = 1'b0;
	endcase
end 
endmodule
