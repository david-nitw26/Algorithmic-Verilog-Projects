`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.02.2024 17:47:39
// Design Name: 
// Module Name: ShiftAdd
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


module ShiftAdd(clk, reset, A, B, product);
input clk, reset;
input [3:0] A, B;
output reg [7:0] product;

reg [8:0] Acc;
reg [2:0] count;


always @(posedge clk or posedge reset)
begin
    if(reset)
        count = 3'd0;
    else if(count < 3'd5)
        count = count + 1'b1;
end

always @(posedge clk or posedge reset)
begin
    if(reset)
        Acc = {5'd0, B};
    else if(Acc[0] && count!=3'd5)
    begin
        Acc[8:4] = Acc[8:4]+A;
        Acc = {1'b0, Acc[8:1]};
    end
    
    else if(!Acc[0] && count!=3'd5)
        Acc = {1'b0, Acc[8:1]};
    
end

always @(posedge clk or posedge reset)
begin
    if(reset)
        product = 8'd0;
    else if(count == 3'd5)
        product = Acc[7:0];
end

endmodule
