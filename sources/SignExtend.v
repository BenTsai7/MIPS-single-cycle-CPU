`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/10 10:12:27
// Design Name: 
// Module Name: SignExtend
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


module SignExtend(in , ExtSel,out
    );
    input [15:0] in;
    output [31:0] out;
    input ExtSel;
    assign out[15:0] = in;
    assign out[31:16] = ExtSel? (in[15]? 16'hffff : 16'h0000) : 16'h0000; //in[15] 决定正负数
endmodule
