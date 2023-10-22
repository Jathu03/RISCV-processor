module datapath(
	input clk,
	input reset
);

//input & output ports of registers
reg [31:0] instruction;
reg rd;
reg [31:0] write_data;
reg [31:0] read_data1;
reg [31:0] read_data2;

//input & output ports of  ALU
reg [31:0] alu_result;
reg [31:0] in2;
reg [3:0] ALUControl;
reg zero_flag;

//input & output ports of data memory 
reg MemRead;
reg MemWrite;
reg [31:0] read_data;

//ports of control
reg Branch;
reg MemtoReg;
reg ALUSrc;
reg [1:0] ALUOp;

reg [31:0] PC_out;
reg jump;
reg branch;
reg [31:0] PC_in;

reg [11:0] immediate;

assign input2 = (ALUSrc) ? immediate:read_data2;
assign write_data = (MemtoReg) ? read_data:alu_result;
assign branch = Branch && zero_flag;

assign PC_in = (branch) ? (immediate+PC_out):PC_out;  //branch mux

register Register(
	.rs1(instruction [19:15]),
	.rs2(instruction [24:20]),
	.rd(instruction [11:7]),		//ins
	.write_data(write_data),
	.read_data1(read_data1),		
	.read_data2(read_data2),		//
	.RegWrite(RegWrite),
	.clk(clk),
	.reset(reset)
);

data_memory Memory(
	.MemRead(MemRead),
	.MemWrite(MemWrite),
	.address(alu_result),
	.write_data(read_data2),
	.read_data(read_data),
	.clk(clk)
	
);

alu ALU(
    .input1(read_data1),
	 .input2(input2),
    .alu_control(ALUControl),
    .alu_result(alu_result), 
    .zero_flag(zero_flag) 
);

program_counter programm_counter(
	.clk(clk),
	.reset(reset),
	.PC_in(PC_in),
	.PC_out(PC_out)
);

instruction_memory instruction_memory(
	.PC_out(PC_out),
	//input reset,
	.instruction(instruction)
);

control control(
	.instruction(instruction),
	.Branch(Branch),
	.MemRead(MemRead),
	.MemtoReg(MemtoReg),
	.MemWrite(MemWrite),
	.ALUSrc(ALUSrc),
	.RegWrite(RegWrite),
	.ALUOp(ALUOp)	
);

alu_control alu_control(
    .instruction(instruction),
    .ALUOp(ALUOp),
    .ALUControl(ALUControl)
);
immediate_extender(
	 .instruction(instruction),
	 .immediate(immediate)
);

endmodule 