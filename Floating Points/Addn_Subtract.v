`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2024 00:20:21
// Design Name: 
// Module Name: Addn_Subtract
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

// errors found with subtraction: check it out

module Addn_Subtract(A, B, mode, result);       // mode 0 for add and 1 for subtract
input [31:0] A, B;
input mode;

output reg [31:0] result;

reg [23:0] mantA, mantB;
reg [24:0] mantAcc;
reg [7:0] expA, expB, expAcc;
reg signA, signB, signR;

always @(*) begin
    signA = A[31];
    signB = B[31];
    mantA = {1'b1, A[22:0]};
    mantB = {1'b1, B[22:0]};
    expA = A[30:23];
    expB = B[30:23];
    expAcc = expA;
    
    if(mantB == 23'd0) begin
        mantAcc = 25'd0; 
        result = 32'd0;
        end
        
    else begin
        if(mantA == 23'd0) begin
            if(!mode) 
                result = {signB, expB, mantB[22:0]};
             else if(mode)
                result = {~signB, expB, mantB[22:0]};
        end
        
        else begin
        // equalizing the exponents
            if(expA > expB) begin
                mantB = mantB >> (expA-expB);
                expB = expA;
                expAcc = expA;
            end
            
            else if(expB > expA) begin
                mantA = mantA >> (expB - expA);
                expA = expB;
                expAcc = expA;
            end
        // actual process starts 
            
            if((mode && ~(signA^signB)) || (!mode && (signA^signB))) begin
                mantAcc = mantA - mantB;
                
                if(mantAcc[24]) begin
                    if(mantAcc[23:0] == 24'd0)
                        result = 32'd0;
                    else begin
//                        while(mantAcc[23]!=1'b1) begin
//                            mantAcc = {mantAcc[23:0], 1'b0};
//                            expAcc = expAcc - 1'b1;
//                        end
                        
                        result = {signA, expAcc, mantAcc[22:0]};  
                    end 
                end
                
                else if(!mantAcc[24]) begin
                    mantAcc = ~mantAcc+1'b1;
//                    while(mantAcc[23]!=1'b1) begin
//                        mantAcc  = {mantAcc[23:0], 1'b0};
//                        expAcc = expAcc - 1'b1;
//                    end
                    
                    result = {~signA, expAcc, mantAcc[22:0]};  
                end
            end
            
            // now addition with same signs and subtraction with different signs
            
            else if((!mode && ~(signA^signB)) || (mode && signA^signB)) begin
                mantAcc = mantA + mantB;
                
                if(mantAcc[24]) begin
                    mantAcc = {1'b0, mantAcc[24:1]};
                    expAcc = expAcc + 1'b1;
                    result = {signA, expAcc, mantAcc[22:0]};
                end
                
                else if(!mantAcc[24]) begin
                    result = {signA, expAcc, mantAcc[22:0]};
                end  
            end                     
        end    
    end       
end
endmodule
