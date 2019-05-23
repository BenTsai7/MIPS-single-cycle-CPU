`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 20:34:02
// Design Name: 
// Module Name: clk_div
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


module clk_div(input clk,output reg new_clk
    );
    reg [31:0] count;
    initial count=0;
    always @(posedge clk)
    begin
        if (count==99999)
        begin
        count = 0;
        new_clk = ~new_clk;
        end
        else
        count = count + 1;
    end
endmodule
