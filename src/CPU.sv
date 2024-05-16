module CPU(
	input logic clk,rst,
	output logic [4:0] rs0,rs1,Register_dest,
	output logic ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite,//Deocde
	output logic [1:0] Aluop,ForwardA_signal, ForwardB_signal,
	output logic [31:0] PC_out, Instruction_in,Instruction_out,//fetch
	output logic [31:0] r8,r11,ReadData0, ReadData1,//Decode
	output logic [31:0] ALU_result2,
	output logic flush, Stall, Muxselect, Branch
);
//Instruction_out is the instruction at decode stage and Instruction_in is in the fetch stage
//funct3 = [14:12] , funct7 = [30], rs2 = [24:20], rs1 = [19:15], opcode = [6:0]
//PC_added is incemented by 4, PC_calculated is branch targeted
logic [31:0] Instruc_Address,Instruc_Address2, shifted_data1,PC_added,Branch_address,PC_in;
logic [31:0] Immediate_output, Immediate_output2, ReadData02, ReadData12, ALU_result, Jump_address2, shifted_data,Jump_address;
logic [31:0] ALU_result3, B_INPUT_ALU, Mem_read_data, Mem_read_data2, Write_data,A_INPUT_ALU, B_Pre_INPUT, ReadData13;
logic ALUSrc2, MemtoReg2, MemRead2, MemWrite2, Branch2, funct7_out, MemtoReg3,  MemRead3, MemWrite3, Branch3;
logic RegWrite4,RegWrite2,RegWrite3,MemtoReg4 ;
logic ALUSrc1, MemtoReg1, RegWrite1, MemRead1, MemWrite1, Branch1;
logic [1:0] Aluop1, Aluop2;
logic [3:0] Operation;
logic [2:0] funct3,funct32;
logic [4:0] Rs1, Rs2,Register_dest2, Register_dest3;
//Instruction fetch
MUX4_1 PC_MUX(.muxselect(Branch & Muxselect), .jump(Branch3), .PC_added(PC_added), .PC_branch(Branch_address), .PC_jump(Jump_address2),.flush(flush),.PC_out(PC_in));

program_counter program_counter(.clk(clk),.rst(rst),.Stall(Stall | flush),.PC_in(PC_in),.PC_out(PC_out));

PC_incremented PC_incremented(.PC_in(PC_out),.PC_out(PC_added)); //incremented by 4 

Instruction_Memory Instruction_Memory(.inst_address(PC_out),.instruction(Instruction_in));

IFID_register IFID_register(.clk(clk),.flush(Stall | flush), .Address_in(PC_out),.Instruction_in(Instruction_in),.Address_out(Instruc_Address),.Instruction_out(Instruction_out));

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//Instruction Decode
assign rs0 = Instruction_out[19:15];
assign rs1 = Instruction_out[24:20];

register_file register_file(.clk(clk),.wr_en(RegWrite4),.w_addr(Register_dest3),.r0_addr(Instruction_out[19:15]),.r1_addr(Instruction_out[24:20]),.w_data(Write_data),
.r8(r8),.r11(r11),.r0_data(ReadData0),.r1_data(ReadData1));

Immediate_generator Immediate_generator(.In(Instruction_out),.Out(Immediate_output));

