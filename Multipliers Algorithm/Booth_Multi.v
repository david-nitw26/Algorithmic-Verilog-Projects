`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.11.2023 21:10:16
// Design Name: 
// Module Name: Booth_Multi
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


module Booth_Multi(x, y, out);
    input signed [7:0]x;   //multiplier
    input signed [7:0]y;   //multiplicand
    output reg signed [15:0]out;
    
	 reg [7:0] s,p;
	 reg [16:0] a;
	 integer i;
	 
	 always @ (x or y)
	 begin
	 a=17'd0;
	 s=y;      //y is the multiplicand
	 a[8:1]=x; //x is the multiplier
	 
	 begin : loop
	 for(i=0;i<=7;i=i+1)
	 begin
	   if(a[1]==1'b1&&a[0]==1'b0)
	   begin
	   p=a[16:9];
	   a[16:9]=p-s;    //s is the multiplicand
	   end
	   
	   else if (a[1]==1'b0&&a[0]==1'b1)
	   begin
	   p=a[16:9];
	   a[16:9]=p+s;
	   end
	   
	   a[15:0]=a[16:1];
	 end
	 
	 out[15:0]<=a[16:1];
	 end
	 end

endmodule

