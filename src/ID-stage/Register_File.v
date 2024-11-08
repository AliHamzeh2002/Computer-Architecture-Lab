module RegisterFile (
    input clk, rst,
    input [3:0] src1, src2, wb_dest,
    input [31:0] wb_value,
    input wb_en,
    output [31:0] reg1, reg2
);

    reg [31:0] registers [0:15];

    assign reg1 = registers[src1];
    assign reg2 = registers[src2];
    integer i;

    always @(negedge clk, posedge rst) begin
        if (rst) begin
            for (i = 0; i < 16; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end 
        else if (wb_en) begin
            registers[wb_dest] <= wb_value;
        end
    end
    
endmodule