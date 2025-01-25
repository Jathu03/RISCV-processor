`include "controls.sv"

module alu #(
    parameter WIDTH = 32,    // Width of the ALU inputs and outputs
    parameter ALU_SEL = 4    // Number of bits for ALU operation selector
)(
    input logic signed [WIDTH-1:0] input_a, input_b,  // ALU inputs (signed)
    input logic [ALU_SEL-1:0] alu_sel,               // ALU operation selector
    output logic signed [WIDTH-1:0] alu_out,         // ALU result (signed)
    output logic alu_zero,                           // Zero flag (1 if alu_out is 0)
    output logic alu_neg                             // Negative flag (1 if alu_out is negative)
);

    // ALU operation logic
    always_comb begin
        unique case (alu_sel)
            `ALU_ADD:   alu_out = input_a + input_b;                      // Addition
            `ALU_SUB:   alu_out = input_a - input_b;                      // Subtraction
            `ALU_SLL:   alu_out = input_a << $unsigned(input_b);          // Logical left shift
            `ALU_SRL:   alu_out = input_a >> $unsigned(input_b);          // Logical right shift
            `ALU_SRA:   alu_out = input_a >>> $unsigned(input_b);         // Arithmetic right shift
            `ALU_AND:   alu_out = input_a & input_b;                      // Bitwise AND
            `ALU_OR:    alu_out = input_a | input_b;                      // Bitwise OR
            `ALU_XOR:   alu_out = input_a ^ input_b;                      // Bitwise XOR
            `ALU_SLT:   alu_out = (input_a < input_b) ? 1 : 0;            // Signed less than
            `ALU_SLTU:  alu_out = ($unsigned(input_a) < $unsigned(input_b)) ? 1 : 0;  // Unsigned less than
            `ALU_A:     alu_out = input_a;                                // Pass-through input_a
            `ALU_B:     alu_out = input_b;                                // Pass-through input_b
            `ALU_MUL:   alu_out = $unsigned(input_a) * $unsigned(input_b); // Unsigned multiplication
            default:    alu_out = 'b0;                                    // Default to zero
        endcase
    end

    // Zero flag: Set to 1 if the result is zero
    assign alu_zero = (alu_out == 0);

    // Negative flag: Set to 1 if the result is negative
    assign alu_neg = (alu_out < 0);

endmodule
