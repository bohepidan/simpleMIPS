`include "defs.vh"
//comb_module
module ctrl (
  input  [31:0] instr,
  input         Breq, Brlt, Breqz, Brltz,
  output reg    Br,
  output        RegWr, DMWr, J,
  output reg [1:0]  WDSel, RDSel
);

wire[5:0]  opcode =  instr`SEG_OPCODE;
wire[5:0]  funct  =  instr`SEG_FUN;
wire[4:0]  rt     =  instr`SEG_RT;

wire Rtype = opcode == `OP_SPECIAL;
wire Itype = (opcode == `OP_ADDI || opcode == `OP_ADDIU || opcode == `OP_ANDI ||
              opcode == `OP_ORI  || opcode == `OP_XORI  || opcode == `OP_LUI  ||
              opcode == `OP_SLTI || opcode == `OP_SLTIU);
wire Btype = (opcode == `OP_BEQ  || opcode == `OP_BNE   || opcode == `OP_BGTZ ||
              opcode == `OP_BLEZ || opcode == `OP_BGEZ_OR_BLTZ);
wire Stype = (opcode == `OP_SW   || opcode == `OP_SB    || opcode == `OP_SH);
wire Ltype = (opcode == `OP_LW   || opcode == `OP_LB    || opcode == `OP_LH   ||
              opcode == `OP_LBU  || opcode == `OP_LHU);
wire Jtype = (opcode == `OP_JAL  || opcode == `OP_J);

assign RegWr = (Rtype && (funct != `FUN_JR)) || Itype || Ltype || opcode == `OP_JAL;
assign DMWr = Stype;

always @(*) begin
  if(Btype) begin
    case(opcode) 
    `OP_BEQ:     Br = Breq;
    `OP_BNE:     Br = ~Breq;
    `OP_BGTZ:    Br = ~(Brltz | Breqz);
    `OP_BLEZ:    Br = Breqz | Brltz;
    `OP_BGEZ_OR_BLTZ: begin
      case(rt)
      `RT_BGEZ:  Br = ~Brltz;
      `RT_BLTZ:  Br = Brltz;
      default:   Br = 1'b0;
      endcase
    end
    default: Br = 1'b0;
    endcase
  end else
    Br = 1'b0;
end

assign J = Jtype || (Rtype && funct == `FUN_JALR) || (Rtype && funct == `FUN_JR);


always @(*) begin
  if((Rtype && funct != `FUN_JALR && funct != `FUN_JR)|| Itype)
    WDSel = `WD_fromALU;
  else if(Ltype)
    WDSel = `WD_fromMEM;
  else if(opcode == `OP_JAL || (opcode == `OP_SPECIAL && funct == `FUN_JALR))
    WDSel = `WD_fromPC;
  else 
    WDSel = `WD_fromALU;
end

always @(*) begin
  if(Rtype)
    RDSel = `RD_fromRD;
  else if(Itype || Ltype)
    RDSel = `RD_fromRT;
  else if(opcode == `OP_JAL || (opcode == `OP_SPECIAL && funct == `FUN_JALR))
    RDSel = `RD_RA;
  else 
    RDSel = `RD_fromRD;
end

endmodule