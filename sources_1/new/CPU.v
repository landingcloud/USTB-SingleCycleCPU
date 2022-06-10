 `timescale 1ns / 1ps
 module CPU(
 input clk,rst,
 output [31:0] test_inst,
 output [31:0] t_file0,
 output [31:0] t_file1,
 output [31:0] t_file2
 );
 //ifu
 wire[31:0] inst;
 //Contol ģ������Ŀ����ź�
 wire ct_rf_dst,ct_rf_wen,ct_alu_src,ct_data_rf,ct_branch,ct_jump,ct_mem_wen,ct_mem_ren;
 wire ct_branchn;   //��չbne
 wire[3:0] ct_alu;
 //RegFile ģ����������
 wire[4:0] rf_addr_w;
 wire[31:0] rf_data_r1,rf_data_r2,rf_data_w;
 //ALU ģ����������
 wire alu_zero;
 wire[31:0] alu_src2;
 wire[31:0] alu_res;
 //������չ�Ľ��
 wire[31:0] ext_data;
 //DataMem �����
 wire[31:0] mem_data_o;
 //ѡ��Ҫд�ļĴ�����ַ
 assign rf_addr_w = ct_rf_dst?inst[15:11]:inst[20:16];
 //ѡ��Ҫд��Ĵ����ѵ�����
 assign rf_data_w = ct_data_rf?mem_data_o:alu_res;
 //alu_src2 ��ָ��� 16 λ������չ�Ľ�����߼Ĵ����Ѷ��ĵڶ��Ĵ�����ֵ
 assign ext_data = {{16{inst[15]}},inst[15:0]};
 assign alu_src2 = ct_alu_src?ext_data:rf_data_r2;//rt

 IFU ifu0(clk,rst,alu_zero,ct_branch,ct_branchn,ct_jump,inst);
 Control ct0(rst,inst[31:26],inst[5:0],ct_rf_dst,ct_rf_wen,ct_alu_src,ct_alu,ct_mem_wen,ct_mem_ren,ct_data_rf,ct_branch,ct_branchn,ct_jump);
 RegFile rf0(clk,ct_rf_wen,inst[25:21],inst[20:16],rf_addr_w,rf_data_w,rf_data_r1,rf_data_r2, t_file0, t_file1, t_file2);
 ALU alu0(rst,ct_alu,rf_data_r1,alu_src2,alu_zero,alu_res);
 DataMem datamem0(clk,ct_mem_wen,ct_mem_ren,alu_res,rf_data_r2,mem_data_o);
 
 //������
 assign test_inst = inst;
 endmodule
