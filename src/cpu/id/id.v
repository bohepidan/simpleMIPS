`include "defs.vh"
module id (
  input clk, rst, 
  input [31:0] pc_add4,
  input [31:0] instr, ALUout, MEMout,
  input RegWr,
  input [1:0] WDSel, RDSel,
  output [31:0] rdata1, rdata2, imm32
);

wire[4:0] rs =    instr`SEG_RS;
wire[4:0] rt =    instr`SEG_RT;
wire[4:0] rd =    instr`SEG_RD;
wire[15:0] imm =  instr`SEG_IMM;

reg [4:0]  rf_rd;
reg [31:0] rf_wd;

always @(*) begin
  case(WDSel)
    `WD_fromALU:
      rf_wd = ALUout;
    `WD_fromMEM:
      rf_wd = MEMout;
    `WD_fromPC:
      rf_wd = pc_add4;
  endcase
end

always @(*) begin
  case(RDSel)
    `RD_fromRD:
      rf_rd = rd;
    `RD_fromRT:
      rf_rd = rt;
    `RD_RA:
      rf_rd = 5'd31;
  endcase
end

regfile rf(
  .clk(clk),
  .rst,
  .RegWr(RegWr),
  .rs1(rs),
  .rs2(rt),
  .rd(rf_rd),
  .wdata(rf_wd),
  .rdata1(rdata1),
  .rdata2(rdata2)
);

assign imm32 = {{14{imm[15]}}, imm[15:0]};

endmodule