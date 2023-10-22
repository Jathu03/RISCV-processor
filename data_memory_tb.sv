`timescale 1ns/1ps
module data_memory_tb;
    // Inputs
    reg MemRead, MemWrite, clk;
    reg [31:0] address, write_data;
    
    // Outputs
    wire [31:0] read_data;

    // Instantiate the module
    data_memory uut (
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .address(address),
        .write_data(write_data),
        .read_data(read_data),
        .clk(clk)
    );
	 // Clock generation
    always begin
        #5 clk = ~clk;
    end
    // Initialize signals
    initial begin
        MemRead = 0;
        MemWrite = 0;
        clk = 0;
        address = 0;
        write_data = 0;
		  
		  // Apply memory read operation
		  MemWrite = 0;
        MemRead = 1;
        address = 2;
		  
		  #10
        // Apply memory write operation
		  MemRead = 0;
        MemWrite = 1;
        address = 7;
        write_data = 32'h16CDEFFF;
        #10 
        // Apply memory read operation
		  MemWrite = 0;
        MemRead = 1;
        address = 3;
        #10 
		  MemRead = 0;

        // End simulation
        $finish;
    end

    // Display results
    always @(read_data) begin
        $display("read_data = %h", read_data);
    end

endmodule
