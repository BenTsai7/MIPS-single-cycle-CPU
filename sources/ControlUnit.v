`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/10 10:40:32
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
    opCode, zero, PCWre, ALUSrcA, ALUSrcB, DBDataSrc ,RegWre, InsMemRW, ExtSel, PCSrc, RegDst, ALUOp,mRD,mWR,sign
    );
    input sign;
    input [5:0] opCode;
    input zero;
    output PCWre, ALUSrcA, ALUSrcB, RegWre, InsMemRW, mRD,mWR, ExtSel, RegDst, DBDataSrc;
    output reg[1:0] PCSrc;
    output[2:0] ALUOp;
    assign PCWre = (opCode == 6'b111111)? 0 : 1;	//Í£»ú
    assign ALUSrcA = (opCode == 6'b011000)? 1 : 0; 
    assign ALUSrcB = (opCode == 6'b000010 || opCode == 6'b010000 || opCode == 6'b010010 || opCode == 6'b011100|| opCode == 6'b100110|| opCode == 6'b100111)? 1 : 0;
    assign DBDataSrc = (opCode == 6'b100111)? 1 : 0;
    assign RegWre = (opCode == 6'b000000 || opCode == 6'b000010 || opCode == 6'b000001 || opCode == 6'b010010|| opCode == 6'b010011|| opCode == 6'b010001 ||opCode == 6'b010000 |opCode == 6'b011100 |opCode == 6'b011000 |opCode == 6'b100111)? 1 : 0;
    assign RegDst = (opCode == 6'b000000 || opCode == 6'b000001 || opCode == 6'b010001 || opCode == 6'b010011|| opCode == 6'b011000)? 1 : 0;
    assign InsMemRW = 1;
    assign mRD = (opCode==6'b100111)? 1 : 0;
    assign mWR = (opCode==6'b100110)? 1 : 0; 
    assign ExtSel = (opCode == 6'b010000 || opCode == 6'b010010 || opCode==6'b011000 )? 0 : 1;
    assign ALUOp[0] = (opCode == 6'b000001 || opCode == 6'b010011 || opCode == 6'b010010 || opCode == 6'b110000 || opCode == 6'b110001) ? 1 : 0;
    assign ALUOp[1] = (opCode == 6'b010011 || opCode == 6'b010010 || opCode == 6'b011000 || opCode == 6'b011100 ||opCode == 6'b110010) ? 1 : 0;
    assign ALUOp[2] = (opCode == 6'b010000 || opCode == 6'b010001 || opCode == 6'b011100 ||opCode == 6'b110010) ? 1 : 0;
    always @(opCode,zero,sign) begin
    case (opCode)
    6'b110000 :
    begin
     if (zero==1)PCSrc = 2'b01;
     else PCSrc = 2'b00;
     end
    6'b110001 : 
    begin
    if (zero==0)PCSrc = 2'b01;
    else PCSrc =  2'b00;
    end
    6'b110010 : 
    begin
    if (zero==0) PCSrc = 2'b01;
    else PCSrc = 2'b00;
    end
    6'b111000 : PCSrc = 2'b10;
    default :  PCSrc = 2'b00;
    endcase
    end
endmodule