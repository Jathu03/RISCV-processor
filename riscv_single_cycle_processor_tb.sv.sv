module tb_riscv_single_cycle_processor;

    // Testbench signals
    logic clk;
    logic rstn;
    logic [31:0] x5, x6, x11, mem1;
    
    // Instantiate the DUT (Design Under Test)
    riscv_single_cycle_processor uut (
        .clk(clk),
        .rstn(rstn),
        .x5(x5),
        .x6(x6),
        .x11(x11),
        .mem1(mem1)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // Toggle clock every 5ns
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        rstn = 0;

        // Reset the processor
        #10;
        rstn = 1;

        // Provide some instruction or stimulus
        // Example: Set the instruction for the processor
        uut.instruction = 32'b00000000000000000000000000010011; // Sample instruction (modify as per your test)
        
        // Wait for some cycles
        #100;
        
        // Check outputs (x5, x6, x11, mem1) at this point
        $display("x5 = %h, x6 = %h, x11 = %h, mem1 = %h", x5, x6, x11, mem1);
        
        // End of simulation
        $finish;
    end

endmodule
