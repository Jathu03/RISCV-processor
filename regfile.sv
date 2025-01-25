module regfile (
    input logic [REG_BITS-1:0] read_reg1, read_reg2, write_reg,
    input logic signed [WIDTH-1:0] write_data,
    input logic write_en,
    input logic clk, rstn,
    output logic signed [WIDTH-1:0] read_data1, read_data2,
    output logic [WIDTH-1:0] x5, x6, x11
);
    localparameter WIDTH = 32,
    localparameter REG_COUNT = 32,
    localparameter REG_BITS = $clog2(REG_COUNT)
    // Register array
    logic [WIDTH-1:0] registers [REG_COUNT-1:0];

    // Read logic
    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];

    // Write logic
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            // Reset all registers to 0
            for (int i = 0; i < REG_COUNT; i++) begin
                registers[i] <= 'b0;
            end
        end else if (write_en && write_reg != 0) begin
            // Write to the register only if write_reg is not 0
            registers[write_reg] <= write_data;
        end
    end

    // Expose specific registers for observation
    assign x5 = registers[5];
    assign x6 = registers[6];
    assign x11 = registers[11];
endmodule
