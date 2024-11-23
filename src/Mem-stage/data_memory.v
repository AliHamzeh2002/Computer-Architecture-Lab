module DataMemory (
    input clk,
    input mem_w_en,
    input mem_r_en,
    input [31:0] alu_res,
    input [31:0] val_rm,
    output reg [31:0] out 
);
    
    reg [31:0] memory [0:63];

    wire [31:0] address = alu_res - 32'd1024;
    wire [31:0] final_address = {2'b00, address[31:2]};

    always @(posedge clk) begin
        if(mem_w_en) begin
            memory[final_address] <= val_rm;
        end
    end

    always @(mem_r_en, final_address) begin
        if(mem_r_en) begin
            out <= memory[final_address];
        end
    end
        
endmodule