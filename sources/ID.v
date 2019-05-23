`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/10 10:24:31
// Design Name: 
// Module Name: ID
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


module ID(
    input InsMemRW, //��дID���ź�,0Ϊ��
    input [31:0] ins,// ָ��
    output [5:0] op,
   output [4:0] rs,
   output [4:0] rt,
   output [4:0] rd,
   output [4:0] sa,
   output [15:0] immediate, //������
   output [25:0] addr //J��ָ����תλ��
    );
assign op = ins[31:26];
assign rs = ins[25:21];
assign rt = ins[20:16];
assign rd = ins[15:11];
assign sa = ins[10:6];
assign immediate = ins[15:0];
assign addr = ins[25:0];
endmodule
