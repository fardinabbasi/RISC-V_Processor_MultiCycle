/*
`timescale 1ns/1ns
module instrdatamem (
    input [31:0] WD,
    input [31:0] A,
    input clk,WE,rst,
    output reg [31:0] RD
);
    reg [31:0] Data_Mem [0:31];
initial begin
       Data_Mem[0] <= 32'h0x00000005;
       Data_Mem[1] <= 32'h0xFFFFFFFB; //32'hFFC4A303; 0x8CDEFAB7
       Data_Mem[2] <= 32'h0x0000000A;
       Data_Mem[3] <= 32'h0x00000041;
       Data_Mem[4] <= 32'h0xFFFFFFDC; 
       Data_Mem[5] <= 32'h0xFFFFFF91;
       Data_Mem[6] <= 32'h0x0000004B;
       Data_Mem[7] <= 32'h0x00000059;
       Data_Mem[8] <= 32'h0x00000290;
       Data_Mem[9] <= 32'h0xFFFFFCFE; 
end
    integer i;
    always @(*) begin
        RD <= Data_Mem[A/4];
    end
    always @(posedge clk) begin
       // if (rst) begin
         //   for(i=0;i<32;i=i+1)
        //         Data_Mem[i] <= 32'd0;end
        if (WE) begin
            Data_Mem[A/4] <= WD; 
        end
    end
endmodule
*/
`timescale 1ns/1ns
module instrdatamem (
    input [31:0] WD,
    input [31:0] A,
    input clk,WE,rst,
    output reg [31:0] RD
);
    reg [31:0] Data_Mem [0:499];
    reg [31:0] Inst_Mem [0:499];
    reg [31:0]temp[0:999];
initial begin
   $readmemh("datamem.txt", Data_Mem);
   $readmemh("instmem.txt", Inst_Mem);
end
integer i;
always @(*) begin
  for (i=0;i<500;i=i+1) begin
    temp[i] = Inst_Mem[i];
  end
end
always @(*) begin
  for (i=0;i<500;i=i+1) begin
    temp[i+500] = Data_Mem[i];
  end
end

    always @(*) begin
        RD <= temp[A/4];
    end
    always @(posedge clk) begin
       // if (rst) begin
         //   for(i=0;i<32;i=i+1)
        //         Data_Mem[i] <= 32'd0;end
        if (WE) begin
            temp[A/4] <= WD; 
        end
    end
endmodule