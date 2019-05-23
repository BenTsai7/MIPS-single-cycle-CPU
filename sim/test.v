`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/15 14:13:28
// Design Name: 
// Module Name: test
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

    
module test(
input [1:0] sw,
    output [3:0] AN,
    output [7:0] dispcode
    );
        reg clk;
       reg Reset;
       single_cycle_CPU cpu(.clk(clk),.system_clk(clk),.sw(sw),.AN(AN),.dispcode(dispcode));
       initial begin
               // Initialize Inputs
               clk = 0;
               Reset = 0;
               #50; // 刚开始设置pc为0
                   clk = !clk;
               #50;
                   Reset = 1;
             forever #50 begin // 产生时钟信号
                   clk = !clk;
               end
           end
endmodule
