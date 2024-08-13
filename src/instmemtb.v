`timescale 1ns/1ns
module instmemtb();
reg rst,clk,WE;
reg [31:0] A,WD;
wire[31:0]RD;

instrdatamem xx(
    WD,
    A,
    clk,WE,rst,
    RD
);
 initial
  begin
    WD=32'd15;
    A=32'd60;
    WE=0;
    clk = 1'b1;
    #5 rst=0;
    
  end
  
  always #10 clk=~clk;
  initial 	begin
    #5 WE=1;
    #20 WE=0;
    #5 WD=32'd600;
    #5 A=32'd2400;
    #20 WE=1;
    #20 WE=0;
    #60 A=32'd8;
    #40 A=32'd2008;
    #200 $stop;
  end
endmodule
