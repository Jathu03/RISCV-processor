`timescale 1ns/1ps

module data_memory_tb;

    // Testbench signals
    reg [31:0] mem_addr;
    reg signed [31:0] mem_write_data;
    reg clk, rstn;
    reg mem_read, mem_write;
    reg [1:0] load_store_type;
    reg load_unsigned;
    wire signed [31:0] mem_read_data;
    wire [31:0] mem1;

    // Instantiate the module
    data_memory dut (
        .mem_addr(mem_addr),
        .mem_write_data(mem_write_data),
        .clk(clk),
        .rstn(rstn),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .load_store_type(load_store_type),
        .load_unsigned(load_unsigned),
        .mem_read_data(mem_read_data),
        .mem1(mem1)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock with 10ns period
    end

    // Test sequence
    initial begin
        // Initialize signals
        rstn = 0;
        mem_addr = 0;
        mem_write_data = 0;
        mem_read = 0;
        mem_write = 0;
        load_store_type = 0;
        load_unsigned = 0;

        // Reset memory
        #10 rstn = 1;

        // Test 1: Write a word to memory
        #10 mem_write = 1;
        mem_addr = 32'h10; // Address 16
        mem_write_data = 32'hDEADBEEF; // Data to write
        load_store_type = 2'b10; // Word write
        #10 mem_write = 0;

        // Test 2: Read back the word
        #10 mem_read = 1;
        mem_addr = 32'h10; // Address 16
        load_store_type = 2'b10; // Word read
        #10 mem_read = 0;

        $display("Test 2: Read word from memory. Data = %h", mem_read_data);

        // Test 3: Write a halfword to memory
        #10 mem_write = 1;
        mem_addr = 32'h14; // Address 20
        mem_write_data = 32'hBEEF; // Halfword data
        load_store_type = 2'b01; // Halfword write
        #10 mem_write = 0;

        // Test 4: Read back the halfword (signed)
        #10 mem_read = 1;
        mem_addr = 32'h14; // Address 20
        load_store_type = 2'b01; // Halfword read
        load_unsigned = 0;
        #10 mem_read = 0;

        $display("Test 4: Read signed halfword. Data = %h", mem_read_data);

        // Test 5: Write a byte to memory
        #10 mem_write = 1;
        mem_addr = 32'h18; // Address 24
        mem_write_data = 32'hAA; // Byte data
        load_store_type = 2'b00; // Byte write
        #10 mem_write = 0;

        // Test 6: Read back the byte (unsigned)
        #10 mem_read = 1;
        mem_addr = 32'h18; // Address 24
        load_store_type = 2'b00; // Byte read
        load_unsigned = 1;
        #10 mem_read = 0;

        $display("Test 6: Read unsigned byte. Data = %h", mem_read_data);

        // Test 7: Check specific memory location
        #10;
        $display("Memory location 4: %h", mem1);

        // End simulation
        #20;
        $stop;
    end

endmodule
