`timescale 1ns/1ps
module register_tb;
    reg [4:0] rs1, rs2, rd;
    reg [31:0] write_data;
    reg RegWrite, reset, clk;
    
    // Outputs
    wire [31:0] read_data1, read_data2;
    
    // Instantiate the module
    register hut (
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .RegWrite(RegWrite),
		  .clk(clk),
        .reset(reset)
    );
	 // Clock generation
    always begin
        #5 clk = ~clk;
    end
	 
    
    // Initialize signals
    initial begin
        rs1 = 0;
        rs2 = 0;
        rd = 0;
        write_data = 0;
        RegWrite = 0;
        reset = 0;
		  clk=0;

        // Apply reset
        reset = 1;
        #10 reset = 0;

        // Write data to register 5
        rd = 5;
        write_data = 32'hA47DEFFF;
        RegWrite = 1;
		  
		  #10
		  // Write data to register 5
        rd = 2;
        write_data = 32'h3EDCBA00;
        RegWrite = 1;
		  
        #15 RegWrite = 0;

        rs1 = 2;
        rs2 = 5;
        #10;
        $display("read_data1 = %h, read_data2 = %h", read_data1, read_data2);
        // End simulation
        $finish;
    end

    // Display results
    always @(read_data1, read_data2) begin
        $display("read_data1 = %h, read_data2 = %h", read_data1, read_data2);
    end

endmodule
