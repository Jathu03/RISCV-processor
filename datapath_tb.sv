`timescale 1ns / 1ps

module datapath_tb();

  // Define test signals
  reg clk;
  reg reset;

  datapath dut (
    .clk(clk),
    .reset(reset)
  );

  // Clock generation
  always begin
    #5 clk = ~clk; // Toggle the clock every 5 time units
  end

  initial begin 
    clk = 0;
    reset = 0;

	 #10 reset = 1;
	 #10 reset = 0;

    #1000 $finish;
  end



endmodule


