module ExeStage (
    input clk, rst,
    input wb_en_in, mem_r_en_in, mem_w_en_in,
    input [3:0] exe_cmd_in,
    input s_in, b_in,
    input [31:0] pc_in,
    input [31:0] val_rn_in,
    input [31:0] val_rm_in,
    input [11:0] shift_operand_in,
    input imm_in,
    input [23:0] signed_imm_24_in,
    input [3:0] dest_in,
    input c_in,
    output wb_en_out, mem_r_en_out, mem_w_en_out, b_out,
    output [31:0] alu_res,
    output [31:0] val_rm_out,
    output [3:0] dest_out,
    output [3:0] status_register_out,
    output [31:0] branch_address
);

    wire [31:0] val1, val2;

    assign dest_out = dest_in;
    assign wb_en_out = wb_en_in;
    assign mem_r_en_out = mem_r_en_in;
    assign mem_w_en_out = mem_w_en_in;
    assign val_rm_out = val_rm_in;
    assign b_out = b_in;
    assign branch_address = pc_in + signed_imm_24_in;

    wire s_type_signal = mem_r_en_in | mem_w_en_in;
    wire [3:0] status_register_in;


    assign val1 = val_rn_in;

    Val2Generate val2generate(
        .val_rm(val_rm_in),
        .shift_operand(shift_operand_in),
        .imm(imm_in),
        .s_type_signal(s_type_signal),
        .out(val2)
    );

    ALU alu(
        .src_a(val1),
        .src_b(val2),
        .alu_op(exe_cmd_in),
        .c_in(c_in),
        .alu_result(alu_res),
        .status_bits(status_register_in)
    );

    StatusReg status_register(
        .clk(clk),
        .rst(rst),
        .wb_en(s_in),
        .in_data(status_register_in),
        .out_data(status_register_out)
    );


    
endmodule