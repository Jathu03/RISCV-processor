`include "controls.sv"

module datapath_mem (
    input logic clk, rstn,
    input logic [20:0] ctrl_signals,
    output logic [31:0] instruction,
    output logic ex_no_stay,
    output logic [31:0] x5, x6, x11, mem1
);

    localparam N_WIDTH = 7;
    /* Datapath Wires */
    localparam REG_BITS = 5;  // Since REG_COUNT = 32, $clog2(32) = 5
    logic [REG_BITS-1:0] read_reg1, read_reg2, write_reg;
    logic signed [31:0] read_data1, read_data2, write_data, imm_data, imm_sel_data;
    logic signed [31:0] bus_a, bus_b, alu_out;
    logic alu_zero, alu_neg;
    logic [31:0] mem_addr; 
    logic signed [31:0] mem_write_data, mem_read_data;
    logic [31:0] pc, target_pc, return_pc, pc_offset;
    logic [REG_BITS-1:0] rs1, rs2, rd;
    logic [N_WIDTH-1:0] counter_N;
    logic counter_words, counter_done;
    logic [31:0] counter_out;
    
    /* control signals */
    logic write_en;
    logic [3:0] alu_sel;
    logic alu_a_sel, alu_b_sel;
    logic mem_read, mem_write;
    logic [1:0] load_store_type, ls_temp;
    logic load_unsigned;
    logic [1:0] write_src_sel;  // from where is written to register
    logic [2:0] branch_type;
    logic stay, stay_temp;      // Do not go to next instruction
    logic memcpy_store;         // Load or store instruction within memcopy
    logic counter_en, counter_sel;
    
    /* Control signal assignments */
    assign {write_en, alu_sel, alu_b_sel, alu_a_sel, mem_write, mem_read, ls_temp, load_unsigned, write_src_sel, branch_type, stay_temp, memcpy_store, counter_en, counter_sel} = ctrl_signals;
    assign stay = stay_temp & (~ex_no_stay);

    always_comb begin
        if (!counter_sel) load_store_type = ls_temp;
        else if (counter_words) load_store_type = `LS_WORD;
        else load_store_type = `LS_BYTE;
    end

    /* Assignments in datapath */
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd = instruction[11:7];

    assign read_reg1 = memcpy_store ? rs2 : rs1;
    assign read_reg2 = memcpy_store ? rd : rs2;
    assign write_reg = rd;

    assign bus_a = alu_a_sel ? pc : read_data1;        // use PC if 1
    assign bus_b = alu_b_sel ? imm_sel_data : read_data2; // immediate if 1

    assign mem_addr = alu_out;        // Calculated mem address
    assign mem_write_data = read_data2;  // rs2 contents (cannot use bus B because it might have immediate)

    assign target_pc = alu_out;
    assign pc_offset = imm_data;

    assign counter_N = imm_data[N_WIDTH-1:0];
    assign imm_sel_data = counter_sel ? counter_out : imm_data;
    assign ex_no_stay = counter_done & counter_en;  // Only check this on a memcopy instruction

    regfile regfile_obj (
        .clk(clk),
        .rstn(rstn),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_en(write_en),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .x5(x5),
        .x6(x6),
        .x11(x11),
        .mem1(mem1)
    );

    alu alu_obj (
        .clk(clk),
        .alu_sel(alu_sel),
        .alu_a(bus_a),
        .alu_b(bus_b),
        .alu_out(alu_out),
        .alu_zero(alu_zero),
        .alu_neg(alu_neg)
    );

    immgen immgen_obj (
        .inst(instruction),
        .imm_out(imm_data)
    );

    data_memory datamem_obj (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_addr(mem_addr),
        .mem_write_data(mem_write_data),
        .mem_read_data(mem_read_data)
    );

    pcc pclogic_obj (
        .pc(pc),
        .target_pc(target_pc)
    );

    mux3 reg_src_mux (
        .a0(alu_out),
        .a1(mem_read_data),
        .a2(return_pc),
        .sel(write_src_sel),
        .out(write_data)
    );

    inst_memory instmem_obj (
        .clk(clk),
        .inst_address(pc),
        .instruction(instruction)
    );

    counter count_obj (
        .clk(clk),
        .rstn(rstn),
        .counter_N(counter_N),
        .counter_en(counter_en),
        .counter_out(counter_out),
        .counter_words(counter_words),
        .counter_done(counter_done)
    );

endmodule
