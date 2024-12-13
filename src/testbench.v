module test ();
    reg clk, rst, forward_en;

    datapath dp (
        .clk(clk),
        .rst(rst),
        .forward_en(forward_en)
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