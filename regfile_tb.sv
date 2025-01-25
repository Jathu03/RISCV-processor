`timescale 1ns/1ps

module regfile_tb;

    // Parameters
    parameter WIDTH = 32;
    parameter REG_COUNT = 32;
    parameter REG_BITS = $clog2(REG_COUNT);

    // Testbench signals
    reg [REG_BITS-1:0] read_reg1, read_reg2, write_reg;
    reg signed [WIDTH-1:0] write_data;
    reg write_en;
    reg clk, rstn;
    wire signed [WIDTH-1:0] read_data1, read_data2;
    wire [WIDTH-1:0] x5, x6, x11;

    // Instantiate the regfile module
    regfile #(
        .WIDTH(WIDTH),
        .REG_COUNT(REG_COUNT),
        .REG_BITS(REG_BITS)
    ) dut (
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .write_en(write_en),
        .clk(clk),
        .rstn(rstn),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .x5(x5),
        .x6(x6),
        .x11(x11)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test procedure
    initial begin
        // Initialize signals
        rstn = 0;
        write_en = 0;
        write_reg = 0;
        write_data = 0;
        read_reg1 = 0;
        read_reg2 = 0;

        // Reset the registers
        #10 rstn = 1;
        #10;

        // Test 1: Write to register 5
        write_en = 1;
        write_reg = 5;
        write_data = 32'd42;
        #10 write_en = 0;

        // Test 2: Write to register 6
        write_en = 1;
        write_reg = 6;
        write_data = 32'd100;
        #10 write_en = 0;

        // Test 3: Write to register 11
        write_en = 1;
        write_reg = 11;
        write_data = 32'd77;
        #10 write_en = 0;

        // Test 4: Read from registers 5 and 6
        read_reg1 = 5;
        read_reg2 = 6;
        #10;
        $display("Read Test: reg5=%d, reg6=%d", read_data1, read_data2);

        // Test 5: Observe specific registers
        #10;
        $display("Registers: x5=%d, x6=%d, x11=%d", x5, x6, x11);

        // Test 6: Attempt to write to register 0 (should not change)
        write_en = 1;
        write_reg = 0;
        write_data = 32'd123;
        #10 write_en = 0;

        // Confirm register 0 remains zero
        read_reg1 = 0;
        #10;
        $display("Register 0 Test: reg0=%d", read_data1);

        // End simulation
        #20;
        $stop;
    end

endmodule
