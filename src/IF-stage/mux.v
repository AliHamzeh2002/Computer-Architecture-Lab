module  mux_2_to_1 #(parameter N = 32)(
    input [N-1:0] in0, in1,
    input sel,
    output [N-1:0] out
);
    assign out = (sel == 1'b0) ? in0 : in1;
    
endmodule