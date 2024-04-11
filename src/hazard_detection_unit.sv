module hazard_detection_unit(
	input logic IDEX_MemRead, 
	input logic [4:0] IDEX_RegisterRd, IFID_RegisterRs1, IFID_RegisterRs2,
	output logic Stall
);

always_comb begin 
	if ( IDEX_MemRead && ((IDEX_RegisterRd == IFID_RegisterRs1) || (IDEX_RegisterRd == IFID_RegisterRs2))) begin 
		Stall = 1'b1;
		end
	else begin 
		Stall = 1'b0; 
		end
	end
endmodule
