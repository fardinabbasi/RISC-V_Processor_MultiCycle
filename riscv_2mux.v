module mux2 (input  [31:0] In0, In1,input   Sel,output [31:0] Result);
     assign Result = (Sel==1'b0)?In0:In1;
endmodule