FA_32bit Branch_Targert(.A(Instruc_Address), .B(shifted_data), .Cin(1'b0), .S(Branch_address));

Control_unit ControlUnit(.Opcode(Instruction_out[6:0]),.ALUSrc(ALUSrc1),.MemtoReg(MemtoReg1),.RegWrite(RegWrite1),.MemRead(MemRead1),.MemWrite(MemWrite1),.Branch(Branch1),.Aluop(Aluop1));

Control_Mux21 Control_unit_mux(.ALUSrc(ALUSrc1), .MemtoReg(MemtoReg1), .RegWrite(RegWrite1), .MemRead(MemRead1), .MemWrite(MemWrite1), .Branch(Branch1), .Stall(Stall), 
.ALUOp(Aluop1), .ALUSrc_out(ALUSrc), .MemtoReg_out(MemtoReg), .RegWrite_out(RegWrite), .MemRead_out(MemRead) , .MemWrite_out(MemWrite), .Branch_out(Branch), .ALUOp_out(Aluop));

Shift_left_1bit Shift_left_1bit(.in(Immediate_output),.out(shifted_data));

Comparator Comparator(.funct3(Instruction_out[14:12]),.ReadData0(ReadData0),.ReadData1(ReadData1),.Muxselect(Muxselect));

IDEX_register IDEX_register(.clk(clk),.funct7(Instruction_out[30]),.ALUSrc(ALUSrc),.Branch(Branch),.MemRead(MemRead),.MemWrite(MemWrite),.RegWrite(RegWrite),.MemtoReg(MemtoReg), .flush(Stall | flush),.ALUOp(Aluop),
.Address_in(Instruc_Address),.Immediate_value(Immediate_output),.Read_data0(ReadData0),.Read_data1(ReadData1),.funct3(Instruction_out[14:12]),.Register_dest(Instruction_out[11:7]),.IFID_registerRs1(Instruction_out[19:15]),.IFID_registerRs2(Instruction_out[24:20]),
.Address_out(Instruc_Address2),.Immediate_value_out(Immediate_output2),.Read_data0_out(ReadData02),.Read_data1_out(ReadData12),.funct7_out(funct7_out),.ALUSrc_out(ALUSrc2),.Branch_out(Branch2),
.MemRead_out(MemRead2),.MemWrite_out(MemWrite2),.RegWrite_out(RegWrite2),.MemtoReg_out(MemtoReg2),.ALUOp_out(Aluop2),.funct3_out(funct3),.Register_dest_out(Register_dest),.Rs1(Rs1),.Rs2(Rs2));

hazard_detection_unit HazardDetectionUnit(.IDEX_MemRead(MemRead2),.IDEX_RegisterRd(Register_dest),.IFID_RegisterRs1(Instruction_out[19:15]),.IFID_RegisterRs2(Instruction_out[24:20]),
.Stall(Stall));
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//Execute
ALU ALU(.A(A_INPUT_ALU),.B(B_INPUT_ALU),.Operation(Operation[3:1]), .Cin(Operation[0]), .Result(ALU_result)); 

ALU_Control ALU_Control(.ALUOp(Aluop2),.funct7(funct7_out),.funct3(funct3),.Operation(Operation));

Forwarding_MUX Forwarding_MUXA(.EXMEM_register_data(ALU_result2),.IDEX_register_data(ReadData02),.MEMWB_register_data(Write_data),.Mux_control(ForwardA_signal),.Data_out(A_INPUT_ALU));

Forwarding_MUX Forwarding_MUXB(.EXMEM_register_data(ALU_result2),.IDEX_register_data(ReadData12),.MEMWB_register_data(Write_data),.Mux_control(ForwardB_signal),.Data_out(B_Pre_INPUT));

Shift_left_1bit Shift_left_1bit2(.in(Immediate_output2),.out(shifted_data1));

MUX2_1 INPUTB_MUX(.A(B_Pre_INPUT), .B(Immediate_output2), .Option(ALUSrc2), .Out(B_INPUT_ALU));	

FA_32bit Jump_Target(.A(Instruc_Address2), .B(shifted_data1), .Cin(1'b0), .S(Jump_address));

ForwardingUnit ForwardingUnit(.IDEX_RegisterRs1(Rs1),.IDEX_RegisterRs2(Rs2),.EXMEM_RegisterRd(Register_dest2),.MEMWB_RegisterRd(Register_dest3),.EXMEM_RegWrite(RegWrite3),.MEMWB_RegWrite(RegWrite4),
.ForwardA(ForwardA_signal),.ForwardB(ForwardB_signal));

EXMEM_register EXMEM_register(.clk(clk),.Branch(Branch2),.MemRead(MemRead2),.MemWrite(MemWrite2),.RegWrite(RegWrite2),.MemtoReg(MemtoReg2),.flush( Stall | flush),.PC_calculated(Jump_address),.ALU_result(ALU_result),.Read_data1(ReadData12),
.Register_dest(Register_dest), .funct3_in(funct3),.PC_calculated_out(Jump_address2),.Branch_out(Branch3),.MemRead_out(MemRead3),.MemWrite_out(MemWrite3),.RegWrite_out(RegWrite3),.MemtoReg_out(MemtoReg3),
.ALU_result_out(ALU_result2),.Read_data1_out(ReadData13), .funct3_out(funct32),.Register_dest_out(Register_dest2));

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\

//Mem access
Data_memory Data_memory(.clk(clk),.MemWrite(MemWrite3),.MemRead(MemRead3), .funct3(funct32), .Write_data(ReadData13),.Address(ALU_result2),.Read_data(Mem_read_data));

MEMWB_register MEMWB_register(.clk(clk),.RegWrite(RegWrite3),.MemtoReg(MemtoReg3),.Read_data(Mem_read_data),.ALU_result(ALU_result2),.Register_dest(Register_dest2),.RegWrite_out(RegWrite4),
.MemtoReg_out(MemtoReg4),.Read_data_out(Mem_read_data2),.ALU_result_out(ALU_result3),.Register_dest_out(Register_dest3));
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//WriteBack

MUX2_1 WB_MUX(.A(ALU_result3), .B(Mem_read_data2), .Option(MemtoReg4), .Out(Write_data));

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
endmodule

