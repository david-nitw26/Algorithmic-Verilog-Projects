`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2024 13:30:25
// Design Name: 
// Module Name: Division
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


module Division(A, B, result);          // performing A/B
input [31:0] A, B;
output reg [31:0] result;

reg signA, signB;
reg [7:0] expA, expB;
reg [23:0] mantA, mantB;

reg [7:0] exp_Acc;
reg [23:0] mant_Acc;

integer i;

always @(*) begin
    signA = A[31];
    signB = B[31];
    mantA = {1'b1, A[22:0]};
    mantB = {1'b1, B[22:0]};
    mant_Acc = {25'd0, mantA};
    expA = A[30:23];
    expB = B[30:23];
   
    if(mantA == 24'd0)
        result = 32'd0;
    else begin
        if(mantB == 24'd0)
            result = 32'd0;
        else begin
        
            mant_Acc = 23'd0;
            exp_Acc = expA - expB + 8'd127;
             for  (i = 0; i < 24; i = i + 1) begin
                mant_Acc = mant_Acc << 1;
                if (mantA >= mantB) begin
                    mant_Acc[0] = 1;
                    mantA = mantA - mantB;
                end
                mantB = mantB >> 1; // Shift the divisor for the next iteration
               end
           
           while(mant_Acc[23]!=1'b1)begin
                mant_Acc = {mant_Acc[22:0], 1'b1};
                exp_Acc = exp_Acc - 1'b1;
           end
           
           result = {signA^signB, exp_Acc, mant_Acc[22:0]};
           
        end
       
    end
   
end
endmodule