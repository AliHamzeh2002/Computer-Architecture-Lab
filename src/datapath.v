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

    // IF_Stage if_stage(clk, rst, 1'b0, 1'b0, 32'b0, pc_if, instruction_if);
    // IF_Stage_Reg if_stage_reg(clk, rst, 1'b0, 1'b0, pc_if, instruction_if, pc_id, instruction_id);
    // ID_Stage_Reg id_stage_reg(clk, rst, pc_id, pc_exe);
    // EXE_Stage_Reg exe_stage_reg(clk, rst, pc_exe, pc_mem);
    // MEM_Stage_Reg mem_stage_reg(clk, rst, pc_mem, pc_wb);

    IF_Stage if_stage(.clk(clk), 
                        .rst(rst), 
                        .freeze(1'b0), 
                        .Branch_taken(1'b0), 
                        .BranchAddr(32'b0), 
                        .PC(pc_if), 
                        .Instruction(instruction_if));

    IF_Stage_Reg if_stage_reg(.clk(clk), 
                                .rst(rst), 
                                .freeze(1'b0),
                                .flush(1'b0),
                                .PC_in(pc_if),
                                .instruction_in(instruction_if),
                                .PC(pc_id),
                                .instruction(instruction_id));

    /*
    module ID_stage (
    input clk, rst, hazard, wb_en,
    input [3:0] str_out, wb_dest,
    input [31:0] PC_in, Instruction, wb_value,
    output WB_Enable, mem_read, mem_write, B, update_status_reg,
    output [3:0] execute_command,
    output [31:0] PC_out, Val_Rn, Val_Rm,
    output [3:0] dest,
    output [11:0] shift_operand,
    output [23:0] signed_imm_24,
    output imm,
    */

    wire WB_Enable, mem_read, mem_write, B, update_status_reg;
    wire [3:0] execute_command;
    wire [31:0] PC_out_id, Val_Rn, Val_Rm;
    wire [3:0] dest;
    wire [11:0] shift_operand;
    wire [23:0] signed_imm_24;
    wire imm;

    ID_stage id_stage(.clk(clk),
                        .rst(rst),
                        .hazard(1'b0),
                        .wb_en(1'b0),
                        .str_out(4'b0),
                        .wb_dest(4'b0),
                        .PC_in(pc_id),
                        .Instruction(instruction_id),
                        .wb_value(32'b0),
                        .WB_Enable(WB_Enable),
                        .mem_read(mem_read),
                        .mem_write(mem_write),
                        .B(B),
                        .update_status_reg(update_status_reg),
                        .execute_command(execute_command),
                        .PC_out(PC_out_id),
                        .Val_Rn(Val_Rn),
                        .Val_Rm(Val_Rm),
                        .dest(dest),
                        .shift_operand(shift_operand),
                        .signed_imm_24(signed_imm_24),
                        .imm(imm));


    /*
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
    */

    wire [31:0] PC_in_id;
    wire wb_en_id, mem_r_en_id, exe_cmd_id, B_id, S_id;
    wire [31:0] val_rn_id, val_rm_id;
    wire [3:0] dest_id;
    wire [11:0] shift_operand_id;
    wire [23:0] signed_imm_24_id;
    wire imm_id; 

    ID_Stage_Reg id_stage_reg(.clk(clk),
                            .rst(rst),
                            .PC_in(PC_out_id),
                            .wb_en(wb_en_id),
                            .mem_r_en(mem_r_en_id),
                            .exe_cmd(exe_cmd_id),
                            .B(B_id),
                            .S(S_id),
                            .val_rn(val_rn_id),
                            .val_rm(val_rm_id),
                            .dest(dest_id),
                            .shift_operand(shift_operand_id),
                            .signed_imm_24(signed_imm_24_id),
                            .imm(imm_id),
                            .PC(PC_in_id),
                            .wb_en_out(wb_en_id),
                            .mem_r_en_out(mem_r_en_id),
                            .exe_cmd_out(exe_cmd_id),
                            .B_out(B_id),
                            .S_out(S_id),
                            .val_rn_out(val_rn_id),
                            .val_rm_out(val_rm_id),
                            .dest_out(dest_id),
                            .shift_operand_out(shift_operand_id),
                            .signed_imm_24_out(signed_imm_24_id),
                            .imm_out(imm_id)
    );
    
    EXE_Stage_Reg exe_stage_reg(.clk(clk),
                                .rst(rst),
                                .PC_in(PC_in_id),
                                .PC(pc_mem));
    
    MEM_Stage_Reg mem_stage_reg(.clk(clk),
                                .rst(rst),
                                .PC_in(pc_mem),
                                .PC(pc_wb));
    
endmodule