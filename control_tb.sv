`timescale 1ns/1ps
module control_tb;

  // Define constants for instruction codes
  parameter R_TYPE = 7'b0110011;
  parameter S_TYPE = 7'b0100011;
  parameter BEQ_TYPE = 7'b1100011;
  parameter LOAD_TYPE = 7'b0000011;
  parameter ADDI_TYPE = 7'b0010011;

  // Define signals
  reg [31:0] instruction_code;
  wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jump;
  wire [1:0] ALUOp;

  // Instantiate the control module
  control uut (
    .instruction_code(instruction_code),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .ALUOp(ALUOp)
  );

  // Initialize instruction_code
  initial begin
    instruction_code = 0;
    #10;
    
    // Test BEQ instruction
    instruction_code = BEQ_TYPE;
    #10;
    
    // Test LOAD instruction
    instruction_code = LOAD_TYPE;
    #10;
    
    // Test ADDI instruction
    instruction_code = ADDI_TYPE;
    #10;
    
    // Add more test cases for other instruction types if needed
    // ...

    $finish;
  end

  // Display results
  always @* begin
    $display("Branch: %b", Branch);
    $display("MemRead: %b", MemRead);
    $display("MemtoReg: %b", MemtoReg);
    $display("MemWrite: %b", MemWrite);
    $display("ALUSrc: %b", ALUSrc);
    $display("RegWrite: %b", RegWrite);
    $display("ALUOp: %b", ALUOp);
	 $display("ALU: %b", instruction_code[6:0]);
  end

endmodule
