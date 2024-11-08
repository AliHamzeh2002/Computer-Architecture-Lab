module Control_Unit (
    input[1:0] mode,
    input[3:0] opcode,
    input S,
    output B, update_status_reg,
    output reg WB_Enable, mem_read, mem_write, 
    output reg [3:0] execute_command
);

    assign update_status_reg = (mode == 2'b0) ? S : 1'b0;
    assign B = (mode == 2'b10) ? 1'b1 : 1'b0;
    always @(mode, opcode, S) begin
        execute_command = 4'b0000;
        WB_Enable = 1'b0;
        mem_read = 1'b0;
        mem_write = 1'b0;
        if (mode == 2'b0) begin
            case (opcode)
                4'b1101: execute_command = 4'b0001; // MOV
                4'b1111: execute_command = 4'b1001; // MVN
                4'b0100: execute_command = 4'b0010; // ADD
                4'b0101: execute_command = 4'b0011; // ADC
                4'b0010: execute_command = 4'b0100; // SUB
                4'b0110: execute_command = 4'b0101; // SBC
                4'b0000: execute_command = 4'b0110; // AND
                4'b1100: execute_command = 4'b0111; // ORR
                4'b0001: execute_command = 4'b1000; // EOR
                4'b1010: execute_command = 4'b0100; // CMP
                4'b1000: execute_command = 4'b0110; // TST
                default: execute_command = 4'b0000; // NOP
            endcase
        end
        else if (mode == 2'b01 && opcode == 4'b0010)begin // STR LDR
            execute_command = 4'b0010;
            if (S == 1'b1)begin
                mem_write = 1'b1;
            end
            if (S == 1'b0) begin
                mem_read = 1'b1;
                WB_Enable = 1'b1;
            end
        end
    end
endmodule