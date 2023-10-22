`timescale 1ns/1ps

module alu_tb;
    reg [31:0] in1, in2;
    reg [3:0] alu_control;
    wire [31:0] alu_result;
    wire zero_flag;

    // Instantiate the ALU module
    alu uut (
        .input1(input1),
        .input2(input2),
        .alu_control(alu_control),
        .alu_result(alu_result),
        .zero_flag(zero_flag)
    );

    // Initialize inputs
    initial begin
        input1 = 32'h0000_1234;
        input2 = 32'h0000_5678;
        alu_control = 4'b0011; // Perform addition

        // Perform other operations by changing alu_control
        #10 alu_control = 4'b0001; // Perform AND
        #10 alu_control = 4'b0010; // Perform OR
        #10 alu_control = 4'b0100; // Perform subtraction

        // Add more test cases as needed

        // Stop the simulation
        $finish;
    end

    // Display results
    always @(alu_result, zero_flag) begin
        $display("ALU Result: %h, Zero Flag: %b", alu_result, zero_flag);
    end
endmodule
