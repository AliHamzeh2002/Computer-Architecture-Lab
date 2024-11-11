module Status_Reg(
    input clk,rst,
    input wb_en,
    input Z,V,C,N,
    output reg Z_reg,V_reg,C_reg,N_reg,
);
    
        always @(posedge clk or posedge rst) begin
            if(rst) begin
                Z_reg <= 1'b0;
                V_reg <= 1'b0;
                C_reg <= 1'b0;
                N_reg <= 1'b0;
            end
            else if(wb_en) begin
                Z_reg <= Z;
                V_reg <= V;
                C_reg <= C;
                N_reg <= N;
            end
        end
    
endmodule