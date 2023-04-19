`include "defs.vh"
module fetch (
  input rst, clk,
  input Br, J, PCWr,
  input [25:0] Imm,
  output [31:0] instr,
  output [31:0] pc_add4
);

wire [31:2] pc_w;
reg [31:2] npc;
assign pc_add4 = {pc_w + 1'b1, 2'b00};

reg_pc PC(
  .rst(rst),
  .clk(clk),
  .PCWr(PCWr),
  .npc(npc),
  .pc(pc_w)
);

im IM(
  .addr({pc_w, 2'b00}),
  .data(instr)
);

always @(*) begin
  if (Br) begin
    npc = pc_w + {{14{Imm[15]}}, Imm[15:0]};
  end else if(J)
  begin
    npc = {pc_w[31:28], Imm[25:0]};
  end else
    npc = pc_w + 1;
end

  
endmodule