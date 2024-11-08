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
    output imm
);

    wire S = Instruction[20];
    wire [1:0] mode = Instruction[27:26];
    wire [3:0] opcode = Instruction[24:21];
    wire [3:0] cond = Instruction[31:28];
    wire [3:0] Rn = Instruction[19:16];
    wire [3:0] Rm = Instruction[3:0];
    wire [3:0] Rd = Instruction[15:12];
    assign imm = Instruction[25];
    assign shift_operand = Instruction[11:0];
    assign signed_imm_24 = Instruction[23:0];
    assign dest = Instruction[15:12]; 
    assign PC_out = PC_in;


    wire cu_WB_Enable, cu_mem_read, cu_mem_write, cu_B, cu_update_status_reg, condition_check_out;
    wire [3:0] cu_execute_command;
    wire cu_en = (~condition_check_out | hazard);
    wire [3:0] src1, src2;

    assign src1 = Rn;
    assign src2 = (mem_write == 1'b1) ? Rd : Rm;

    assign WB_Enable = (~cu_en) ? cu_WB_Enable : 1'b0;
    assign mem_read = (~cu_en) ? cu_mem_read : 1'b0;
    assign mem_write = (~cu_en) ? cu_mem_write : 1'b0;
    assign B = (~cu_en) ? cu_B : 1'b0;
    assign update_status_reg = (~cu_en) ? cu_update_status_reg : 1'b0;
    assign execute_command = (~cu_en) ? cu_execute_command : 4'b0000; 
    
    Control_Unit control_unit (
        .mode(mode),
        .opcode(opcode),
        .S(S),
        .WB_Enable(cu_WB_Enable),
        .mem_read(cu_mem_read),
        .mem_write(cu_mem_write),
        .B(cu_B),
        .update_status_reg(cu_update_status_reg),
        .execute_command(cu_execute_command)
    );

    ConditionCheck condition_check(
        .cond(cond),
        .status_reg_out(str_out),
        .out(condition_check_out)
    );

    RegisterFile rf (
        .clk(clk),
        .rst(rst),
        .src1(src1),
        .src2(src2),
        .Dest_wb(wb_dest),
        .Result_WB(wb_value),
        .writeBackEn(wb_en),
        .reg1(Val_Rn),
        .reg2(Val_Rm)
    );



    
endmodule


