`include "controls.sv"

module alu (
    input logic signed [31:0] bus_a, bus_b,  // Fixed WIDTH = 32
    input logic [3:0] alu_sel,              // Fixed ALU_SEL = 4
    output logic signed [31:0] alu_out,
    output logic alu_zero, alu_neg
);

    always_comb begin
        unique case (alu_sel)
            `ALU_ADD: alu_out = bus_a + bus_b;
            `ALU_SUB: alu_out = bus_a - bus_b;
            `ALU_SLL: alu_out = bus_a << $unsigned(bus_b);
            `ALU_SRL: alu_out = bus_a >> $unsigned(bus_b);
            `ALU_SRA: alu_out = bus_a >>> $unsigned(bus_b); // Arithmetic right shift retains MSB
            `ALU_AND: alu_out = bus_a & bus_b;
            `ALU_OR:  alu_out = bus_a | bus_b;
            `ALU_XOR: alu_out = bus_a ^ bus_b;
            `ALU_SLT: alu_out = bus_a < bus_b;
            `ALU_SLTU: alu_out = $unsigned(bus_a) < $unsigned(bus_b);
            `ALU_A:   alu_out = bus_a;
            `ALU_B:   alu_out = bus_b;
            `ALU_MUL: alu_out = $unsigned(bus_a) * $unsigned(bus_b);
            default:  alu_out = 'b0;
        endcase
    end

    assign alu_zero = (alu_out == 0);
    assign alu_neg = (alu_out < 0);

endmodule
