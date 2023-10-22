`timescale 1ns/1ns
module alu_control_tb;

  // Define constants for ALUOp values
  parameter ALUOP1 = 2'b00;
  parameter ALUOP2 = 2'b01;
  parameter ALUOp_R_TYPE = 2'b10;
  
  // Define constants for instruction codes in binary format
  parameter ADD_INSTRUCTION = 32'b00000000000000000000000000000010; //check
  parameter SUB_INSTRUCTION = 32'b01000000000000000000000000000010; //check
  parameter AND_INSTRUCTION = 32'b00000000000000000000000011100011; //check
  parameter OR_INSTRUCTION  = 32'b00000000000000000110110000110010; //check

  // Define signals
  reg [31:0] instruction;
  reg [1:0] ALUOp;
  wire [3:0] ALUControl;

  // Instantiate the alu_control module
  alu_control uut (
    .instruction(instruction),
    .ALUOp(ALUOp),
    .ALUControl(ALUControl)
  );

  // Initialize signals and test cases
  initial begin
    instruction = OR_INSTRUCTION;
    ALUOp = ALUOp_R_TYPE;
    #10;

    // Add more test cases as needed
    
    $finish;
  end

  // Display results
  always @* begin
    $display("Instruction Code: %b", instruction_code);
    $display("ALUOp: %b", ALUOp);
    $display("ALUControl: %b", ALUControl);
	 $display("ALU: %b", OR_INSTRUCTION[14:12]);
	 $display("ALU: %b", OR_INSTRUCTION[19:17]);
  end

endmodule
