`include "controls.v"

module controller(
    input wire clk, rstn, ex_no_stay,    // External signal for not jumping
    input wire [31:0] instruction,
    output wire [30:0] ctrl_signals       // ctrl_signals size updated
);
    // Control store

  reg [2**8:0][0:29] control_store;
    
    /* Make the control address */
    reg [8:0] ctrl_addr;
    reg [6:0] opcode;
    reg [2:0] func3;
    
    assign opcode = instruction[6:0];
    assign func3 = instruction[14:12];
    
    // Assign bits of instruction to control address
    always @(*) begin
        ctrl_addr[8:4] = instruction[6:2];
        
        if (opcode == `TYPE_R ||    
            (opcode == `TYPE_I_COMP && func3 == 3'b101)) 
            ctrl_addr[0] = instruction[30];
        else 
            ctrl_addr[0] = 1'b0;
            
        if (opcode == `TYPE_R ||
            opcode == `TYPE_I_COMP ||
            opcode == `TYPE_I_LOAD ||
            opcode == `TYPE_I_JALR ||
            opcode == `TYPE_S ||
            opcode == `TYPE_SB) 
            ctrl_addr[3:1] = func3;
        else 
            ctrl_addr[3:1] = 3'b0;
    end
    
    /* Next address logic */
    reg stay;
    reg [8:0] next_addr;
  reg [29] cur_ctrl;
    
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            stay <= 1'b0;
            next_addr <= 9'b0;
        end else begin
            stay <= (cur_ctrl[12] & (~ex_no_stay));
            next_addr <= cur_ctrl[8:0];
        end
    end
    
    // Select control signals based on the current state
    always @(*) begin
        if (stay) 
            cur_ctrl = control_store[next_addr];
        else 
            cur_ctrl = control_store[ctrl_addr];
    end
    
    // Output the control signals from the microinstruction
  assign ctrl_signals = cur_ctrl[29:9];
  always @(*) begin
    case (address)
      9'b011000000: control_memory[address] = {1'b1, 4'b0000, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 3'b000, 1'b0, 1'b0, 1'b0, 1'b0, 9'b000000000}; //add
      9'b011000001: control_memory[address] = {1'b0, 4'b1001, 1'b1, 1'b1, 1'b0, 1'b1, 2'b10, 1'b1, 2'b01, 3'b111, 1'b1, 1'b1, 1'b1, 1'b1, 9'b111111111};// sub
      9'b011000010: control_memory[address] = {1'b1, 4'b0101, 1'b1, 1'b0, 1'b1, 1'b0, 2'b11, 1'b0, 2'b10, 3'b101, 1'b0, 1'b1, 1'b0, 1'b1, 9'b010101010};
      9'b011000011: control_memory[address] = {1'b0, 4'b1100, 1'b0, 1'b1, 1'b0, 1'b1, 2'b00, 1'b1, 2'b11, 3'b011, 1'b1, 1'b1, 1'b0, 1'b0, 9'b111000000};
      9'b011000110: control_memory[address] = {1'b1,	4'b1001,	1'b0,	1'b0,	1'b0,	1'b0,	2'b00,	1'b0,	2'b00,	3'b000,	1'b0,	1'b0,	1'b0,	1'b0,	9'b000000000};
	    9'b011001000: control_memory[address]= {1'b1,	4'b0111,	1'b0,	1'b0,	1'b0,	1'b0,	2'b00,	1'b0,	2'b00,	3'b000,	1'b0,	1'b0,	1'b0,	1'b0,	9'b000000000}; // xor
      9'b011001010: control_memory[address]= {1'b1,	4'b0011,	1'b0,	1'b0,	1'b0,	1'b0,	2'b00,	1'b0,	2'b00,	3'b000,	1'b0,	1'b0,	1'b0,	1'b0,	9'b000000000}; // srl
      9'b011001011: control_memory[address] = {1'b1,	4'b0100,	1'b0,	1'b0,	1'b0,	1'b0,	2'b00,	1'b0,	2'b00,	3'b000,	1'b0,	1'b0,	1'b0,	1'b0,	9'b000000000}; // sra
      9'b011001100: control_memory[address]= {1'b1,	4'b0110,	1'b0,	1'b0,	1'b0,	1'b0,	2'b00,	1'b0,	2'b00,	3'b000,	1'b0,	1'b0,	1'b0,	1'b0,	9'b000000000}; // or
      9'b011001110: control_memory[address] = {1'b1,	4'b0101,	1'b0,	1'b0,	1'b0,	1'b0,	2'b00,	1'b0,	2'b00,	3'b000,	1'b0,	1'b0,	1'b0,	1'b0,	9'b000000000}; // and
	    9'b011001111: control_memory[address] = {1'b1,	4'b1100,	1'b0,	1'b0,	1'b0,	1'b0,	2'b00,	1'b0,	2'b00,	3'b000,	1'b0,	1'b0,	1'b0,	1'b0,	9'b000000000}; // mul
      9'b001000000: control_memory[address] = {1'b1,	4'b0000,	1'b1,	1'b0,	1'b0,	1'b0,	2'b00,	1'b0,	2'b00,	3'b000,	1'b0,	1'b0,	1'b0,	1'b0,	9'b000000000}; // addi
	    9'b001000100: control_memory[address] = {1'b1,	4'b1000,	1'b1,	1'b0,	1'b0,	1'b0,	2'b00,	1'b0,	2'b00,	3'b000,	1'b0,	1'b0,	1'b0,	1'b0,	9'b000000000}; // slti
	    9'b001000110: control_memory[address] = {1'b1,	4'b1001,	1'b1,	1'b0,	1'b0,	1'b0,	2'b00,	1'b0,	2'b00,	3'b000,	1'b0,	1'b0,	1'b0,	1'b0,	9'b000000000}; // sltiu
	    9'b001001000: control_memory[address] = {1'b1,	4'b0111,	1'b1,	1'b0,	1'b0,	1'b0,	2'b00,	1'b0,	2'b00,	3'b000,	1'b0,	1'b0,	1'b0,	1'b0,	9'b000000000}; // xori
	    9'b001001100: control_memory[address] = {1'b1,	4'b0110,	1'b1,	1'b0,	1'b0,	1'b0,	2'b00,	1'b0,	2'b00,	3'b000,	1'b0,	1'b0,	1'b0,	1'b0,	9'b000000000}; // ori
      default: control_memory[address] = 16'b0000000000000000; // Default case (if no match)
    endcase
end


endmodule
