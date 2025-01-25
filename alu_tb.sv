`timescale 1ns/1ps
`include "controls.sv"  // Include control definitions

module alu_tb;

    // Parameters
    parameter WIDTH = 32;
    parameter ALU_SEL = 4;

    // Testbench signals
    reg signed [WIDTH-1:0] input_a, input_b; // ALU inputs
    reg [ALU_SEL-1:0] alu_sel;              // ALU operation selector
    wire signed [WIDTH-1:0] alu_out;        // ALU result
    wire alu_zero;                          // Zero flag
    wire alu_neg;                           // Negative flag

    // Instantiate the ALU module
    alu #(
        .WIDTH(WIDTH),
        .ALU_SEL(ALU_SEL)
    ) dut (
        .input_a(input_a),
        .input_b(input_b),
        .alu_sel(alu_sel),
        .alu_out(alu_out),
        .alu_zero(alu_zero),
        .alu_neg(alu_neg)
    );

    // Testbench procedure
    initial begin
        // Test 1: Addition
        input_a = 32'd10;
        input_b = 32'd5;
        alu_sel = `ALU_ADD;
        #10;
        $display("Test 1: ADD | input_a: %d, input_b: %d, alu_out: %d, alu_zero: %b, alu_neg: %b", 
                 input_a, input_b, alu_out, alu_zero, alu_neg);

        // Test 2: Subtraction
        input_a = 32'd10;
        input_b = 32'd15;
        alu_sel = `ALU_SUB;
        #10;
        $display("Test 2: SUB | input_a: %d, input_b: %d, alu_out: %d, alu_zero: %b, alu_neg: %b", 
                 input_a, input_b, alu_out, alu_zero, alu_neg);

        // Test 3: AND
        input_a = 32'b1100;
        input_b = 32'b1010;
        alu_sel = `ALU_AND;
        #10;
        $display("Test 3: AND | input_a: %b, input_b: %b, alu_out: %b", input_a, input_b, alu_out);

        // Test 4: OR
        input_a = 32'b1100;
        input_b = 32'b1010;
        alu_sel = `ALU_OR;
        #10;
        $display("Test 4: OR | input_a: %b, input_b: %b, alu_out: %b", input_a, input_b, alu_out);

        // Test 5: SLT (Signed Less Than)
        input_a = -32'd10;
        input_b = 32'd5;
        alu_sel = `ALU_SLT;
        #10;
        $display("Test 5: SLT | input_a: %d, input_b: %d, alu_out: %d", input_a, input_b, alu_out);

        // Test 6: Multiplication
        input_a = 32'd7;
        input_b = 32'd6;
        alu_sel = `ALU_MUL;
        #10;
        $display("Test 6: MUL | input_a: %d, input_b: %d, alu_out: %d", input_a, input_b, alu_out);

        // Test 7: Zero result
        input_a = 32'd0;
        input_b = 32'd0;
        alu_sel = `ALU_ADD;
        #10;
        $display("Test 7: Zero Result | input_a: %d, input_b: %d, alu_out: %d, alu_zero: %b", 
                 input_a, input_b, alu_out, alu_zero);

        $stop; // Stop simulation
    end

endmodule
