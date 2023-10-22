module immediate_extender (
    input [31:0] instruction,
    output wire [32:0] immediate
);


always @(*) begin
    case (instruction[6:0])  //{instruction[6:0], instruction[14:12]}
        // I-Type Instructions
        7'b0000011: immediate = { {20{instruction[31]}}, instruction[31:20] };
        7'b0010011: immediate = { {20{instruction[31]}}, instruction[31:20] };
        // S-Type Instructions
        7'b0100011: immediate = { {20{instruction[31]}}, instruction[31:25], instruction[12:7] };
        // SB-Type Instructions
        7'b1100011: immediate = { {19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8] };
        default: immediate = 64'b0; // Default value
    endcase
end

endmodule
