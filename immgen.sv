`include "controls.sv"

module immgen (
	input logic [31:0] inst,
	output logic signed [31:0] imm_out
);
	logic [6:0] opcode;
	logic [3:0] func3;
	
	assign opcode = inst[6:0];
	assign func3 = inst[14:12];
	
	always_comb begin
		if (opcode == `TYPE_I_COMP && func3 == 3'b101)	// Shift right immediate
			imm_out = {27'b0, inst[24:20]};
			
		else if (opcode == `TYPE_I_COMP ||
				   opcode == `TYPE_I_LOAD ||
				   opcode == `TYPE_I_JALR)
			imm_out = {{20{inst[31]}}, inst[31:20]};
		
		else if (opcode == `TYPE_S)
			imm_out = {{20{inst[31]}}, inst[31:25], inst[11:7]};
			
		else if (opcode == `TYPE_SB)
			imm_out = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
			
		else if (opcode == `TYPE_U_LUI ||
					opcode == `TYPE_U_AUIPC)
			imm_out = {inst[31:12], 12'b0};
			
		else if (opcode == `TYPE_UJ)
			imm_out = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:25], inst[24:21], 1'b0};
			
		else if (opcode == `TYPE_MEMCPY)
			imm_out = {25'b0, inst[31:25]};
			
		else
			imm_out = 32'b0;
	end 

endmodule
