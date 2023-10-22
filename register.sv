module register(
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2,
    input RegWrite,
    input clk,
    input reset
);

    reg [31:0] memory [31:0];

    // Initial values for reg_memory
    initial begin
        for (int i = 0; i < 32; i = i + 1) begin
            memory[i] = i;
        end
    end

    assign read_data1 = memory[rs1];
    assign read_data2 = memory[rs2];

    always @(posedge clk) begin
        if (reset) begin
            // Reset values for reg_memory
            for (int i = 0; i < 32; i = i + 1) begin
                memory[i] = i;
            end
        end else if (RegWrite) begin
            memory[rd] = write_data;
        end
    end
endmodule 