module MemStage (
    input clk, rst,
    input wb_en_in, mem_r_en_in, mem_w_en_in,
    input [31:0] alu_res_in,
    input [31:0] val_rm_in,
    input [3:0] dest_in,
    output wb_en_out, mem_r_en_out,
    output [31:0] alu_res_out,
    output [31:0] data_memory_out,
    output [3:0] dest_out
);
    assign wb_en_out = wb_en_in;
    assign mem_r_en_out = mem_r_en_in;
    assign alu_res_out = alu_res_in;
    assign dest_out = dest_in;

    DataMemory data_memory(
        .clk(clk),
        .rst(rst),
        .mem_w_en(mem_w_en_in),
        .mem_r_en(mem_r_en_in),
        .alu_res(alu_res_in),
        .val_rm(val_rm_in),
        .out(data_memory_out)
    );

    
endmodule