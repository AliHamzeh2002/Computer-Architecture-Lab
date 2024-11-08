module IF_Stage (
    input clk, rst, freeze, Branch_taken,
    input [31:0] BranchAddr, 
    output [31:0] PC, Instruction
);
    wire [31:0] PC_Adder_Out;
    wire [31:0] PC_Out;
    wire [31:0] mux_Out;
    wire [31:0] instruction_Memory_Out;

    pc_Adder pc_Adder (
        .in(PC_Out),
        .out(PC_Adder_Out)
    );

    mux_2_to_1 mux_2_to_1 (
        .in0(PC_Adder_Out),
        .in1(BranchAddr),
        .sel(Branch_taken),
        .out(mux_Out)
    );

    program_Counter program_Counter (
        .clk(clk),
        .rst(rst),
        .freeze(freeze),
        .pc_in(mux_Out),
        .pc_out(PC_Out)
    );

    instruction_Memory instruction_Memory (
        .clk(clk),
        .rst(rst),
        .address(PC_Out),
        .instruction(instruction_Memory_Out)
    );

    assign PC = PC_Out;
    assign Instruction = instruction_Memory_Out;





    
endmodule