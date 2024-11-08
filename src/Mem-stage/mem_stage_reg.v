module MemStageReg (
    input clk, rst,
    input [31:0] pc_in,
    output reg [31:0] pc_out
);
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            pc_out <= 32'h0;
        end else begin
            pc_out <= pc_in;
        end
    end
  
endmodule