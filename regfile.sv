module regfile (
    input logic [4:0] read_reg1, read_reg2, write_reg, // 5 bits for 32 registers
    input logic signed [31:0] write_data,             // 32-bit data
    input logic write_en,
    input logic clk, rstn,
    output logic signed [31:0] read_data1, read_data2,
    output logic [31:0] x5, x6, x11
);
    // 32 registers, each 32 bits wide
    logic [31:0] registers [31:0];

    // Read operations
    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];

    // Write operation and reset logic
    always @(posedge clk or negedge rstn) begin
        if (~rstn) begin
            for (int i = 0; i < 32; i++) registers[i] <= 32'b0;
        end else if (write_en && write_reg) begin
            registers[write_reg] <= write_data;
        end
    end

    // Observation for specific registers
    assign x5 = registers[5];
    assign x6 = registers[6];
    assign x11 = registers[11];
endmodule
