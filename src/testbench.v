module test ();
    reg clk, rst;

    datapath dp (
        .clk(clk),
        .rst(rst)
    );

    always #10 clk = ~clk;
    initial begin
        rst = 0;
        clk = 0;
        #10 rst = 1;
        #10 rst = 0;
        #10000 $stop;
    end
    
endmodule