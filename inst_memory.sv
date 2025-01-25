module inst_memory(
	input [31:0] pc,
	output reg [31:0] instruction
);
	logic [3:0][7:0] IM [0:NUM_INST-1];;   //Instruction Memory

	assign instruction = {IM[pc+3],IM[pc+2],IM[pc+1],IM[pc]};
	
	initial begin 
			
			//  add rd, rs1, rs2 -----> 0x00000033 
            IM[3] = 8'h00;
            IM[2] = 8'h00; 
            IM[1] = 8'h00;
            IM[0] = 8'h33;  //when PC_out=0
			
			//  sub rd, rs1, rs2 -----> 0x40000033
				IM[7] = 8'h40;
				IM[6] = 8'h00;
				IM[5] = 8'h00;
				IM[4] = 8'h33;  //when PC_out=4

			//  or rd, rs1, rs2  -----> 0x00006033
				IM[11] = 8'h00;
				IM[10] = 8'h00;
				IM[9] = 8'h60;
				IM[8] = 8'h33;

			//  and rd, rs1, rs2 -----> 0x00007033
				IM[15] = 8'h00;
				IM[14] = 8'h00;
				IM[13] = 8'h70;
				IM[12] = 8'h33;
			
			//  xor rd, rs1, rs2 -----> 0x00004033
				IM[19] = 8'h00;
				IM[18] = 8'h00;
				IM[17] = 8'h40;
				IM[16] = 8'h33;
			
			//  addi rd, rs1, imm -----> 0x00000013 
            IM[23] = 8'h00;
            IM[22] = 8'h00; 
            IM[21] = 8'h00;
            IM[20] = 8'h13; 
				
			//  ori rd, rs1, imm -----> 0x00006013 
            IM[27] = 8'h00;
            IM[26] = 8'h00; 
            IM[25] = 8'h60;
            IM[24] = 8'h13; 
			
			//  andi rd, rs1, imm -----> 0x00007013 
            IM[31] = 8'h00;
            IM[30] = 8'h00; 
            IM[29] = 8'h70;
            IM[28] = 8'h13; 
			
			//  xori rd, rs1, imm -----> 0x00004013 
            IM[35] = 8'h00;
            IM[34] = 8'h00; 
            IM[33] = 8'h40;
            IM[31] = 8'h13;
			
			//  beq rs1, rs2, offset -----> 0x00000063 
            IM[39] = 8'h00;
            IM[38] = 8'h00; 
            IM[37] = 8'h00;
            IM[36] = 8'h63;	
			
	end
endmodule
	
endmodule



