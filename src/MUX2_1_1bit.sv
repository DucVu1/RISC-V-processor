module MUX2_1_1bit(
	input logic A, B,
	input logic Option,
	output logic Out
);
always_comb begin: Multiplexor_2_1
	if(Option) begin 
		Out = B;
		end
	else begin 
		Out = A;
		end
	end
endmodule
