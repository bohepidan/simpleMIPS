`timescale 1ns/1ps
module mips_tb();
  
  reg clk, rst;
  
  simpleMIPS U_simpleMIPS(
    .clk(clk), .rst(rst)
  );
  
  initial begin
    $readmemh( "code.hex" , U_simpleMIPS.U_fetch.IM.instr_mem ) ;
    $monitor("PC = 0x%8X, IR = 0x%8X", U_simpleMIPS.U_fetch.pc_w, U_simpleMIPS.instr); 
    clk = 1 ;
    rst = 0 ;
    #5 ;
    rst = 1 ;
    #20 ;
    rst = 0 ;
  end
  
  always
    #(50) clk = ~clk;
  
endmodule