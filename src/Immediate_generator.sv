module Immediate_generator #(parameter Width = 32)(
	input logic [Width-1:0] In,
	output logic [Width-1:0] Out);
always_comb begin
	case(In[6:0])
		7'b0000011 : Out = {{(32-12){In[31]}},In[31:20]}; //I-type for load Instruction 
		7'b0100011 : Out = {{(32-12){In[31]}},In[31:25],In[11:7]}; //S-type Instruction
		7'b1100011 : Out = {{(32-12){In[31]}},In[31],In[7],In[30:25],In[11:8]}; //B-type Instruction 
		7'b0010011 : Out = {{(32-12){In[31]}},In[31:20]}; //I-type for arithmetic Instruction
		7'b1100111 : Out = {{(32-12){In[31]}},In[31:20]}; // Jump 
		7'b1101111 : Out = {{(32-20){In[31]}},In[31],In[19:12],In[20],In[30:21]};//Jump and Link
	default : Out = 32'd0;
endcase
end
endmodule
