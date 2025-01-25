module mux2 (
	input logic [31:0] a0, a1,
	input logic sel,
	output logic [31:0] out
);
	assign out = sel? a1 : a0;
	
endmodule
	
