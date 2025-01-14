module IdStage (
    input clk, rst, hazard, wb_wb_en,
    input [3:0] status_reg_out, wb_dest,
    input [31:0] pc_in, instruction, wb_value,
    output wb_en, mem_r_en, mem_w_en, b, s,
    output [3:0] exe_cmd,
    output [31:0] pc_out, val_rn, val_rm,
    output [3:0] dest,
    output [11:0] shift_operand,
    output [23:0] signed_imm_24,
    output imm,
    output c_out,
    output two_src, has_src1,
    output [3:0] src1, src2
);

    wire S = instruction[20];
    wire [1:0] mode = instruction[27:26];
    wire [3:0] opcode = instruction[24:21];
    wire [3:0] cond = instruction[31:28];
    wire [3:0] rn = instruction[19:16];
    wire [3:0] rm = instruction[3:0];
    wire [3:0] rd = instruction[15:12];
    assign imm = instruction[25];
    assign shift_operand = instruction[11:0];
    assign signed_imm_24 = instruction[23:0];
    assign dest = instruction[15:12]; 
    assign pc_out = pc_in;
    assign c_out = status_reg_out[2];
    assign two_src = (~imm) | mem_w_en;

    wire wb_en_cu_out, mem_read_cu_out, mem_write_cu_out, b_cu_out, s_cu_out, condition_check_out;
    wire [3:0] exe_cmd_cu_out;
    wire cu_en = (~condition_check_out | hazard);

    assign src1 = rn;
    assign src2 = (mem_w_en == 1'b1) ? rd : rm;

    assign wb_en = (~cu_en) ? wb_en_cu_out : 1'b0;
    assign mem_r_en = (~cu_en) ? mem_read_cu_out : 1'b0;
    assign mem_w_en = (~cu_en) ? mem_write_cu_out : 1'b0;
    assign b = (~cu_en) ? b_cu_out : 1'b0;
    assign s = (~cu_en) ? s_cu_out : 1'b0;
    assign exe_cmd = (~cu_en) ? exe_cmd_cu_out : 4'b0000; 
    
    ControlUnit control_unit (
        .mode(mode),
        .opcode(opcode),
        .s_in(S),
        .wb_en(wb_en_cu_out),
        .mem_r_en(mem_read_cu_out),
        .mem_w_en(mem_write_cu_out),
        .b(b_cu_out),
        .s_out(s_cu_out),
        .exe_cmd(exe_cmd_cu_out),
        .has_src1(has_src1)
    );

    ConditionCheck condition_check(
        .cond(cond),
        .status_reg_out(status_reg_out),
        .out(condition_check_out)
    );

    RegisterFile rf (
        .clk(clk),
        .rst(rst),
        .src1(src1),
        .src2(src2),
        .wb_dest(wb_dest),
        .wb_value(wb_value),
        .wb_en(wb_wb_en),
        .reg1(val_rn),
        .reg2(val_rm)
    );
    
endmodule


