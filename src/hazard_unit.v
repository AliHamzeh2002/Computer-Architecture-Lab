module HazardUnit (
    input [3:0] src1, src2,
    input [3:0] exe_dest, 
    input exe_wb_en,
    input [3:0] mem_dest,
    input mem_wb_en, two_src,
    output reg hazard
);
    always @(*) begin
        hazard = 1'b0;
        if (src1 == exe_dest && exe_wb_en) begin
            hazard = 1'b1;
        end
        if (src1 == mem_dest && mem_wb_en) begin
            hazard = 1'b1;
        end
        if (src2 == exe_dest && exe_wb_en && two_src) begin
            hazard = 1'b1;
        end
        if (src2 == mem_dest && mem_wb_en && two_src) begin
            hazard = 1'b1;
        end
    end
    
endmodule