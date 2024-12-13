module MemStageReg (
    input clk, rst, freeze,
    input wb_en_in, mem_r_en_in,
    input [31:0] alu_res_in,
    input [31:0] data_memory_in,
    input [3:0] dest_in,
    output reg mem_r_en_out, wb_en_out,
    output reg [31:0] alu_res_out,
    output reg [31:0] data_memory_out,
    output reg [3:0] dest_out
);
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            mem_r_en_out <= 0;
            wb_en_out <= 0;
            alu_res_out <= 0;
            dest_out <= 0;
            data_memory_out <= 0;
        end else if (~freeze) begin
            mem_r_en_out <= mem_r_en_in;
            wb_en_out <= wb_en_in;
            alu_res_out <= alu_res_in;
            dest_out <= dest_in;
            data_memory_out <= data_memory_in;
        end
    end
  
endmodule