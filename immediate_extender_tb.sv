`timescale 1ns/1ps
module immediate_extender_tb;
    reg [31:0] instruction;
    wire [63:0] immediate;

    // Instantiate the immediate_extender module
    immediate_extender extender (
        .instruction(instruction),
        .immediate(immediate)
    );

    // Initialize values
    initial begin
        instruction = 32'h12345678; 
        #10;
        instruction = 32'h9ABCDEF0;
        #10;
        $finish;
    end

    // Display results
    always @(posedge instruction) begin
        $display("Instruction: 0x%h", instruction);
        $display("Extended Immediate: 0x%h", immediate);
    end

endmodule