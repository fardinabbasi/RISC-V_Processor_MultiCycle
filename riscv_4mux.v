module result_mux (input  [31:0] ALUOut, Data, ALUResult,ImmExt,input  [1:0] ResultSrc,output [31:0] Result);
     assign Result = (ResultSrc==2'b00)?ALUOut:(ResultSrc==2'b01)?Data:(ResultSrc==2'b10)?ALUResult:ImmExt;
endmodule