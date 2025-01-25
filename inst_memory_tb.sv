`timescale 1ns/1ps
module instruction_memory_tb;
    reg [31:0] PC_out;
    wire [31:0] instruction;

    // Instantiate the instruction_memory module
    instruction_memory dut (
        .pc(PC_out),
        .instruction(instruction)
    );

    // Initial values
    initial begin
        PC_out = 0; // Start reading from the beginning of memory

        // Wait for some time
        #10;

        // Read the instruction at PC
        $display("Instruction at PC %h: %h", PC_out, instruction);

        // Change PC and read another instruction
        PC_out = 4; // Move to the next instruction
        #10;
        $display("Instruction at PC %h: %h", PC_out, instruction);

        // Add more PC changes and instruction reads as needed

        $finish;
    end



// Simulate the testbench
initial begin
    $dumpfile("instruction_memory_tb.vcd");
    $dumpvars(0, instruction_memory_tb);
    $display("Starting simulation...");
    // Run simulation for a while
    #100;
    $finish;
end

endmodule
