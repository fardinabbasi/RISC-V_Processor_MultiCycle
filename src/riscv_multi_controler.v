`timescale 1ns/1ns
module MultiController (
    input [6:0] OP,funct7,
    input [2:0] funct3,
    input Zero,clk,rst,
    output reg regWrite,PCWrite,AdrSrc,MemWrite,IRWrite,WD3Src,PC4Write,
    output reg [1:0] ResultSrc,ALUSrcA,ALUSrcB,
    output reg [2:0] ALUControl,
    output reg [2:0] ImmSrc
);
reg branch,jump;
reg [2:0] ALUOP;
wire [9:0] check;
assign check={{funct7},{funct3}};
reg [4:0] ps,ns;
parameter [4:0]
IF=0,ID=1,STEX=2,LWEX=3,STMEM=4,LWMEM=5,LWWB=6,RTEX=7,RTMEM=8,JALMEM=9,JALEX=10,JALRMEM=11,JALREX=12,UTEX=13,BTEX=14,ITEX=15,ITMEM=16;
always @(posedge clk)begin
		if(rst)
			ps <= IF;
		else
			ps <= ns;
end
always@(ps,OP)begin
		ns=IF;
		case(ps)
		IF:
			ns=ID;
		ID:begin
			ns=(OP==7'b0110011)?RTEX:
                (OP==7'b0100011)?STEX:
                (OP==7'b0000011)?LWEX:
                (OP==7'b1100011)?BTEX:
                (OP==7'b1101111)?JALMEM:
                (OP==7'b1100111)?JALRMEM:
                (OP==7'b0110111)?UTEX:
                (OP==7'b0010011)?ITEX:IF;end
		BTEX:
			ns=IF;
		RTEX:
			ns=RTMEM;
		RTMEM:
			ns=IF;
		STEX:
			ns=STMEM;
		STMEM:
			ns=IF;
		LWEX:
			ns=LWMEM;
        LWMEM:
			ns=LWWB;
        LWWB:
			ns=IF;
        JALMEM:
			ns=JALEX;
        JALEX:
			ns=IF;
        JALRMEM:
			ns=JALREX;
        JALREX:
			ns=IF;
        UTEX:
			ns=IF;
        BTEX:
			ns=IF;
        ITEX:
			ns=ITMEM;
        ITMEM:
			ns=IF;
        default: 
            ns=IF;
		endcase
end
always@(posedge clk, ps)begin
{PC4Write,MemWrite,IRWrite,regWrite,WD3Src,branch,jump}=7'b0;
{AdrSrc,ResultSrc,ALUSrcA,ALUSrcB,ImmSrc,ALUOP}=13'bxxxxxxxxxxxxx;
    case(ps)
        IF: begin
        AdrSrc=0;
        IRWrite=1'b1;
        ALUSrcA=2'b0;
        ALUSrcB=2'b10;
        ALUOP=3'b000;
        ResultSrc=2'b10;
        //PCWrite=1'b1;
        PC4Write=1'b1;
        end
        ID: begin
        ALUSrcA=2'b01;
        ALUSrcB=2'b01;
        ALUOP=3'b00;
        ImmSrc=3'b010;
        end
        BTEX: begin
        ALUSrcA=2'b10;
        ALUSrcB=2'b00;
        ALUOP=3'b011;
        ResultSrc=2'b00;
        branch=1;
        end
        RTEX: begin
        ALUSrcA=2'b10;
        ALUSrcB=2'b00;
        ALUOP=10;
        end
        RTMEM: begin
        ResultSrc=2'b00;
        regWrite=1;
        end
        STEX: begin
        ImmSrc=3'b001;
        ALUSrcA=2'b10;
        ALUSrcB=2'b01;
        ALUOP=3'b000;
        end
        STMEM: begin
        ResultSrc=2'b00;
        AdrSrc=1;
        MemWrite=1;
        end
        LWEX: begin
        ImmSrc=3'b000;
        ALUSrcA=2'b10;
        ALUSrcB=2'b01;
        ALUOP=3'b000;
        end
        LWMEM: begin
        ResultSrc=2'b00;
        AdrSrc=1;
        end
        LWWB: begin
        ResultSrc=2'b01;
        regWrite=1;
        end
        JALMEM: begin
        WD3Src=1;
        regWrite=1;
        end
        JALEX: begin
        ImmSrc=3'b100;
        ALUSrcA=2'b01;
        ALUSrcB=2'b01;
        ALUOP=3'b000;
        ResultSrc=2'b10;
        jump=1;
        end
        JALRMEM: begin
        WD3Src=1;
        regWrite=1;
        end
        JALREX: begin
        ImmSrc=3'b100;
        ALUSrcA=2'b10;
        ALUSrcB=2'b01;
        ALUOP=3'b000;
        ResultSrc=2'b10;
        jump=1;
        end
        UTEX: begin
        ImmSrc=3'b011;
        ResultSrc=2'b11;
        regWrite=1;
        end
        ITEX: begin
        ImmSrc=3'b000;
        ALUSrcA=2'b10;
        ALUSrcB=2'b01;
        ALUOP=3'b100;
        end
        ITMEM: begin
        ResultSrc=2'b00;
        regWrite=1;
        end
    endcase
end
always@(ALUOP,check,funct3,funct7)begin
    case(ALUOP)
        3'b000:begin
        ALUControl=3'b000;
        end
        3'b001:begin
        ALUControl=3'b001;
        end
        3'b010:begin
        ALUControl=(check==10'b0)?3'b0:
                  (check==10'd256)?3'b001:
                  (check==10'd7)?3'b010:
                  (check==10'd6)?3'b011:
                  (check==10'd2)?3'b100:3'bxxx;
        end
        3'b011:begin
        ALUControl=(funct3==3'b0)?3'b001:
                   (funct3==3'b001)?3'b001:
                   (funct3==3'b100)?3'b100:
                   (funct3==3'b101)?3'b100:3'bxxx;
        end
        3'b100:begin
        ALUControl=(funct3==3'b0)?3'b000:
                   (funct3==3'b110)?3'b011:
                   (funct3==3'b100)?3'b101:
                   (funct3==3'b010)?3'b100:3'bxxx;
        end

    endcase
end
always @(posedge clk,ps,jump,branch,jump,Zero)begin
         PCWrite =((ps==IF )|| (jump==1)|| (branch&&Zero))?1'b1:1'b0;
end





endmodule







