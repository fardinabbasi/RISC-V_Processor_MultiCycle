`timescale 1ns/1ns
module instructionDivider (
    input [31:0] instruction,
    output reg [4:0] A1,A2,A3,
    output reg [6:0] OP,
    output reg [2:0] funct3,
    output reg [24:0] Imm,
    output reg [6:0] funct7
);
    always @(*) begin
        A1 <= instruction[19:15];
        A2 <= instruction[24:20];
        A3 <= instruction[11:7];
        OP <= instruction[6:0];
        funct3 <= instruction[14:12];
        Imm <= instruction[31:7];
        funct7 <= instruction[31:25];
    end
endmodule