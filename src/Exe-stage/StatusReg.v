module StatusReg(
    input clk,rst,
    input status_en,
    input [3:0] in_data,
    output reg [3:0] out_data 
);
        always @(negedge clk, posedge rst) begin
            if(rst) begin
                out_data <= 4'b0;
            end
            else if(status_en) begin
                out_data <= in_data;
            end
        end
    
endmodule