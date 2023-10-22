`timescale 1ns/1ps
module program_counter_tb;
  parameter CLOCK_PERIOD = 10;

  reg clk= 1'b0;
  reg reset = 1'b0;
  reg [31:0] PC_in = 32'h00000000;
  wire [31:0] PC_out;
//Instantiate the program counter module
  program_counter pc (
    .clk(clk),
    .reset(reset),
    .PC_in(PC_in),
    .PC_out(PC_out)
  );

	  always  begin
		 #10 clk = ~clk; 
	
	  end

   initial begin
    
    PC_in <= 32'h00000000;
    reset <= 1'b0;

    $finish;
  end

endmodule
