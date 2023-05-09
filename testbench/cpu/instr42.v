module instr42();

reg clk, rst;

simpleMIPS U_simpleMIPS(
  .clk(clk), .rst(rst)
);

integer i;
initial begin
  $readmemh("../../testbench/cpu/mem/instr42.mem" , U_simpleMIPS.U_fetch.U_IM.instr_mem);
  $monitor("PC = 0x%8X, IR = 0x%8X, npc = 0x%8X, regwr=", U_simpleMIPS.U_fetch.pc_wm, U_simpleMIPS.U_fetch.instr, U_simpleMIPS.U_fetch.npc,
      U_simpleMIPS.RegWr); 
  clk = 1 ;
  rst = 0 ;
  #5 ;
  rst = 1 ;
  #20 ;
  rst = 0 ;
  for(i=0; i<800; i = i+1)
    #(50) clk = ~clk;

  $finish;
end

    
  

endmodule