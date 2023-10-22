module alu_control(
    input reg [31:0] instruction,
    input wire [1:0] ALUOp,
    output reg [3:0] ALUControl
);
always @(*) begin
    if (ALUOp == 2'b00 || ALUOp == 2'b01) begin
        ALUControl = 4'b0010;
    end else if (ALUOp == 2'b10) begin
        if (instruction[14:12] == 3'b000) begin
            if (instruction[30] == 1'b0) begin
                ALUControl = 4'b0011; // ADD
            end else if (instruction[30] == 1'b1) begin
                ALUControl = 4'b0100; // SUB
            end
        end else if (instruction[14:12] == 3'b111) begin
            if (instruction[30] == 1'b0) begin
                ALUControl = 4'b0001; // AND
            end
        end else if (instruction[14:12] == 3'b110) begin
            if (instruction[30] == 1'b0) begin
                ALUControl = 4'b0010; // OR
            end
        end else if (instruction[14:12] == 3'b100) begin
            if (instruction[30] == 1'b0) begin
                ALUControl = 4'b0101; // XOR
            end
        end else if (instruction[14:12] == 3'b111 & instruction[7:0]==7'b1111110) begin
            if (instruction[30] == 1'b1) begin
                ALUControl = 4'b0110; // MUL
            end
        end else begin
            ALUControl = 4'b1000; // Default value for other combinations
        end
    end else begin
        ALUControl = 4'b0000; // Default value for other ALUOp values.
    end
end

endmodule