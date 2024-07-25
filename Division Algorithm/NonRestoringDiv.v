`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2024 20:27:59
// Design Name: 
// Module Name: NonRestoringDiv
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


module NonRestoringDiv(clk, reset, Q, M, Quotient, Remainder);
input clk, reset;
input [3:0] Q, M;
output reg [3:0] Quotient, Remainder;

localparam S0 = 3'd0;
localparam S1 = 3'd1;
localparam S2 = 3'd2;
localparam S3 = 3'd3;
localparam S4 = 3'd4;
localparam S5 = 3'd5;
localparam S6 = 3'd6;
localparam S7 = 3'd7;

reg [8:0] A;
reg [2:0] count;

reg [2:0] state, nextState;

always @(posedge clk or posedge reset)
begin
    if(reset)
        state <= S0;
    else
        state <= nextState;
end

always @(*)
case(state)
S0: begin
    A = {5'd0, Q};
    count = 3'd0;
    
    nextState = S1;
end

S1: begin
    A = A << 1;
    
    if(A[8])
        nextState = S2;
    else if(!A[8])
        nextState = S3;
end

S2: begin
    A[8:4] = A[8:4] + M;
    
    if(A[8])
        nextState = S4; 
    else if(!A[8])
        nextState = S5;
end

S3: begin
    A[8:4] = A[8:4] - M;
    
    if(A[8])
        nextState = S4;
    else if(!A[8])
        nextState = S5;
end

S4: begin
    A[0] = 1'b0;
    
    nextState = S6;
end

S5: begin
    A[0] = 1'b1;
    
    nextState = S6;
end

S6: begin
    count = count + 1'b1;
    
    if(count == 3'd4)
        nextState = S7;
    else if(count < 3'd4)
        nextState = S1;
end

S7: begin
    if(!A[8])
    begin
        Remainder = A[7:4];
        Quotient =  A[3:0];
    end
    
    else if(A[8])
    begin
        A[8:4] = A[8:4] + M;
        
        Remainder = A[7:4];
        Quotient =  A[3:0];   
    end   
end
endcase

endmodule
