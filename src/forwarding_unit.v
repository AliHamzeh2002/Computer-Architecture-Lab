module ForwardingUnit (
    input wb_en_mem, wb_en_wb, forward_en,
    input [3:0] src1, src2,
    input [3:0] dest_mem, dest_wb,
    output reg [1:0] sel_src1, sel_src2
);
    always @(*) begin
        if (forward_en)begin
            sel_src1 = 2'b00;
            sel_src2 = 2'b00;
            if (wb_en_mem && dest_mem == src1) begin
                sel_src1 = 2'b01;
            end else if (wb_en_wb && dest_wb == src1) begin
                sel_src1 = 2'b10;
            end else begin
                sel_src1 = 2'b00;
            end

            if (wb_en_mem && dest_mem == src2) begin
                sel_src2 = 2'b01;
            end else if (wb_en_wb && dest_wb == src2) begin
                sel_src2 = 2'b10;
            end else begin
                sel_src2 = 2'b00;
            end
        end
        else begin
            sel_src1 = 2'b00;
            sel_src2 = 2'b00;
        end
    end
    
    
endmodule