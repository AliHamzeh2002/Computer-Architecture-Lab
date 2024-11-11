module ALU(
    input [31:0] scrA, srcB,
    input [3:0] Aluop,
    input C_in, 
    output reg [31:0] ALUResult,
    output reg C,
    output reg V,
    output Z, 
    output N, 
);

  always @(*) begin

    reg [32:0] temp_result;

    case(Aluop)
        4'b0010 : begin // ADD
            temp_result = {1'b0, scrA} + {1'b0, srcB};
            ALUResult = temp_result[31:0];
            C = temp_result[32]; 
            V = (scrA[31] == srcB[31]) && (ALUResult[31] != scrA[31]); 
        end

        4'b0011 : begin // ADC (Add with Carry)
            temp_result = {1'b0, scrA} + {1'b0, srcB} + C_in;
            ALUResult = temp_result[31:0];
            C = temp_result[32];
            V = (scrA[31] == srcB[31]) && (ALUResult[31] != scrA[31]);
        end

        4'b0100 : begin // SUB
            temp_result = {1'b0, scrA} - {1'b0, srcB};
            ALUResult = temp_result[31:0];
            C = ~temp_result[32];
            V = (scrA[31] != srcB[31]) && (ALUResult[31] != scrA[31]);
        end

        4'b0101 : begin // SBC 
            temp_result = {1'b0, scrA} - {1'b0, srcB} - ~C_in;
            ALUResult = temp_result[31:0];
            C = ~temp_result[32];
            V = (scrA[31] != srcB[31]) && (ALUResult[31] != scrA[31]);
        end

        4'b0110 : begin // AND (also TST)
            ALUResult = scrA & srcB;
            C = 0; 
            V = 0;
        end

        4'b0111 : begin // ORR
            ALUResult = scrA | srcB;
            C = 0;
            V = 0; 
        end

        4'b1000 : begin // EOR
            ALUResult = scrA ^ srcB;
            C = 0;
            V = 0;
        end

        4'b0001 : begin // MOV
            ALUResult = srcB;
            C = 0;
            V = 0;
        end

        4'b1001 : begin // MVN
            ALUResult = ~srcB;
            C = 0;
            V = 0;
        end

        default : begin
            ALUResult = 32'd0;
            C = 0;
            V = 0;
        end
    endcase

 
    assign Z = (ALUResult == 32'd0) ? 1'b1 : 1'b0;
    assign N = ALUResult[31];

  end
endmodule
