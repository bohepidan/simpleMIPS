`include "defs.vh"
module reg_pc (
  input rst, clk, PCWr,
  input [31:2] npc,
  output [31:2] pc
);

reg [31:2] pc;
reg [1:0]  tmp;

always @(posedge clk or posedge rst) begin
  if(rst)
  begin
    {pc, tmp} <= `INSTR_START;
  end else if(PCWr) begin
    pc <= npc;
  end
end
  
endmodule