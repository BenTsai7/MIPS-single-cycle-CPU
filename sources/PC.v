`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/10 09:56:13
// Design Name: 
// Module Name: PC
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

module PC(
    input CLK,                         // ʱ��
    input Reset,                      // �����ź�
    input PCWre,                       // PC�����źţ����Ϊ0��PC������
    input [1:0] PCSrc,               //��ת�ź�
    input [31:0] Jump,         // ��ת��ƫ����
    input [25:0] addr,
    output reg[31:0] Address,    // ��ǰָ��λ��
    output reg[31:0] nextAddress
    );
     reg first;
    initial begin
        Address <= 0; 
        nextAddress <= 0;
        first<=0;
    end
    always@(posedge CLK)
    begin
    if (first==0) first=1;
    else
     begin
        //if (nextAddress == 0)  Address <= 0; // ������ã���ֵΪ0
        //else 
        if (PCWre)
            begin
           Address = nextAddress;
            end
     end
     if (Reset==0) first=0;
     end
     always@ (*)
     begin
     if (PCWre)
          begin
                 case (PCSrc)
                 2'b00 : nextAddress = Address + 4;
                 2'b01 : nextAddress = Address + 4 + Jump * 4;
                 2'b10 : begin
                nextAddress[31:28] = Address[31:28];
                 nextAddress[27:2] = addr[25:0];
                 nextAddress[1:0] = 2'b00;
                 end
                 endcase
           end
       else nextAddress = Address;
       if (Reset==0) begin nextAddress=0;end
    end
endmodule
