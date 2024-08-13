`timescale 1ns/1ns
module regtb();
reg rst,clk,sel;
reg [31:0] in;
wire[31:0]out;

Register_ctrl xx(clk,rst,sel,in,out);
 initial
  begin
    in=32'd3;
    sel=0;
    rst = 1'b1;
    clk = 1'b1;
    #5 rst=0;
    
  end
  
  always #10 clk=~clk;
  initial 	begin
    #30 in=32'd6;
    #7 sel=1;
    #5 sel=0;

    #33 in=32'd9;
    #7 sel=1;
    #4 sel=0;
    #2 sel=1;
    #20 sel=0;
    #200 $stop;
  end
endmodule
