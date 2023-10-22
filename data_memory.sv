module data_memory(
	input MemRead,
	input MemWrite,
	input [31:0] address,
	input [31:0] write_data,
	output [31:0] read_data,
	input clk
	
);
wire [31:0] memory_address = address[31:0];

reg [31:0] memory [1023:0];
    // Initial values for memory
    initial begin
        for (int i = 0; i < 1024; i = i + 1) begin
            memory[i] = 0;
        end
    end

always @(posedge clk) begin
	if (MemWrite) memory[memory_address] = write_data;
end

assign read_data = (MemRead == 1'b1) ? memory[memory_address]: 16'd0;
endmodule 