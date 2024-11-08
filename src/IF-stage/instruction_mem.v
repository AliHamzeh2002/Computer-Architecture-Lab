module instruction_Memory (
    input clk, rst,
    input [31:0] address,
    output reg [31:0] instruction
);
    // reg [31:0] mem [0:1023];
    // initial begin
    //     $readmemh("instructions.hex", mem);
    // end
    // assign instruction = mem[pc];

    //instructions:
    /*
    32'b000000_00001_00010_00000_00000000000;
    32'b000000_00011_00100_00000_00000000000;
    32'b000000_00101_00110_00000_00000000000;
    32'b000000_00111_01000_00010_00000000000;
    32'b000000_01001_01010_00011_00000000000;
    32'b000000_01011_01100_00000_00000000000;
    32'b000000_01101_01110_00000_00000000000;
    */
    always @(*) begin
        case (address)
            32'd0  : instruction <= 32'b1110_00_1_1101_0_0000_0000_000000010100; // MOV R0, #20
            32'd4  : instruction <= 32'b1110_00_1_1101_0_0000_0001_101000000001; // MOV R1, #4096
            32'd8  : instruction <= 32'b1110_00_1_1101_0_0000_0010_000100000011; // MOV R2, #0xC0000000
            32'd12 : instruction <= 32'b1110_00_0_0100_1_0010_0011_000000000010; // ADDS R3, R2, R2
            32'd16 : instruction <= 32'b1110_00_0_0101_0_0000_0100_000000000000; // ADC R4, R0, R0
            32'd20 : instruction <= 32'b1110_00_0_0010_0_0100_0101_000100000100; // SUB R5, R4, R4, LSL #2
            default: instruction <= 32'b000000_00000_00000_00000_00000000000;      // Default to NOP
        endcase
    end

    
endmodule