module test ();
    reg clk, rst, forward_en;
    wire [15:0] SRAM_DQ;
    wire [17:0] SRAM_ADDR;
    wire SRAM_UB_N;
    wire SRAM_LB_N;
    wire SRAM_WE_N;
    wire SRAM_CE_N;
    wire SRAM_OE_N;

    datapath dp (
        .clk(clk),
        .rst(rst),
        .forward_en(forward_en),
        .SRAM_DQ(SRAM_DQ),
        .SRAM_ADDR(SRAM_ADDR),
        .SRAM_UB_N(SRAM_UB_N),
        .SRAM_LB_N(SRAM_LB_N),
        .SRAM_WE_N(SRAM_WE_N),
        .SRAM_CE_N(SRAM_CE_N),
        .SRAM_OE_N(SRAM_OE_N)
    );

    always #10 clk = ~clk;
    initial begin
        rst = 0;
        clk = 0;
        #10 rst = 1;
        #10 rst = 0;
        forward_en = 1;
        #100000 $stop;
    end
    
endmodule