module datapath (
    input clk, rst
);

    wire hazard;
    wire [31:0] pc_if;
    wire [31:0] instruction_if;
    wire [31:0] instruction_id;
    wire [31:0] pc_id;
    wire [31:0] pc_exe;
    wire [31:0] pc_mem;
    wire [31:0] pc_wb;
    wire branch_taken;

    wire [3:0] wb_dest_wb;
    wire [31:0] wb_value_wb;
    wire wb_wb_en_wb;

    wire [31:0] branch_address_exe;
    wire freeze = hazard;
    wire flush = branch_taken;

    IfStage if_stage(.clk(clk), 
                        .rst(rst), 
                        .freeze(freeze), 
                        .branch_taken(branch_taken), 
                        .branch_addr(branch_address_exe), 
                        .pc_adder_out(pc_if), 
                        .instruction(instruction_if)
    );

    IfStageReg if_stage_reg(.clk(clk), 
                                .rst(rst), 
                                .freeze(freeze),
                                .flush(branch_taken),
                                .pc_in(pc_if),
                                .instruction_in(instruction_if),
                                .pc_out(pc_id),
                                .instruction_out(instruction_id)
    );

    wire wb_en_id, mem_r_en_id, mem_w_en_id, b_id, s_id;
    wire [3:0] exe_cmd_id;
    wire [31:0] pc_out_id, val_rn_id, val_rm_id;
    wire [3:0] dest_id;
    wire [11:0] shift_operand_id;
    wire [23:0] signed_imm_24_id;
    wire imm_id;
    wire c_id;
    wire two_src_id;
    wire [3:0] src1_id, src2_id;

    wire [3:0] status_register_out_exe;


    IdStage id_stage(.clk(clk),
                        .rst(rst),
                        .hazard(1'b0),
                        .wb_wb_en(wb_wb_en_wb),
                        .status_reg_out(status_register_out_exe),
                        .wb_dest(wb_dest_wb),
                        .pc_in(pc_id),
                        .instruction(instruction_id),
                        .wb_value(wb_value_wb),
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
                        .imm(imm_id),
                        .c_out(c_id),
                        .two_src(two_src_id),
                        .src1(src1_id),
                        .src2(src2_id)
    );

    wire wb_en_exe, mem_r_en_exe, mem_w_en_exe, b_exe, s_exe;
    wire [3:0] exe_cmd_exe;
    wire [31:0] pc_out_exe, val_rn_exe, val_rm_exe;
    wire [3:0] dest_exe;
    wire [11:0] shift_operand_exe;
    wire [23:0] signed_imm_24_exe;
    wire imm_exe;
    wire c_exe;

    IDStageReg id_stage_reg(.clk(clk),
                            .rst(rst),
                            .flush(branch_taken),
                            .pc_in(pc_out_id),
                            .wb_en_in(wb_en_id),
                            .mem_r_en_in(mem_r_en_id),
                            .mem_w_en_in(mem_w_en_id),
                            .exe_cmd_in(exe_cmd_id),
                            .b_in(b_id),
                            .s_in(s_id),
                            .val_rn_in(val_rn_id),
                            .val_rm_in(val_rm_id),
                            .dest_in(dest_id),
                            .shift_operand_in(shift_operand_id),
                            .signed_imm_24_in(signed_imm_24_id),
                            .imm_in(imm_id),
                            .c_in(c_id),
                            .pc_out(pc_exe),
                            .wb_en_out(wb_en_exe),
                            .mem_r_en_out(mem_r_en_exe),
                            .mem_w_en_out(mem_w_en_exe),
                            .exe_cmd_out(exe_cmd_exe),
                            .b_out(b_exe),
                            .s_out(s_exe),
                            .val_rn_out(val_rn_exe),
                            .val_rm_out(val_rm_exe),
                            .dest_out(dest_exe),
                            .shift_operand_out(shift_operand_exe),
                            .signed_imm_24_out(signed_imm_24_exe),
                            .imm_out(imm_exe),
                            .c_out(c_exe)
    );

    wire wb_en_out_exe, mem_r_en_out_exe, mem_w_en_out_exe;
    wire [31:0] alu_res_exe;
    wire [31:0] val_rm_out_exe;
    wire [3:0] dest_out_exe;

    ExeStage exe_stage(.clk(clk),
                        .rst(rst),
                        .wb_en_in(wb_en_exe),
                        .mem_r_en_in(mem_r_en_exe),
                        .mem_w_en_in(mem_w_en_exe),
                        .exe_cmd_in(exe_cmd_exe),
                        .s_in(s_exe),
                        .b_in(b_exe),
                        .pc_in(pc_exe),
                        .val_rn_in(val_rn_exe),
                        .val_rm_in(val_rm_exe),
                        .shift_operand_in(shift_operand_exe),
                        .imm_in(imm_exe),
                        .signed_imm_24_in(signed_imm_24_exe),
                        .dest_in(dest_exe),
                        .c_in(c_exe),
                        .b_out(branch_taken),
                        .wb_en_out(wb_en_out_exe),
                        .mem_r_en_out(mem_r_en_out_exe),
                        .mem_w_en_out(mem_w_en_out_exe),
                        .alu_res(alu_res_exe),
                        .val_rm_out(val_rm_out_exe),
                        .dest_out(dest_out_exe),
                        .status_register_out(status_register_out_exe),
                        .branch_address(branch_address_exe)
    );

    wire mem_r_en_mem, mem_w_en_mem, wb_en_mem;
    wire [31:0] alu_res_mem;
    wire [31:0] val_rm_mem;
    wire [3:0] dest_mem;
    
    ExeStageReg exe_stage_reg(
        .clk(clk),
        .rst(rst),
        .wb_en_in(wb_en_out_exe),
        .mem_r_en_in(mem_r_en_out_exe),
        .mem_w_en_in(mem_w_en_out_exe),
        .alu_res_in(alu_res_exe),
        .val_rm_in(val_rm_out_exe),
        .dest_in(dest_out_exe),
        .mem_r_en_out(mem_r_en_mem),
        .mem_w_en_out(mem_w_en_mem),
        .wb_en_out(wb_en_mem),
        .alu_res_out(alu_res_mem),
        .val_rm_out(val_rm_mem),
        .dest_out(dest_mem)
    );

    wire wb_en_out_mem, mem_r_en_out_mem;
    wire [31:0] alu_res_out_mem;
    wire [31:0] data_memory_out_mem;
    wire [3:0] dest_out_mem;

    MemStage mem_stage(
        .clk(clk),
        .rst(rst),
        .wb_en_in(wb_en_mem),
        .mem_r_en_in(mem_r_en_mem),
        .mem_w_en_in(mem_w_en_mem),
        .alu_res_in(alu_res_mem),
        .val_rm_in(val_rm_mem),
        .dest_in(dest_mem),
        .wb_en_out(wb_en_out_mem),
        .mem_r_en_out(mem_r_en_out_mem),
        .alu_res_out(alu_res_out_mem),
        .data_memory_out(data_memory_out_mem),
        .dest_out(dest_out_mem)
    );

    wire wb_en_wb, mem_r_en_wb;
    wire [31:0] alu_res_wb;
    wire [31:0] data_memory_wb;
    wire [3:0] dest_wb;

    MemStageReg mem_stage_reg(.clk(clk),
                        .rst(rst),
                        .wb_en_in(wb_en_out_mem),
                        .mem_r_en_in(mem_r_en_out_mem),
                        .alu_res_in(alu_res_mem),
                        .dest_in(dest_mem),
                        .data_memory_in(data_memory_out_mem),
                        .wb_en_out(wb_en_wb),
                        .mem_r_en_out(mem_r_en_wb),
                        .alu_res_out(alu_res_wb),
                        .dest_out(dest_wb),
                        .data_memory_out(data_memory_wb)
    );

    WbStage wb_stage(.wb_en(wb_en_wb),
                        .mem_r_en(mem_r_en_wb),
                        .alu_res(alu_res_wb),
                        .data_mem_res(data_memory_wb),
                        .dest(dest_wb),
                        .wb_wb_en(wb_wb_en_wb),
                        .wb_dest(wb_dest_wb),
                        .wb_value(wb_value_wb)
    );

    HazardUnit hazard_unit(
        .src1(src1_id),
        .src2(src2_id),
        .exe_dest(dest_exe),
        .exe_wb_en(wb_en_exe),
        .mem_dest(dest_mem),
        .mem_wb_en(wb_en_mem),
        .two_src(two_src_id),
        .hazard(hazard)
    );

    

    

    
    
endmodule