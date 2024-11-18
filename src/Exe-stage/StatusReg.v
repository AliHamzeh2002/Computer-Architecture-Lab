module StatusReg(
    input clk,rst,
    input wb_en,
    input [3:0] in_data,
    output reg [3:0] out_data 
);
        always @(posedge clk or posedge rst) begin
            if(rst) begin
                out_data <= 4'b0;
            end
            else if(wb_en) begin
                out_data <= in_data;
            end
        end
    
endmodule