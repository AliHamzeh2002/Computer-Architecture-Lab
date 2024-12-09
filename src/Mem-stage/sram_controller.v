`define IDLE         6'd0
`define DATA_LOW     6'd1
`define DATA_HIGH    6'd2
`define WAIT1        6'd3
`define WAIT2        6'd4
`define DONE         6'd5

module SramController(
    input clk,
    input rst,
    input wr_en,
    input rd_en,
    input [31:0] address,
    input [31:0] write_data,
    output reg [31:0] read_data,
    output reg ready,

    inout [15:0] SRAM_DQ,
    output reg [17:0] SRAM_ADDR,
    output SRAM_UB_N,
    output SRAM_LB_N,
    output reg SRAM_WE_N,
    output SRAM_CE_N,
    output SRAM_OE_N
);
    assign {SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N} = 4'b0000;

    wire [31:0] mem_addr;
    wire [17:0] sram_low_addr, sram_high_addr;
    assign mem_addr = address - 32'd1024;
    assign sram_low_addr = {mem_addr[18:2], 1'd0};
    assign sram_high_addr = sram_low_addr + 18'd1;

    reg [15:0] data_queue;

    assign SRAM_ADDR = (wr_en) ? data_queue : 16'bz;

    reg [2:0] ps, ns;

    always @(ps, wr_en, rd_en) begin
        case (ps)
            `IDLE: ns = (wr_en) ? `DATA_LOW : (rd_en) ? `DATA_LOW : `IDLE;
            `DATA_LOW: ns = `DATA_HIGH;
            `DATA_HIGH: ns = `WAIT1;
            `WAIT1: ns = `WAIT2;
            `WAIT2: ns = `DONE;
            `DONE: ns = `IDLE;
            default: ns = `IDLE;
        endcase
    end

    always @(*) begin
        SRAM_ADDR = 18'b0;
        SRAM_WE_N = 1'b1;
        ready = 1'b0;

        case (ps)
            `IDLE: ready = ~(wr_en | rd_en);
            `DATA_LOW: begin
                SRAM_ADDR = sram_low_addr;
                SRAM_WE_N = (wr_en) ? 1'b0 : 1'b1;
                if (wr_en) begin
                    data_queue = write_data[15:0];
                end
            end
            `DATA_HIGH: begin
                SRAM_ADDR = sram_high_addr;
                SRAM_WE_N = (wr_en) ? 1'b0 : 1'b1;
                if (wr_en) begin
                    data_queue = write_data[31:16];
                end
                if (rd_en) begin
                    read_data[15:0] = SRAM_DQ;
                end
            end
            `WAIT1: begin
                if (rd_en) begin
                    read_data[31:16] = SRAM_DQ;
                end
            end
            `WAIT2:;
            `DONE: ready = 1'b1;
            default:;
        endcase
    end

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            ps <= `IDLE;
        end
        else begin
            ps <= ns;
        end
    end



endmodule