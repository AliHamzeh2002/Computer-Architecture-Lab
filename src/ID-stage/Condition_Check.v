module ConditionCheck (
    input [3:0] cond,            
    input [3:0] status_reg_out,   
    output reg out                
);

    wire Z = status_reg_out[0];   // Zero flag
    wire C = status_reg_out[1];   // Carry flag
    wire V = status_reg_out[2];   // Overflow flag
    wire N = status_reg_out[3];   // Negative flag

    always @(*) begin
        case (cond)
            4'b0000: out = Z;                                    // EQ: Z set
            4'b0001: out = ~Z;                                   // NE: Z clear
            4'b0010: out = C;                                    // CS/HS: C set
            4'b0011: out = ~C;                                   // CC/LO: C clear
            4'b0100: out = N;                                    // MI: N set
            4'b0101: out = ~N;                                   // PL: N clear
            4'b0110: out = V;                                    // VS: V set
            4'b0111: out = ~V;                                   // VC: V clear
            4'b1000: out = C & ~Z;                               // HI: C set and Z clear
            4'b1001: out = ~C | Z;                               // LS: C clear or Z set
            4'b1010: out = (N & V) | (~N & ~V);                  // GE: N set and V set, or N clear and V clear (N == V)
            4'b1011: out = (N & ~V) | (~N & V);                  // LT: N set and V clear, or N clear and V set (N != V)
            4'b1100: out = ~Z & ((N & V) | (~N & ~V));           // GT: Z clear, and either N == V
            4'b1101: out = Z | ((N & ~V) | (~N & V));            // LE: Z set, or N != V
            //4'b1110: out = 1'b1;                                 // AL: Always true (unconditional)
            default: out = 1'b1;                                 // Default case
        endcase
    end
endmodule
