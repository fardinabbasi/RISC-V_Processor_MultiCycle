module Register(clk, rst, Input, Output);
	input [31:0] Input;
	input clk, rst;
	output [31:0] Output;
	reg [31:0] Output;
	//initial begin Output <= 32'b0; end
	always@(posedge clk)begin
		if(rst) 
			Output <= 32'b0;
		else Output <= Input;
	end
endmodule