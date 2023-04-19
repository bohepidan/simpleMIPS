`include "defs.vh"
module reg_pc (
  input rst, clk, 
  input [31:2] npc,
  output reg [31:2] pc
);

reg [1:0]  tmp;

always @(posedge clk or posedge rst) begin
  if(rst)
  begin
    {pc, tmp} <= `INSTR_START;
  end else 
    pc <= npc;
end
  
endmodule