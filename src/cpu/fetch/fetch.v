`include "defs.vh"
module fetch (
  input rst, clk,
  input Br, J, 
  input [25:0] Imm,
  output [31:0] instr,
  output [31:0] pc_add4
);

wire [29:0] pc_w;
reg [29:0] npc;
assign pc_add4 = {pc_w + 1'b1, 2'b00};

reg_pc PC(
  .rst(rst),
  .clk(clk),
  .npc(npc),
  .pc(pc_w)
);

im U_IM(
  .addr(pc_w[9:0]),
  .data(instr)
);

always @(*) begin
  if (Br) begin
    npc = pc_w + {{14{Imm[15]}}, Imm[15:0]};
  end else if(J)
  begin
    npc = {pc_w[29:26], Imm[25:0]};
  end else
    npc = pc_w + 1;
end

  
endmodule