`include "defs.vh"
//comb_module
module ctrl (
  input  [31:0] instr,
  input         Breq, Brlt,
  output        RegWr, DMWr, PCWr, Br, J, BSel,
  output [1:0]  ALUOp, WDSel, RDSel
);

wire[5:0]  opcode =  instr`SEG_OPCODE;
wire[5:0]  funct =   instr`SEG_FUNCT;

wire Rtype = (opcode == `OP_R);
wire Itype = (opcode == `OP_ORI);
wire Btype = (opcode == `OP_BEQ);
wire Stype = (opcode == `OP_SW || opcode == `OP_LW);
wire Jtype = (opcode == `OP_JAL);

assign RegWr = Rtype || Itype || opcode == `OP_LW || opcode == `OP_JAL;
assign DMWr = opcode == `OP_SW;

reg Br;
always @(*) begin
  if(Btype) begin
    case(opcode) 
      `OP_BEQ: begin
        if(Breq)
          Br = 1'b1;
        else 
          Br = 1'b0;
      end
      default:
        Br = 1'b0;
    endcase
  end else
    Br = 1'b0;
end

assign PCWr = 1;

assign J = opcode == `OP_JAL;

assign BSel = Itype || Stype;

reg [1:0] ALUOp;
always @(*) begin
  if(Rtype) begin
    case(funct) 
      `FUNCT_ADDU:
        ALUOp = `ALU_ADDU;
      `FUNCT_SUBU:
        ALUOp = `ALU_SUBU;
      default:
        ALUOp = `ALU_ADD;
    endcase
  end else if(Itype)begin
    case(opcode)
      `OP_ORI:
        ALUOp = `ALU_OR;
      default:
        ALUOp = `ALU_ADD;
    endcase
  end else if(Stype) begin
    ALUOp = `ALU_ADD;
  end else
    ALUOp = `ALU_ADD;
end

reg[1:0] WDSel;
always @(*) begin
  if(Rtype || Itype)
    WDSel = `WD_fromALU;
  else if(opcode == `OP_LW)
    WDSel = `WD_fromMEM;
  else if(opcode == `OP_JAL)
    WDSel = `WD_fromPC;
  else 
    WDSel = `WD_fromALU;
end

reg[1:0] RDSel;
always @(*) begin
  if(Rtype)
    RDSel = `RD_fromRD;
  else if(Itype || opcode == `OP_LW)
    RDSel = `RD_fromRT;
  else if(opcode == `OP_JAL)
    RDSel = `RD_RA;
  else 
    RDSel = `RD_fromRD;
end

endmodule