`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2024 19:29:09
// Design Name: 
// Module Name: Array_Mult
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

module full_adder (a, b, cin, sum, cout);
input a, b, cin;
output sum, cout;

assign sum = a^b^cin;
assign cout = ((a^b)&cin)|(a&b);
endmodule

module fullAdd_4bit (A, B, cin, sum, cout);
input [3:0] A, B;
input cin;
output [3:0] sum;
output cout;

wire [2:0] cout_1;

full_adder f1 (A[0], B[0], 1'b0, sum[0], cout_1[0]);
full_adder f2 (A[1], B[1], cout_1[0], sum[1], cout_1[1]);
full_adder f3 (A[2], B[2], cout_1[1], sum[2], cout_1[2]);
full_adder f4 (A[3], B[3], cout_1[2], sum[3], cout);

endmodule


module compute_and (ip_1, ip_2, op);
input [3:0] ip_1;
input ip_2;
output [3:0] op;


assign op[0] = ip_1[0]&ip_2;
assign op[1] = ip_1[1]&ip_2;
assign op[2] = ip_1[2]&ip_2;
assign op[3] = ip_1[3]&ip_2;

endmodule


module Array_Mult(A, B, product);
input [3:0] A, B;
output [7:0] product;

wire [3:0] sum_1, sum_2, sum_3, sum_4;
wire [2:0] cout_1;

wire [3:0] partial_1, partial_2, partial_3;
//assign product[0] = A[0]&B[0];

compute_and c1 (A, B[0], sum_1);
compute_and c2 (A, B[1], sum_2);
compute_and c3 (A, B[2], sum_3);
compute_and c4 (A, B[3], sum_4);

assign product[0] = sum_1[0];

fullAdd_4bit f1({1'b0, sum_1[3:1]}, sum_2, 1'b0, partial_1, cout_1[0]);
assign product[1] = partial_1[0];

fullAdd_4bit f2({cout_1[0], partial_1[3:1]}, sum_3, 1'b0, partial_2, cout_1[1]);
assign product[2] = partial_2[0];

fullAdd_4bit f3 ({cout_1[1], partial_2[3:1]}, sum_4, 1'b0, partial_3, cout_1[2]);
assign product[7:3] = {cout_1[2], partial_3};

endmodule
