module mux3 (
  input logic [31:0] a0, a1, a2,
	input logic [1:0] sel,
  output logic [31:0] out
);
	always_comb begin
		unique case (sel)
			2'b00: out = a0;
			2'b01: out = a1;
			2'b10: out = a2;
			2'b11: out = 'b0;
		endcase
	end
	
endmodule
