`include "controls.sv"

module data_memory (
    input logic [31:0] mem_addr,
    input logic signed [31:0] mem_write_data,
    input logic clk, rstn,
    input logic mem_read, mem_write, // control signals
    input logic [1:0] load_store_type, 
    input logic load_unsigned,
    output logic signed [31:0] mem_read_data,
    output logic [31:0] mem1
);

    // Fixed configurations
    localparam NUM_LOCS = 64; // Number of 32-bit words

    // Memory: NUM_LOCS locations with 4 bytes each
    logic [3:0][7:0] memory [NUM_LOCS-1:0];

    // Read operation
    always_comb begin
        if (mem_read) begin
            mem_read_data[7:0] = memory[mem_addr >> 2][mem_addr & 'b11];

            case (load_store_type)
                `LS_BYTE: begin
                    if (load_unsigned) mem_read_data[31:8] = 24'b0;
                    else mem_read_data[31:8] = {24{mem_read_data[7]}};
                end
                `LS_HALF: begin
                    mem_read_data[15:8] = memory[(mem_addr + 1) >> 2][(mem_addr + 1) & 'b11];
                    if (load_unsigned) mem_read_data[31:16] = 16'b0;
                    else mem_read_data[31:16] = {16{mem_read_data[15]}};
                end
                `LS_WORD: begin
                    mem_read_data[15:8] = memory[(mem_addr + 1) >> 2][(mem_addr + 1) & 'b11];
                    mem_read_data[23:16] = memory[(mem_addr + 2) >> 2][(mem_addr + 2) & 'b11];
                    mem_read_data[31:24] = memory[(mem_addr + 3) >> 2][(mem_addr + 3) & 'b11];
                end
                default: mem_read_data = 32'b0;
            endcase
        end else mem_read_data = 32'b0;
    end

    // Write operation
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            for (int i = 0; i < NUM_LOCS; i++) memory[i] <= 32'b0;
        end else if (mem_write) begin
            for (int b = 0; b <= load_store_type; b++) begin
                memory[(mem_addr + b) >> 2][(mem_addr + b) & 'b11] = mem_write_data[8 * b +: 8];
            end
        end
    end

    // Observing memory location 4
    assign mem1 = memory[4];

endmodule
