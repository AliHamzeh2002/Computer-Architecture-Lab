module WbStage (
    input wb_en,
    input mem_r_en,
    input [31:0] alu_res,
    input [31:0] data_mem_res,
    input [3:0] dest,
    output wb_wb_en,
    output [3:0] wb_dest,
    output [31:0] wb_value
);
    assign wb_wb_en = wb_en;
    assign wb_dest = dest;
    assign wb_value =  (mem_r_en) ? data_mem_res : alu_res;
    
endmodule