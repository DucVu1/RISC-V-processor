module ForwardingUnit(
	input logic [4:0] IDEX_RegisterRs1, IDEX_RegisterRs2,EXMEM_RegisterRd,MEMWB_RegisterRd,
	input logic EXMEM_RegWrite, MEMWB_RegWrite,
	output logic[1:0] ForwardA, ForwardB
);

always_comb begin
	//ForwardA
	if (EXMEM_RegWrite && (EXMEM_RegisterRd != 0) && (EXMEM_RegisterRd == IDEX_RegisterRs1)) begin 
		ForwardA = 2'b10; end
	else if (MEMWB_RegWrite && (MEMWB_RegisterRd != 0) && !(EXMEM_RegWrite && (EXMEM_RegisterRd != 0) && (EXMEM_RegisterRd == IDEX_RegisterRs1)) && (MEMWB_RegisterRd == IDEX_RegisterRs1)) begin 
		ForwardA = 2'b01; end
	else begin
		ForwardA = 2'b00; end
	//ForwardB
	if (EXMEM_RegWrite && (EXMEM_RegisterRd != 0) && (EXMEM_RegisterRd == IDEX_RegisterRs2)) begin 
		ForwardB = 2'b10; end
	else if (MEMWB_RegWrite && (MEMWB_RegisterRd != 0) && !(EXMEM_RegWrite &&(EXMEM_RegisterRd != 0) && (EXMEM_RegisterRd == IDEX_RegisterRs2)) && (MEMWB_RegisterRd == IDEX_RegisterRs2)) begin 
		ForwardB = 2'b01; end
	else begin
		ForwardB = 2'b00; end
	end
endmodule
	
	
