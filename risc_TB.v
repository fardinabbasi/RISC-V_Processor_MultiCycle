`timescale 1ns/1ns
module risc_multiTB();
reg rst,clk;
risc_multitotal CPU(rst,clk);
 initial
  begin
    rst = 1'b1;
    clk = 1'b0;
    #12 rst=0;
    
  end
  
  always #10 clk=~clk;
  initial 	begin
    
    #20000 $stop;
  end
endmodule
