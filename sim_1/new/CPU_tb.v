`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/10 15:37:22
// Design Name: 
// Module Name: CPU_tb
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

module CPU_tb;
    reg clk=0;
    reg rst=1;
    wire [31:0] test_inst;
    wire [31:0] t_file0;
    wire [31:0] t_file1;
    wire [31:0] t_file2;
    CPU test(clk, rst, test_inst, t_file0, t_file1, t_file2);
    
    initial begin
        forever #10 clk=~clk;
    end
    initial begin
        #25 rst = 1;
        #10 rst = 0;
        #30 rst = 1;
     end

endmodule
