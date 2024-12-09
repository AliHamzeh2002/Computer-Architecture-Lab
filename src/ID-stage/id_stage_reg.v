module IDStageReg (
    input clk, rst, flush,
    input [31:0] pc_in,
    input wb_en_in, mem_r_en_in, mem_w_en_in, b_in, s_in,
    input [31:0] val_rn_in, val_rm_in,
    input [3:0] dest_in, exe_cmd_in,
    input [11:0] shift_operand_in,
    input [23:0] signed_imm_24_in,
    input [3:0] src1_in, src2_in,
    input imm_in,
    input c_in,
    output reg [31:0] pc_out,
    output reg wb_en_out, mem_r_en_out, mem_w_en_out, b_out, s_out,
    output reg [31:0] val_rn_out, val_rm_out,
    output reg [3:0] dest_out, exe_cmd_out, 
    output reg [11:0] shift_operand_out,
    output reg [23:0] signed_imm_24_out,
    output reg [3:0] src1_out, src2_out,
    output reg imm_out,
    output reg c_out
);

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            pc_out <= 32'h0;
            wb_en_out <= 1'b0;
            mem_r_en_out <= 1'b0;
            mem_w_en_out <= 1'b0;
            exe_cmd_out <= 4'b0;
            b_out <= 1'b0;
            s_out <= 1'b0;
            val_rn_out <= 32'h0;
            val_rm_out <= 32'h0;
            dest_out <= 4'b0;
            shift_operand_out <= 12'h0;
            signed_imm_24_out <= 24'h0;
            imm_out <= 1'b0;
            c_out <= 1'b0;
            src1_out <= 4'b0;
            src2_out <= 4'b0;
        end
        else if (flush) begin
            pc_out <= 32'h0;
            wb_en_out <= 1'b0;
            mem_r_en_out <= 1'b0;
            mem_w_en_out <= 1'b0;
            exe_cmd_out <= 4'b0;
            b_out <= 1'b0;
            s_out <= 1'b0;
            val_rn_out <= 32'h0;
            val_rm_out <= 32'h0;
            dest_out <= 4'b0;
            shift_operand_out <= 12'h0;
            signed_imm_24_out <= 24'h0;
            imm_out <= 1'b0;
            c_out <= 1'b0;
            src1_out <= 4'b0;
            src2_out <= 4'b0;
        end else begin
            pc_out <= pc_in;
            wb_en_out <= wb_en_in;
            mem_r_en_out <= mem_r_en_in;
            mem_w_en_out <= mem_w_en_in;
            exe_cmd_out <= exe_cmd_in;
            b_out <= b_in;
            s_out <= s_in;
            val_rn_out <= val_rn_in;
            val_rm_out <= val_rm_in;
            dest_out <= dest_in;
            shift_operand_out <= shift_operand_in;
            signed_imm_24_out <= signed_imm_24_in;
            imm_out <= imm_in;
            c_out <= c_in;
            src1_out <= src1_in;
            src2_out <= src2_in;
        end
    end

endmodule
