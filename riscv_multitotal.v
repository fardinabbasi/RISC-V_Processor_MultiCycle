`timescale 1ns/1ns
module risc_multitotal(input rst,clk);



wire [6:0] OP,funct7
;
wire Zero,regWrite,PCWrite,AdrSrc,MemWrite,IRWrite,WD3Src,PC4Write
;
wire [1:0] ResultSrc,ALUSrcA,ALUSrcB;
wire [2:0] ALUControl,ImmSrc,funct3;

multiDatapath dp
(.OP(OP),.funct7(funct7),.funct3(funct3),.Zero(Zero),.regWrite(regWrite),.PCWrite(PCWrite),.AdrSrc(AdrSrc),.MemWrite(MemWrite),.IRWrite(IRWrite),.WD3Src(WD3Src),.PC4Write(PC4Write),.clk(clk),.rst(rst),.ResultSrc(ResultSrc),.ALUSrcA(ALUSrcA),.ALUSrcB(ALUSrcB),.ALUControl(ALUControl),.ImmSrc(ImmSrc));
MultiController conxx(.OP(OP),.funct7(funct7),.funct3(funct3), .Zero(Zero),.clk(clk),.rst(rst),.regWrite(regWrite),.PCWrite(PCWrite),.AdrSrc(AdrSrc),.MemWrite(MemWrite),.IRWrite(IRWrite),.WD3Src(WD3Src),.PC4Write(PC4Write),.ResultSrc(ResultSrc),.ALUSrcA(ALUSrcA),.ALUSrcB(ALUSrcB),.ALUControl(ALUControl), .ImmSrc(ImmSrc));
endmodule