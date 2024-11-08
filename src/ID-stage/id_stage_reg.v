module ID_Stage_Reg (
    input clk, rst,
    input [31:0] PC_in,
    input wb_en, mem_r_en, exe_cmd, B, S,
    input [31:0] val_rn, val_rm,
    input [3:0] dest,
    input [11:0] shift_operand,
    input [23:0] signed_imm_24,
    input imm,
    output reg [31:0] PC,
    output reg wb_en_out, mem_r_en_out, exe_cmd_out, B_out, S_out,
    output reg [31:0] val_rn_out, val_rm_out,
    output reg [3:0] dest_out,
    output reg [11:0] shift_operand_out,
    output reg [23:0] signed_imm_24_out,
    output reg imm_out
);

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            PC <= 32'h0;
        end else begin
            PC <= PC_in;
            wb_en_out <= wb_en;
            mem_r_en_out <= mem_r_en;
            exe_cmd_out <= exe_cmd;
            B_out <= B;
            S_out <= S;
            val_rn_out <= val_rn;
            val_rm_out <= val_rm;
            dest_out <= dest;
            shift_operand_out <= shift_operand;
            signed_imm_24_out <= signed_imm_24;
            imm_out <= imm;
        end
    end


  
endmodule