module processor_fpga (
    input logic clk, rstn,
    output logic [6:0] out1, out2, out3, out4, out5, out6, out7  // 7 segment outputs
);

    // Define register width and count
    logic [31:0] x5, x6, x11, mem1;
    
    // Instantiating riscv_single_cycle_processor with hardcoded values
    riscv_single_cycle_processor proc (
        .clk(clk),
        .rstn(rstn),
        .x5(x5),
        .x6(x6),
        .x11(x11),
        .mem1(mem1)
    );
    
    /* 7 segment outputs */
    logic [3:0] one1, one2, ten1, ten2, one3, ten3;

    assign one1 = x5[3:0];
    assign ten1 = x5[7:4];
    assign one2 = x6[3:0];
    assign ten2 = x6[7:4];
    assign one3 = x11[3:0];
    assign ten3 = x11[7:4];
    
    // Connecting binary to 7-segment display modules
    binary_to_7seg ss1 (
        .data_in(one1), 
        .data_out(out2)
    );
    
    binary_to_7seg ss2 (
        .data_in(ten1), 
        .data_out(out1)
    );
    
    binary_to_7seg ss3 (
        .data_in(one2), 
        .data_out(out4)
    );
    
    binary_to_7seg ss4 (
        .data_in(ten2), 
        .data_out(out3)
    );
    
    binary_to_7seg ss5 (
        .data_in(one3), 
        .data_out(out5)
    );
    
    binary_to_7seg ss6 (
        .data_in(ten3), 
        .data_out(out6)
    );
    
    binary_to_7seg ss7 (
        .data_in(mem1[3:0]), 
        .data_out(out7)
    );

endmodule
