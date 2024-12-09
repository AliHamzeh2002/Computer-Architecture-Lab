module ExeStage (
    input clk, rst,
    input wb_en_in, mem_r_en_in, mem_w_en_in,
    input [1:0] sel_src1, sel_src2,
    input [3:0] exe_cmd_in,
    input s_in, b_in,
    input [31:0] pc_in,
    input [31:0] val_rn_in,
    input [31:0] val_rm_in,
    input [31:0] alu_res_mem,
    input [31:0] wb_value,
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

    wire [31:0] val1, val2, mux1_out, mux2_out;

    assign dest_out = dest_in;
    assign wb_en_out = wb_en_in;
    assign mem_r_en_out = mem_r_en_in;
    assign mem_w_en_out = mem_w_en_in;
    assign val_rm_out = mux2_out;
    assign b_out = b_in;
    assign branch_address = pc_in + {{6{signed_imm_24_in[23]}}, signed_imm_24_in, 2'b00};

    wire s_type_signal = mem_r_en_in | mem_w_en_in;
    wire [3:0] status_register_in;

    assign val1 = mux1_out;

    Mux4To1 mux1(
        .in0(val_rn_in),
        .in1(alu_res_mem),
        .in2(wb_value),
        .in3(32'b0),
        .sel(sel_src1),
        .out(mux1_out)
    );

    Mux4To1 mux2(
        .in0(val_rm_in),
        .in1(alu_res_mem),
        .in2(wb_value),
        .in3(32'b0),
        .sel(sel_src2),
        .out(mux2_out)
    );

    Val2Generate val2generate(
        .val_rm(mux2_out),
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
        .status_en(s_in),
        .in_data(status_register_in),
        .out_data(status_register_out)
    );


    
endmodule