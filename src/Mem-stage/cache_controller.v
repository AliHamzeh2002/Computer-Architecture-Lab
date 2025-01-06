module cacheController (
    input clk,
    input rst,

    input [31:0] address,
    input [31:0] w_data,
    input mem_r_en,
    input mem_w_en,
    input [63:0] sram_r_data,
    input sram_ready,

    output [31:0] r_data,
    output ready,
    output [31:0] sram_address,
    output [31:0] sram_w_data,
    output sram_r_en,
    output sram_w_en
);

    reg [63:0] way0_data [0:63];
    reg [9:0]  way0_tags [0:63];
    reg [63:0] way0_valid;
    reg [63:0] way1_data [0:63];
    reg [9:0]  way1_tags [0:63];
    reg [63:0] way1_valid;
    reg [63:0] LRU;

    wire [31:0] address_final = address;
    

    wire [2:0] offset = address_final[2:0];
    wire [5:0] index = address_final[8:3];
    wire [9:0] tag = address_final[18:9];

    
    wire way0_hit = (way0_tags[index] == tag) & way0_valid[index];
    wire way1_hit = (way1_tags[index] == tag) & way1_valid[index];
    wire cache_hit = way0_hit | way1_hit;

    wire [63:0] cache_data_out = (way0_hit) ? (way0_data[index]) : (way1_hit) ? (way1_data[index]) : 64'bz;

    wire [63:0] r_block = (cache_hit) ? cache_data_out : (sram_ready) ? sram_r_data : 32'bz;
    assign r_data = (offset == 0) ? r_block[31:0] : r_block[63:32];

    assign sram_r_en = ~cache_hit & mem_r_en;
    assign sram_w_en = mem_w_en;
    assign sram_address = address;
    assign sram_w_data = w_data;

    assign ready = sram_ready;

    integer i;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            for (i = 0; i < 64; i = i + 1) begin
                way0_data[i] <= 64'b0;
                way0_tags[i] <= 10'b0;
                way1_data[i] <= 64'b0;
                way1_tags[i] <= 10'b0;
            end
            LRU <= 64'b0;
            way1_valid <= 64'b0;
            way0_valid <= 64'b0;
        end
        else if (mem_r_en) begin
            if (way0_hit) begin
                LRU[index] <= 0;
            end
            else if (way1_hit) begin
                LRU[index] <= 1;
            end
            else if (sram_ready) begin
                if (LRU[index] == 1) begin
                    way0_data[index] <= sram_r_data;
                    way0_tags[index] <= tag;
                    way0_valid[index] <= 1;
                    LRU[index] = 0;
                end
                else begin
                    way1_data[index] <= sram_r_data;
                    way1_tags[index] <= tag;
                    way1_valid[index] <= 1;
                    LRU[index] = 1;
                end
            end
        end
        else if (mem_w_en) begin
            if (way0_hit) begin
                way0_valid <= 0;
            end
            if (way1_hit) begin
                way1_valid <= 0;
            end
        end
    end
    
endmodule