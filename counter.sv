module counter(
    input logic [6:0] counter_N,    // WIDTH is set to 7 here
    input logic clk, rstn, counter_en,
    output logic [31:0] counter_out,
    output logic counter_words,      // whether to count bytes or words
    output logic counter_done
);
    logic [6:0] ci;    // WIDTH is set to 7 here
    
    always @(posedge clk or negedge rstn) begin
        if (!rstn) 
            ci <= 'b0;
        else if (counter_en) begin
            if (counter_done) 
                ci <= 'b0;
            else if (counter_words)
                ci <= ci + 4;
            else 
                ci <= ci + 1;
        end
        else 
            ci <= ci;
    end
    
    assign counter_done = (ci + 1 == counter_N) || (ci + 4 == counter_N);
    assign counter_out = {{(32-7){1'b0}}, ci};    // 7 bits for counter_N, padded to 32 bits
    assign counter_words = (ci + 4 < counter_N);
    
endmodule
