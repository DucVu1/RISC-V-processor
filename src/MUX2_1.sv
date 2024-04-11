module MUX2_1#(parameter N = 32)(
	input logic [N-1:0] A, B,
	input logic Option,
	output logic [N-1:0] Out
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
