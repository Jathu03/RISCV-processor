module riscv_single_cycle_processor (
    input logic clk, rstn,
    output logic [31:0] x5, x6, x11, mem1
);	
    logic [31:0] instruction;
    logic [21-1:0] ctrl_signals;  // CTRL_SIZE is now 21
    logic ex_no_stay;
    
    controller ctrl_obj (
        .clk(clk),
        .rstn(rstn),
        .ex_no_stay(ex_no_stay),
        .instruction(instruction),
        .ctrl_signals(ctrl_signals)
    );
    
    datapath_mem data_obj (
        .clk(clk),
        .rstn(rstn),
        .ctrl_signals(ctrl_signals),
        .x5(x5),
        .x6(x6),
        .x11(x11),
        .mem1(mem1)
    );
    
endmodule
