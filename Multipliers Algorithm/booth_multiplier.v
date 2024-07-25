`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2024 20:06:59
// Design Name: 
// Module Name: booth_multiplier
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


module booth_multiplier(clk,reset,M,Q,prdt);
    input clk,reset;
    input  [7:0] M,Q;
    output reg  [15:0]prdt;
    
    reg Q0,start;
    reg [3:0]count;
    reg [7:0]accumulator;
    reg [16:0]AQ;
    
        
    reg [1:0]state,nextstate;
    
    localparam S0=2'd0;
    localparam S1=2'd1;
    localparam S2=2'd2;
    localparam S3=2'd3;
    
    always @(posedge clk or posedge reset)
    begin
        if(reset)
        begin
            state<=S0;
//            start<=1'b1;
        end
        
        else
        begin
            state<=nextstate;
        end
    end
    
    
    always @(*)
    case(state)
    
        S0:begin
                accumulator<=8'd0;
                count<=4'd0;
                Q0<=1'b0;
                AQ<={accumulator[7:0],Q[7:0],Q0};
                nextstate<=S1;
            end

        S1:begin
            if(AQ[1]==1'b1 && AQ[0]==1'b0)
            begin
                AQ[15:8]<=AQ[15:8]-M[7:0];
                nextstate<=S2;
            end
            
            else if(AQ[1]==1'b0 && AQ[0]==1'b1)
            begin
                AQ[15:8]<=AQ[15:8]+M[7:0];
                nextstate<=S2;
            end
            
            else if(AQ[1]==1'b0 && AQ[0]==1'b0)
                nextstate<=S2;
                
            else if(AQ[1]==1'b1 && AQ[0]==1'b1)
                nextstate<=S2;
            end
    
        S2:begin
//            start<=1'b0;
            AQ<={AQ[16],AQ[16:1]};
            count = count+1'b1;
            
            if(count < 4'd8)
                nextstate=S1;
                
            else if(count==4'd8)
                nextstate = S3;
        end
        
        S3: begin
            prdt<=AQ[16:1];
        end
        
    endcase
endmodule
