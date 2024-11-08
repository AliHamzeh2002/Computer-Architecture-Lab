module IfStage (
    input clk, rst, freeze, branch_taken,
    input [31:0] branch_addr, 
    output [31:0] pc, instruction
);
    wire [31:0] pc_adder_out;
    wire [31:0] mux_out;

    PcAdder pc_adder (
        .in(pc),
        .out(pc_adder_out)
    );

    Mux2To1 mux_2_to_1 (
        .in0(pc_adder_out),
        .in1(branch_addr),
        .sel(branch_taken),
        .out(mux_out)
    );

    ProgramCounter program_counter (
        .clk(clk),
        .rst(rst),
        .freeze(freeze),
        .pc_in(mux_out),
        .pc_out(pc)
    );

    InstructionMemory instruction_memory (
        .clk(clk),
        .rst(rst),
        .address(pc),
        .instruction(instruction)
    );
    
endmodule
