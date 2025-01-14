module ControlUnit (
    input [1:0] mode,
    input [3:0] opcode,
    input s_in,
    output b, s_out,
    output reg wb_en, mem_r_en, mem_w_en, has_src1,
    output reg [3:0] exe_cmd
);

    assign s_out = (mode == 2'b0) ? s_in : 1'b0;
    assign b = (mode == 2'b10) ? 1'b1 : 1'b0;

    always @(mode, opcode, s_in) begin
        exe_cmd = 4'b0000;
        wb_en = 1'b1;
        mem_r_en = 1'b0;
        mem_w_en = 1'b0;
        has_src1 = 1'b1;
        if (mode == 2'b0) begin
            case (opcode)
                4'b1101: begin
                    exe_cmd = 4'b0001; // MOV
                    has_src1 = 1'b0;
                end
                4'b1111: begin
                    exe_cmd = 4'b1001; // MVN
                    has_src1 = 1'b0;
                end
                4'b0100: exe_cmd = 4'b0010; // ADD
                4'b0101: exe_cmd = 4'b0011; // ADC
                4'b0010: exe_cmd = 4'b0100; // SUB
                4'b0110: exe_cmd = 4'b0101; // SBC
                4'b0000: exe_cmd = 4'b0110; // AND
                4'b1100: exe_cmd = 4'b0111; // ORR
                4'b0001: exe_cmd = 4'b1000; // EOR
                4'b1010: begin
                    exe_cmd = 4'b0100; // CMP
                    wb_en = 1'b0;
                end
                4'b1000: begin
                    exe_cmd = 4'b0110; // TST
                    wb_en = 1'b0;
                end
                default: begin 
                    exe_cmd = 4'b0000; // NOP
                    has_src1 = 1'b0;
                end
            endcase
        end
        else if (mode == 2'b01 && opcode == 4'b0100) begin // STR LDR
            exe_cmd = 4'b0010;
            if (s_in == 1'b0) begin //STR
                mem_w_en = 1'b1;
                wb_en = 1'b0;
            end
            if (s_in == 1'b1) begin // LDR
                mem_r_en = 1'b1;
            end
        end
        else if (mode == 2'b10)begin
            has_src1 = 1'b0;
        end
    end
endmodule
