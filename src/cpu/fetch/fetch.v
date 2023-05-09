`include "defs.vh"
module fetch (
  input rst, clk,
  input Br, J, 
  input [25:0] Imm,
  input [31:0] rdata1,  //for jalr, jr
  output [31:0] instr,
  output [31:0] pc_add4
);
wire [29:0] pc_w;
wire [31:0] pc_wm = {pc_w, 2'b00};
reg [29:0] npc;
assign pc_add4 = {pc_w + 1'b1, 2'b00};
wire [5:0] opcode = instr`SEG_OPCODE;
wire [5:0] funct  = instr`SEG_FUN;

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
    npc = pc_w + 1 + {{14{Imm[15]}}, Imm[15:0]};
  end else if(J)
  case(opcode)
  `OP_J, `OP_JAL: npc = {pc_w[29:26], Imm[25:0]};
  `OP_SPECIAL:
    case(funct)
    `FUN_JR, `FUN_JALR: npc = rdata1[31:2];
    default:  npc = pc_w+1;
    endcase 
  default:    npc = pc_w+1;
  endcase
  else
    npc = pc_w + 1;
end

  
endmodule