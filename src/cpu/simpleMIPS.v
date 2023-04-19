`include "defs.vh"
module simpleMIPS (
  input clk, rst
);

wire [31:0] pc_add4, instr;
wire Br, J;
wire [25:0] JImm = instr`SEG_ADDR;
fetch U_fetch(
  .rst(rst),
  .clk(clk),
  .Br(Br),
  .J(J),
  .Imm(JImm),
  .instr(instr),
  .pc_add4(pc_add4)
);

wire [31:0] ALUout, MEMout, imm32;
wire [1:0] WDSel, RDSel;
wire RegWr;
wire [31:0] rdata1, rdata2;
id U_id(
  .rst(rst),
  .clk(clk),
  .pc_add4(pc_add4),
  .instr(instr),
  .ALUout(ALUout),
  .MEMout(MEMout),
  .RegWr(RegWr),
  .WDSel(WDSel),
  .RDSel(RDSel),
  .rdata1(rdata1),
  .rdata2(rdata2),
  .imm32(imm32)
);

wire Breq, Brlt;
bru U_bru(
  .rdata1(rdata1),
  .rdata2(rdata2),
  .Breq(Breq),
  .Brlt(Brlt)
);

wire DMWr, BSel;
wire [1:0] ALUOp;
ctrl U_ctrl(
  .instr(instr),
  .Breq(Breq),
  .Brlt(Brlt),
  .RegWr(RegWr),
  .DMWr(DMWr),
  .Br(Br),
  .J(J),
  .BSel(BSel),
  .ALUOp(ALUOp),
  .WDSel(WDSel),
  .RDSel(RDSel)
);
  
ex U_ex(
  .ALUOp(ALUOp),
  .rdata1(rdata1),
  .rdata2(rdata2),
  .imm32(imm32),
  .BSel(BSel),
  .ALUout(ALUout)
);

dm U_dm(
  .clk(clk),
  .addr(ALUout),
  .wdata(rdata2),
  .DMWr(DMWr),
  .DMout(MEMout)
);

endmodule