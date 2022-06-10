`timescale 1ns/1ps
module RegFile(
    input clk,
    input rf_wen,
    //读地�?
    input[4:0] rf_addr_r1,
    input[4:0] rf_addr_r2,
    //写入地址和写入数�?
    input[4:0] rf_addr_w,
    input[31:0] rf_data_w,
    //输出
    output[31:0] rf_data_r1,
    output[31:0] rf_data_r2,
    output[31:0] t_file0,
    output[31:0] t_file1,
    output[31:0] t_file2
);
reg[31:0] file[31:0];   //寄存器堆

integer i;
initial begin
    for(i = 0; i < 32; i = i + 1) file[i] = 32'b0;
end

assign rf_data_r1 = file[rf_addr_r1];   //将文件对应的位置的地�?写入
assign rf_data_r2 = file[rf_addr_r2];

always@(negedge clk) begin
    if(rf_wen) begin
        file[rf_addr_w] = rf_data_w;
    end
end

assign t_file0 = file[0];
assign t_file1 = file[1];
assign t_file2 = file[2];

endmodule