`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2024 11:12:49
// Design Name: 
// Module Name: Multiplier
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

module Multiplier(A, B, product);
input [31:0] A, B;
output reg [31:0] product;

reg signA, signB;
reg [7:0] expA, expB;
reg [22:0] mantA, mantB;
reg [47:0] mant_Acc;
reg [7:0] exp_Acc;
//wire [46:0] inter;

integer i = 45;

always @(*)
begin
    signA = A[31];
    signB = B[31];
    expA = A[30:23];
    expB = B[30:23];
    mantA = {1'b1,A[22:0]};
    mantB = {1'b1,B[22:0]};
   
   if(mantB == 23'd0)
   begin
        mant_Acc = 46'd0;
   end
   
   else begin
        if(mantA == 23'd0)
            mant_Acc = 46'd0;
           
        else begin
            exp_Acc = expA + expB - 8'd127;
            
             mant_Acc = mantA*mantB;
             
             if(mant_Acc[46] == 1'b1)begin
                product = {signA^signB, exp_Acc, mant_Acc[46:24]};
             end
             
             else if(!mant_Acc[46])begin
                mant_Acc = {1'b0, mant_Acc[47:0]};
                exp_Acc = exp_Acc + 1'b1;
                product = {signA^signB, exp_Acc, mant_Acc[46:24]};
             end
              
             
            end     
   end
   
end
endmodule
