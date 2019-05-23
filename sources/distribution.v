`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/15 09:40:31
// Design Name: 
// Module Name: distribution
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

module distribution(
    input CLK,
    output reg [3:0]  displaydata,
    input [15:0]  display,
    output reg[3:0] AN
    );
    reg [1:0] count;
    always @(posedge CLK)
    begin
    if (count==3) count = 0;
    else count = count + 1;
    case (count)
        0:begin
        displaydata = display[15:12];
        AN = 4'b0111;
        end
        1:begin
        displaydata = display[11:8];
        AN = 4'b1011;
        end
        2:begin
        displaydata = display[7:4];
        AN = 4'b1101;
        end
        3:begin
        displaydata = display[3:0];
        AN = 4'b1110;
        end        
    endcase
    end
endmodule
