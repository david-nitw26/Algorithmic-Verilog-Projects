`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2024 17:05:40
// Design Name: 
// Module Name: RestoringDiv
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


module RestoringDiv(clk, reset, Q, M, Quotient, Remainder);
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

reg [2:0] state, nextState;

reg [8:0] A;
//reg [4:0] m, m_comp;
reg [2:0] count;

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
   // m_comp = {1'b1, -M};
    
    nextState = S1;
end

S1: begin
    A = {A[7:0], 1'b0};
    
    nextState = S2;
end


S2: begin
    A[8:4] = A[8:4] - M;
    
    if(A[8])
        nextState = S3;
    else if(!A[8])
        nextState = S4;
end

S3: begin
    A[8:4] = A[8:4] + M;
    
    nextState = S5;
end

S4: begin
    A[0] = 1'b1;
    
    nextState = S5;
end

S5: begin
    count = count + 1'b1;
    
    if(count == 3'd4)
        nextState = S6;
    
    else if(count < 3'd4)
        nextState = S1;
end

S6: begin
    Remainder = A[7:4];
    Quotient = A[3:0];
end
endcase

endmodule
