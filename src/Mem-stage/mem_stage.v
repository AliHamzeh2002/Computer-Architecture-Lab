module MemStage (
    input clk, rst,
    input wb_en_in, mem_r_en_in, mem_w_en_in,
    input [31:0] alu_res_in,
    input [31:0] val_rm_in,
    input [3:0] dest_in,
    output wb_en_out, mem_r_en_out,
    output [31:0] alu_res_out,
    output [31:0] data_memory_out,
    output [3:0] dest_out,
    inout [15:0] SRAM_DQ,
    output [17:0] SRAM_ADDR,
    output SRAM_UB_N,
    output SRAM_LB_N,
    output SRAM_WE_N,
    output SRAM_CE_N,
    output SRAM_OE_N,
    output mem_ready
);
    assign wb_en_out = wb_en_in;
    assign mem_r_en_out = mem_r_en_in;
    assign alu_res_out = alu_res_in;
    assign dest_out = dest_in;

    wire[63:0] sram_read_out;
    wire [31:0] sram_w_data;
    wire [31:0] sram_address;
    wire sram_ready;
    wire sram_r_en;
    wire sram_w_en;

    cacheController cache_controller(
        .clk(clk),
        .rst(rst),
        .address(alu_res_in),
        .w_data(val_rm_in),
        .mem_r_en(mem_r_en_in),
        .mem_w_en(mem_w_en_in),
        .sram_r_data(sram_read_out),
        .sram_ready(sram_ready),
        .r_data(data_memory_out),
        .ready(mem_ready),
        .sram_address(sram_address),
        .sram_w_data(sram_w_data),
        .sram_r_en(sram_r_en),
        .sram_w_en(sram_w_en)
    );

    SramController sram_controller(
        .clk(clk),
        .rst(rst),
        .wr_en(sram_w_en),
        .rd_en(sram_r_en),
        .address(sram_address),
        .write_data(sram_w_data),
        .read_data(sram_read_out),
        .ready(sram_ready),
        .SRAM_DQ(SRAM_DQ),
        .SRAM_ADDR(SRAM_ADDR),
        .SRAM_UB_N(SRAM_UB_N),
        .SRAM_LB_N(SRAM_LB_N),
        .SRAM_WE_N(SRAM_WE_N),
        .SRAM_CE_N(SRAM_CE_N),
        .SRAM_OE_N(SRAM_OE_N)
    );


    // DataMemory data_memory(
    //     .clk(clk),
    //     .rst(rst),
    //     .mem_w_en(mem_w_en_in),
    //     .mem_r_en(mem_r_en_in),
    //     .alu_res(alu_res_in),
    //     .val_rm(val_rm_in),
    //     .out(data_memory_out)
    // );

    
endmodule