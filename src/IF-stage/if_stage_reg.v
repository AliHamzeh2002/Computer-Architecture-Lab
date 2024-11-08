module IfStageReg (
    input clk, rst, freeze, flush,
    input [31:0] pc_in, instruction_in,
    output reg [31:0] pc_out, instruction_out
);
    always@(posedge clk, posedge rst) begin
        if (rst) begin
            pc_out <= 32'h0;
            instruction_out <= 32'h0;
        end
        else begin
            pc_out <= pc_in;
            instruction_out <= instruction_in;
        end
    end
    
endmodule
