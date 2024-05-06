module ForwardingUpdate(
	input logic IDEX_RegWrite, EXMEM_RegWrite,
	input logic [4:0] RegisterRs1, RegisterRs2, IDEX_RegisterRd, EXMEM_RegisterRd,
	output logic [1:0] ForwardA, ForwardB
);
always_comb begin
	//ForwardA
	if (IDEX_RegWrite && (IDEX_RegisterRd != 0) && (IDEX_RegisterRd == RegisterRs1)) begin 
		ForwardA = 2'b10; end
	else if (EXMEM_RegWrite && (EXMEM_RegisterRd != 0) && !(IDEX_RegWrite && (IDEX_RegisterRd != 0) && (IDEX_RegisterRd == RegisterRs1)) && (EXMEM_RegisterRd == RegisterRs1)) begin 
		ForwardA = 2'b01; end
	else begin
		ForwardA = 2'b00; end
	//ForwardB
	if (IDEX_RegWrite && (IDEX_RegisterRd != 0) && (IDEX_RegisterRd == RegisterRs2)) begin 
		ForwardB = 2'b10; end
	else if (EXMEM_RegWrite && (EXMEM_RegisterRd != 0) && !(IDEX_RegWrite &&(IDEX_RegisterRd != 0) && (IDEX_RegisterRd == RegisterRs2)) && (EXMEM_RegisterRd == RegisterRs2)) begin 
		ForwardB = 2'b01; end
	else begin
		ForwardB = 2'b00; end
	end
endmodule
