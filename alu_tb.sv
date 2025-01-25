`timescale 1ns/1ps

module regfile_tb;

    // Testbench signals
    reg [4:0] read_reg1, read_reg2, write_reg;
    reg signed [31:0] write_data;
    reg write_en, clk, rstn;
    wire signed [31:0] read_data1, read_data2;
    wire [31:0] x5, x6, x11;

    // Instantiate the module
    regfile dut (
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

    // Test sequence
    initial begin
        // Initialize signals
        rstn = 0;
        write_en = 0;
        read_reg1 = 0;
        read_reg2 = 0;
        write_reg = 0;
        write_data = 0;

        // Reset registers
        #10 rstn = 1;

        // Test 1: Write data to register 5
        #10 write_en = 1;
        write_reg = 5;
        write_data = 32'hA5A5A5A5;
        #10 write_en = 0;

        // Test 2: Write data to register 6
        #10 write_en = 1;
        write_reg = 6;
        write_data = 32'h5A5A5A5A;
        #10 write_en = 0;

        // Test 3: Read data from registers 5 and 6
        #10 read_reg1 = 5;
        read_reg2 = 6;

        #10 $display("Test 3: Read data1 = %h, Read data2 = %h", read_data1, read_data2);

        // Test 4: Write data to register 11
        #10 write_en = 1;
        write_reg = 11;
        write_data = 32'h12345678;
        #10 write_en = 0;

        // Test 5: Observe specific registers
        #10 $display("Test 5: x5 = %h, x6 = %h, x11 = %h", x5, x6, x11);

        // End simulation
        #20;
        $stop;
    end

endmodule
