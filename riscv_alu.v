/* ALU Arithmetic and Logic Operations
----------------------------------------------------------------------
|ALU_Sel|   ALU Operation
----------------------------------------------------------------------
| 000  |   ALU_Out = A + B;
----------------------------------------------------------------------
| 001  |   ALU_Out = A - B;
----------------------------------------------------------------------
| 010  |   ALU_Out = A & B;
----------------------------------------------------------------------
| 011  |   ALU_Out = A | B;
----------------------------------------------------------------------
| 100  |   ALU_Out = A slt B;
----------------------------------------------------------------------
| 101  |   ALU_Out = A XOR B;
----------------------------------------------------------------------*/
module alu(
           input [31:0] SrcA,SrcB,  // ALU 32-bit Inputs
           input [2:0] ALUControl,// ALU Selection
           input [2:0] funct3,
           output[31:0] ALUResult, // ALU 32-bit Output
       output reg Zero  // Zero Flag
    );
    reg [31:0] ALU_Result;
    wire [32:0] tmp;
    assign ALUResult = ALU_Result; // ALU out
    assign tmp = {1'b0,SrcA} + {1'b0,SrcB};
  //assign Zero = (ALU_Result == 0);  // Zero Flag ALU_Result
  always @(*)
  begin
     case(funct3)
     3'b000: Zero <= SrcA == SrcB; //beq
     3'b001: Zero <=  SrcA != SrcB; //bne
     3'b100: Zero <=  $signed(SrcA) < $signed(SrcB); //blt
     3'b101: Zero <=  $signed(SrcA) > $signed(SrcB); //bge
     default : Zero <= 0;
     endcase
  end
    always @(*)
    begin
        case(ALUControl)
        3'b000: ALU_Result = SrcA + SrcB ;
        3'b001: ALU_Result = SrcA - SrcB ;
        3'b010: ALU_Result = SrcA & SrcB;
        3'b011: ALU_Result = SrcA | SrcB;
        3'b100: ALU_Result = ($signed(SrcA)<$signed(SrcB))?32'd1:32'd0;
        3'b101: ALU_Result = SrcA ^ SrcB;
        default: ALU_Result = SrcA + SrcB;
        endcase
    end
endmodule
