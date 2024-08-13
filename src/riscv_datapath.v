//module multiDatapath(input clk,rst,memWrite,regWrite,WD3Src,PC4Write,PCWrite,AdrSrc,input[1:0]ResultSrc,PCSrc,input [2:0]Imm_Src,input [2:0]ALUControl
//,output [6:0]OP,funct7,output [2:0] funct3,output Zero);
module multiDatapath
(
    output  [6:0] OP,funct7,
    output  [2:0] funct3,
    output  Zero,
    input regWrite,PCWrite,AdrSrc,MemWrite,IRWrite,WD3Src,PC4Write,clk,rst,
    input [1:0] ResultSrc,ALUSrcA,ALUSrcB,
    input [2:0] ALUControl,
    input [2:0] ImmSrc
);
wire [31:0] PC,Adr,WriteData,Instr,ReadData,OldPC,Data,PC4Hold,Result,WD3Line,Rd1,Rd2,A,SrcA,SrcB,ALUResult,ALUOut,ImmExt;
wire [4:0] Rs1,Rs2,Rd;
wire [24:0] Imm;


Register_ctrl pcreg(.clk(clk), .rst(rst), .sel(PCWrite),.Input(Result), .Output(PC));
//Register pcreg (.clk(clk), .rst(rst), .Input(Result), .Output(PC));
mux2 Amux( .In0(PC), .In1(Result),.Sel(AdrSrc),.Result(Adr));
instrdatamem InstrDataMemory(.WD(WriteData),.A(Adr),.clk(clk),.WE(MemWrite),.rst(rst),.RD(ReadData));
Register_ctrl insthold(.clk(clk),  .rst(rst), .sel(IRWrite),.Input(ReadData), .Output(Instr));
Register_ctrl pchold(.clk(clk),  .rst(rst), .sel(IRWrite),.Input(PC), .Output(OldPC));
Register readDataHold(.clk(clk),  .rst(rst), .Input(ReadData), .Output(Data));
instructionDivider divider(.instruction(Instr),.A1(Rs1),.A2(Rs2),.A3(Rd),.OP(OP),.funct3(funct3),.Imm(Imm),.funct7(funct7));
Register_ctrl pcplus4hold(.clk(clk), .rst(rst), .sel(PC4Write),.Input(Result),.Output(PC4Hold));
//Register pcplus4hold(.clk(clk), .rst(rst), .Input(Result),.Output(PC4Hold));
mux2 behindWD3(.In0(Result), .In1(PC4Hold),.Sel(WD3Src),.Result(WD3Line));
Register_File registerFile(.A1(Rs1),.A2(Rs2),.A3(Rd),.WD3(WD3Line), .clk(clk),.WE3(regWrite),.rst(rst),.RD1(Rd1),.RD2(Rd2));
sign_ext extended(.Imm_Src(ImmSrc),.d_in(Imm),.ImmExt(ImmExt));
Register Ahold(.clk(clk), .rst(rst), .Input(Rd1), .Output(A));
Register Bhold(.clk(clk), .rst(rst), .Input(Rd2), .Output(WriteData));
mux3 Amux3(.In0(PC), .In1(OldPC), .In2(A),.Sel(ALUSrcA),.Result(SrcA));
mux3puls4 Bmux3 (.In0(WriteData), .In1(ImmExt),.Sel(ALUSrcB),.Result(SrcB));
alu aluxx(.SrcA(SrcA),.SrcB(SrcB), .ALUControl(ALUControl),.funct3(funct3),.ALUResult(ALUResult),.Zero(Zero)  );
Register aluresulthold(.clk(clk), .rst(rst), .Input(ALUResult), .Output(ALUOut));
result_mux mux4(.ALUOut(ALUOut), .Data(Data), .ALUResult(ALUResult),.ImmExt(ImmExt),.ResultSrc(ResultSrc),.Result(Result));





endmodule