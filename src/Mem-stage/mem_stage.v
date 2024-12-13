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

    SramController sram_controller(
        .clk(clk),
        .rst(rst),
        .wr_en(mem_w_en_in),
        .rd_en(mem_r_en_in),
        .address(alu_res_in),
        .write_data(val_rm_in),
        .read_data(data_memory_out),
        .ready(mem_ready),
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