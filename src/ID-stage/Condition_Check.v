module ConditionCheck (
    input [3:0] cond,            
    input [3:0] status_reg_out,   
    output reg out                
);

    wire z = status_reg_out[3];   // Zero flag
    wire c = status_reg_out[2];   // Carry flag
    wire v = status_reg_out[1];   // Overflow flag
    wire n = status_reg_out[0];   // Negative flag

    always @(*) begin
        case (cond)
            4'b0000: out = z;                                    // EQ: Z set
            4'b0001: out = ~z;                                   // NE: Z clear
            4'b0010: out = c;                                    // CS/HS: C set
            4'b0011: out = ~c;                                   // CC/LO: C clear
            4'b0100: out = n;                                    // MI: N set
            4'b0101: out = ~n;                                   // PL: N clear
            4'b0110: out = v;                                    // VS: V set
            4'b0111: out = ~v;                                   // VC: V clear
            4'b1000: out = c & ~z;                               // HI: C set and Z clear
            4'b1001: out = ~c | z;                               // LS: C clear or Z set
            4'b1010: out = (n & v) | (~n & ~v);                  // GE: N set and V set, or N clear and V clear (N == V)
            4'b1011: out = (n & ~v) | (~n & v);                  // LT: N set and V clear, or N clear and V set (N != V)
            4'b1100: out = ~z & ((n & v) | (~n & ~v));           // GT: Z clear, and either N == V
            4'b1101: out = z | ((n & ~v) | (~n & v));            // LE: Z set, or N != V
            default: out = 1'b1;                                 // Default case
        endcase
    end
endmodule
