`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/11 21:31:19
// Design Name: 
// Module Name: single_cycle_CPU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module single_cycle_CPU(
    input key_in,
    input system_clk,
    input [1:0] sw,
    output [3:0] AN,
    output [7:0] dispcode,
    input Reset
	);
	//需要输出的数据
                  wire [31:0] curPC, result,nextPC;
                  wire [4:0] rs, rt;
                  wire[31:0] ReadData1,ReadData2,WriteData;
                  wire CLK;
                    //
              //一直输出Reset为1;
     wire [5:0] opCode;
	 wire [2:0] ALUOp;
	 wire [15:0] immediate;
	 wire [4:0]  rd,sa,WriteReg;
	 wire [25:0] addr;
	 wire zero, PCWre, ALUSrcA, ALUSrcB, DBDataSrc ,RegWre, InsMemRW, ExtSel,RegDst,mRD,mWR,sign;
	 wire [1:0] PCSrc;
	 wire[31:0] ALUin1,ALUin2,extend,ins,Dataout;
	 wire clk;
	 assign ALUin1 = (ALUSrcA==0)?ReadData1:sa;
	 assign ALUin2 = (ALUSrcB==0)?ReadData2:extend; 
	  clk_div cd(system_clk,CLK);
      key_process kp(CLK,key_in,clk);
	 // module ALU(ALUopcode,rega,regb,zero,sign ,result);
	 ALU alu(ALUOp,ALUin1,ALUin2,zero,sign ,result);
	 //module ROM ( rd, addr, dataOut);
     ROM rom(InsMemRW,curPC,ins);
	 /*module ID(InsMemRW,ins,  op, rs,  rt, rd, sa, immediate addr );*/
     ID id(InsMemRW,ins,opCode,rs,rt,rd,sa,immediate,addr);
    // module SignExtend(in , ExtSel,out)
    SignExtend signextend(immediate,ExtSel,extend);
	 // module PC(clk, Reset, PCWre, PCSrc, Jump, Addr, Address);
	 PC pc(clk, Reset, PCWre, PCSrc,extend,addr, curPC,nextPC);
	 // module controlUnit(opCode, zero, PCWre, ALUSrcA, ALUSrcB, DBDataSrc ,RegWre, InsMemRW, ExtSel, PCSrc, RegDst, ALUOp,mRD,mWR,sign);
	 ControlUnit control(opCode, zero, PCWre, ALUSrcA, ALUSrcB, DBDataSrc ,RegWre, InsMemRW, ExtSel, PCSrc, RegDst, ALUOp,mRD,mWR,sign);
	//module RAM( address,writeData, mRD, mWR, Dataout);
	 RAM ram(result,ReadData2,mRD,mWR,Dataout);
	 // module RegFile(CLK,RST,RegWre,ReadReg1,ReadReg2,WriteReg,WriteData,ReadData1,ReadData2);
	 assign WriteData = (DBDataSrc==0)?result:Dataout;
	 assign WriteReg = (RegDst==0)? rt:rd;
	 RegFile regfile(clk,Reset, RegWre,rs,rt,WriteReg,WriteData,ReadData1,ReadData2);
	 
         reg [15:0] display;
         always @(*)
         begin
            case(sw)
                2'b00:begin
                display[15:8] = curPC[7:0];
                display[7:0] = nextPC[7:0];
                end
                2'b01:begin
                display[12:8] = rs;
                display[15:13] = 3'b000;
                display[7:0] = ReadData1[7:0];
                end
                2'b10:begin
               display[12:8] = rt;
               display[15:13] = 3'b000;
               display[7:0] = ReadData2[7:0];
                end
                2'b11: begin
                display[15:8] = result[7:0];
                display[7:0] = WriteData[7:0];
                end
            endcase
         end
        
          wire [3:0]display_data;
         
          distribution d( CLK,display_data,display,AN);
          LED led(display_data,dispcode );
endmodule
