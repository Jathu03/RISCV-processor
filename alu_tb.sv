`timescale 1ns/1ps

module alu_tb;

    // Testbench signals
    reg signed [31:0] bus_a, bus_b;
    reg [3:0] alu_sel;
    wire signed [31:0] alu_out;
    wire alu_zero, alu_neg;

    // Instantiate the ALU module
    alu dut (
        .bus_a(bus_a),
        .bus_b(bus_b),
        .alu_sel(alu_sel),
        .alu_out(alu_out),
        .alu_zero(alu_zero),
        .alu_neg(alu_neg)
    );

    // Test sequence
    initial begin
        // Test 1: Addition
        bus_a = 32'h00000005;
        bus_b = 32'h00000003;
        alu_sel = `ALU_ADD;
        #10 $display("Test 1 - Addition: alu_out = %h, alu_zero = %b, alu_neg = %b", alu_out, alu_zero, alu_neg);

        // Test 2: Subtraction
        bus_a = 32'h00000005;
        bus_b = 32'h00000008;
        alu_sel = `ALU_SUB;
        #10 $display("Test 2 - Subtraction: alu_out = %h, alu_zero = %b, alu_neg = %b", alu_out, alu_zero, alu_neg);

        // Test 3: Logical AND
        bus_a = 32'hFFFFFFFF;
        bus_b = 32'h0000FFFF;
        alu_sel = `ALU_AND;
        #10 $display("Test 3 - AND: alu_out = %h, alu_zero = %b, alu_neg = %b", alu_out, alu_zero, alu_neg);

        // Test 4: Logical OR
        alu_sel = `ALU_OR;
        #10 $display("Test 4 - OR: alu_out = %h, alu_zero = %b, alu_neg = %b", alu_out, alu_zero, alu_neg);

        // Test 5: Logical XOR
        alu_sel = `ALU_XOR;
        #10 $display("Test 5 - XOR: alu_out = %h, alu_zero = %b, alu_neg = %b", alu_out, alu_zero, alu_neg);

        // Test 6: Shift Left Logical
        bus_a = 32'h00000001;
        bus_b = 32'h00000002;
        alu_sel = `ALU_SLL;
        #10 $display("Test 6 - SLL: alu_out = %h, alu_zero = %b, alu_neg = %b", alu_out, alu_zero, alu_neg);

        // Test 7: Multiply
        bus_a = 32'h00000002;
        bus_b = 32'h00000003;
        alu_sel = `ALU_MUL;
        #10 $display("Test 7 - Multiply: alu_out = %h, alu_zero = %b, alu_neg = %b", alu_out, alu_zero, alu_neg);

        // Test 8: Set Less Than (Signed)
        bus_a = -32'd5;
        bus_b = 32'd3;
        alu_sel = `ALU_SLT;
        #10 $display("Test 8 - SLT: alu_out = %h, alu_zero = %b, alu_neg = %b", alu_out, alu_zero, alu_neg);

        // End simulation
        #10;
        $stop;
    end

endmodule
