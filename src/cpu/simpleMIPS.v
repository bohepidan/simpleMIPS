`include "defs.vh"
module simpleMIPS (
  input clk, rst
);

wire [31:0] pc_add4, instr;
wire Br, J;
wire [25:0] JImm = instr`SEG_ADDR;
wire [31:0] rdata1, rdata2;
fetch U_fetch(
  .rst(rst),
  .clk(clk),
  .Br(Br),
  .J(J),
  .Imm(JImm),
  .instr(instr),
  .rdata1(rdata1),
  .pc_add4(pc_add4)
);

wire [31:0] ALUout, MEMout;
wire [1:0] WDSel, RDSel;
wire RegWr;
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
  .rdata2(rdata2)
);

wire Breq, Brlt, Breqz, Brltz;
bru U_bru(
  .rdata1(rdata1),
  .rdata2(rdata2),
  .Breq(Breq),
  .Brlt(Brlt),
  .Breqz(Breqz),
  .Brltz(Brltz)
);

wire DMWr;
ctrl U_ctrl(
  .instr(instr),
  .Breq(Breq),
  .Brlt(Brlt),
  .Breqz(Breqz),
  .Brltz(Brltz),
  .RegWr(RegWr),
  .DMWr(DMWr),
  .Br(Br),
  .J(J),
  .WDSel(WDSel),
  .RDSel(RDSel)
);
  
wire [2:0] mem_sel;
wire [31:0] mem_addr, mem_wdata;
ex U_ex(
  .instr(instr),
  .rdata1(rdata1),
  .rdata2(rdata2),
  .result(ALUout),
  .mem_sel(mem_sel),
  .mem_addr(mem_addr),
  .mem_wdata(mem_wdata)
);

dm U_dm(
  .clk(clk),
  .addr(mem_addr),
  .wdata(mem_wdata),
  .mem_sel(mem_sel),
  .DMWr(DMWr),
  .rdata(MEMout)
);

endmodule