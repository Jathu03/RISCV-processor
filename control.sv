module control(
	input [31:0] instruction,
	output reg Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jump,
	output reg [1:0] ALUOp
	
);
assign Branch = (instruction[6:0]==1101111) ? 1'b1 : 1'b0; //B Type
assign MemRead = (instruction[6:0]==0000011) ? 1'b1 : 1'b0; //Load
assign MemtoReg = (instruction[6:0]==0000011) ? 1'b1 : 1'b0; //Load
assign MemWrite = (instruction[6:0]==0100011) ? 1'b1 : 1'b0; //Store
assign RegWrite = ((instruction[6:0]==0000011) | (instruction[6:0]==0110011)) ? 1'b1 : 1'b0; //Load + alu results
assign ALUSrc = (instruction[6:0]==0010011) ? 1'b1 : 1'b0; //I type
assign ALUOp[0] = (instruction[6:0]==1100011) ? 1'b1 : 1'b0; //BEQ Type
assign ALUOp[1] = (instruction[6:0]==0110011) ? 1'b1 : 1'b0; //R Type

endmodule 