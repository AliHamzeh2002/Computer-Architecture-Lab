module Val2Generate(input [31: 0] val_rm,
        input [11:0] shift_operand,
        input imm,
        input s_type_signal,
        output reg[31:0] out
);

    wire[4:0] shift_imm = shift_operand[11:7];
    wire[1:0] shift = shift_operand[6:5];

    wire[7:0] immed_8 = shift_operand[7:0];
    wire[3:0] rotate_imm = shift_operand[11:8];

    integer i;

    always @(val_rm, shift_operand, imm, s_type_signal) begin
        out = 32'b0;
        if (s_type_signal) begin  
            out = {{20{shift_operand[11]}}, shift_operand};
        end


        else if (imm) begin // 
            out = {24'b0, immed_8};
            for (i = 0; i < 2 * rotate_imm; i = i + 1) begin
                out = {out[0], out[31:1]};
            end

        end

        else begin 
            case (shift)
                    2'b00: out = val_rm << shift_imm;           // LSL
                    2'b01: out = val_rm >> shift_imm;           // LSR
                    2'b10: out = $signed(val_rm) >>> shift_imm; // ASR
                    2'b11: begin                                    // ROR
                        out = val_rm;
                        for (i = 0; i < shift_imm; i = i + 1) begin
                            out = {out[0], out[31:1]};
                        end
                    end
            endcase

        end            
    end

endmodule