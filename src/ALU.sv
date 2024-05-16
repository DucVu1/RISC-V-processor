module ALU#(parameter Width = 32) (
	input logic [2:0] Operation,
	input logic Cin,
	input logic [Width -1 : 0] A, B,
	output logic [Width - 1: 0] Result
);
logic [Width - 1 : 0] LU_Buffer, AU_buffer, Shift_buffer;
logic Cout, less_than;
always_comb begin
	case(Operation)
		3'b000: Result = LU_Buffer; //AND
		3'b001: Result = LU_Buffer; //OR
		3'b010: Result = LU_Buffer; //XOR
		3'b011: Result = AU_buffer; //Cin = 1 Sub, Cin = 0 Add
		3'b100: Result = Shift_buffer; //Right shift, Cin = 1 -> Arithmetic Cin = 0 -> Logic 
		3'b101: Result = Shift_buffer; //Left shift
		3'b110: Result = {31'b0,Cout}; //Set less than unsigned, need Cin = 1
		3'b111: Result = {31'b0, less_than}; //Set less than signed, need Cin = 1
	endcase
end
LU_32bit LogicUnit(.A(A), .B(B), .Operation(Operation[1:0]), .Result(LU_Buffer));
AU Adder(.A(A), .B(B), .Cin(Cin), .Cout(Cout), .Sum(AU_buffer));
barrel_shifter_32 shifter(.data(A), .amt(B[4:0]), .dir_lr(Operation[0]), .type_shift(Cin), .out(Shift_buffer));
SMcomparator SMcomparator(.A(A),.B(B), .Cout(Cout), .less_than(less_than));
endmodule
