`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.11.2023 21:23:31
// Design Name: 
// Module Name: Booth_Multi_tb
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


module Booth_Multi_tb();
reg [7:0] x,y;
wire [15:0] out;

Booth_Multi uut(x,y,out);
initial begin
x = 10;   y = 2;   #100
x = -2;   y = 4;   #100
x = -156; y = 20;  #100
x = -200; y = -30; #100
x = 56;   y = -10; #100;
end
endmodule
