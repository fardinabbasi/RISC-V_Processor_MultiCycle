module Register_ctrl(clk, rst, sel,Input, Output);
	input [31:0] Input;
	input clk, rst,sel;
	output [31:0] Output;
	reg [31:0] Output;
	always@(posedge clk)begin
		if(rst) 
			Output <= 32'b0;
		else Output <=(sel==1'b1)? Input:Output;
	end
endmodule