module mux3 (input  [31:0] In0, In1, In2,input  [1:0] Sel,output [31:0] Result);
     assign Result = (Sel==2'b00)?In0:(Sel==2'b01)?In1:In2;
endmodule