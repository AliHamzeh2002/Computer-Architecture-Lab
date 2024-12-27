module cacheController (
    input clk,
    input rst,

    input [31:0] address,
    input [31:0] w_data,
    input mem_r_en,
    input mem_w_en,
    output [31:0] r_data,
    output ready,

    output [31:0] sram_address,
    output [31:0] sram_w_data,
    output write,
    input [63:0] sram_r_data,
    input sram_ready

);

    reg [63:0] way0_data [0:63];
    reg [9:0]  way0_tags [0:63];
    reg [63:0] way0_valid;
    reg [63:0] way1_data [0:63];
    reg [9:0]  way1_tags [0:63];
    reg [63:0] way1_valid;
    

    wire [2:0] offset = address[2:0];
    wire [5:0] index = address[8:3];
    wire [9:0] tag = address[18:9];

    
    wire way0_hit = (way0_tags[index] == tag) && way0_valid[index];
    wire way1_hit = (way1_tags[index] == tag) && way1_valid[index];
    wire cache_hit = way0_hit | way1_hit;

    wire [63:0] cache_data_out = (way0_hit) ? (way0_data[index]) : (way1_hit) ? (way1_data[index]) : 64'bz;
    

    
endmodule