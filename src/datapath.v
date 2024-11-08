module datapath (
    input clk, rst
);

    wire [31:0] pc_if;
    wire [31:0] instruction_if;
    wire [31:0] instruction_id;
    wire [31:0] pc_id;
    wire [31:0] pc_exe;
    wire [31:0] pc_mem;
    wire [31:0] pc_wb;

    IfStage if_stage(.clk(clk), 
                        .rst(rst), 
                        .freeze(1'b0), 
                        .branch_taken(1'b0), 
                        .branch_addr(32'b0), 
                        .pc(pc_if), 
                        .instruction(instruction_if));

    IfStageReg if_stage_reg(.clk(clk), 
                                .rst(rst), 
                                .freeze(1'b0),
                                .flush(1'b0),
                                .pc_in(pc_if),
                                .instruction_in(instruction_if),
                                .pc_out(pc_id),
                                .instruction_out(instruction_id));

    wire wb_en_id, mem_r_en_id, mem_w_en_id, b_id, s_id;
    wire [3:0] exe_cmd_id;
    wire [31:0] pc_out_id, val_rn_id, val_rm_id;
    wire [3:0] dest_id;
    wire [11:0] shift_operand_id;
    wire [23:0] signed_imm_24_id;
    wire imm_id;

    IdStage id_stage(.clk(clk),
                        .rst(rst),
                        .hazard(1'b0),
                        .wb_wb_en(1'b0),
                        .status_reg_out(4'b0),
                        .wb_dest(4'b0),
                        .pc_in(pc_id),
                        .instruction(instruction_id),
                        .wb_value(32'b0),
                        .wb_en(wb_en_id),
                        .mem_r_en(mem_r_en_id),
                        .mem_w_en(mem_w_en_id),
                        .b(b_id),
                        .s(s_id),
                        .exe_cmd(exe_cmd_id),
                        .pc_out(pc_out_id),
                        .val_rn(val_rn_id),
                        .val_rm(val_rm_id),
                        .dest(dest_id),
                        .shift_operand(shift_operand_id),
                        .signed_imm_24(signed_imm_24_id),
                        .imm(imm_id));

    wire wb_en_exe, mem_r_en_exe, mem_w_en_exe, b_exe, s_exe;
    wire [3:0] exe_cmd_exe;
    wire [31:0] pc_out_exe, val_rn_exe, val_rm_exe;
    wire [3:0] dest_exe;
    wire [11:0] shift_operand_exe;
    wire [23:0] signed_imm_24_exe;
    wire imm_exe;

    IDStageReg id_stage_reg(.clk(clk),
                            .rst(rst),
                            .pc_in(pc_out_id),
                            .wb_en_in(wb_en_id),
                            .mem_r_en_in(mem_r_en_id),
                            .exe_cmd_in(exe_cmd_id),
                            .b_in(b_id),
                            .s_in(s_id),
                            .val_rn_in(val_rn_id),
                            .val_rm_in(val_rm_id),
                            .dest_in(dest_id),
                            .shift_operand_in(shift_operand_id),
                            .signed_imm_24_in(signed_imm_24_id),
                            .imm_in(imm_id),
                            .pc_out(pc_exe),
                            .wb_en_out(wb_en_exe),
                            .mem_r_en_out(mem_r_en_exe),
                            .exe_cmd_out(exe_cmd_exe),
                            .b_out(b_exe),
                            .s_out(s_exe),
                            .val_rn_out(val_rn_exe),
                            .val_rm_out(val_rm_exe),
                            .dest_out(dest_exe),
                            .shift_operand_out(shift_operand_exe),
                            .signed_imm_24_out(signed_imm_24_exe),
                            .imm_out(imm_exe)
    );
    
    ExeStageReg exe_stage_reg(.clk(clk),
                                .rst(rst),
                                .pc_in(pc_exe),
                                .pc_out(pc_mem));
    
    MemStageReg mem_stage_reg(.clk(clk),
                                .rst(rst),
                                .pc_in(pc_mem),
                                .pc_out(pc_wb));
    
endmodule