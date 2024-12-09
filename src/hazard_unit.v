module HazardUnit (
    input [3:0] src1, src2,
    input [3:0] exe_dest, 
    input exe_wb_en, forward_en, exe_mem_r_en,
    input [3:0] mem_dest,
    input mem_wb_en, two_src,
    output reg hazard
);
    always @(*) begin
        hazard = 1'b0;
        if (forward_en)begin 
            if (src1 == exe_dest && exe_wb_en && exe_mem_r_en) begin
                hazard = 1'b1;
            end
            if (src2 == exe_dest && exe_wb_en && exe_mem_r_en && two_src) begin
                hazard = 1'b1;
            end
        end
        else begin
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
    end
    
endmodule