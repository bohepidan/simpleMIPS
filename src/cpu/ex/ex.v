`include "defs.vh"
module ex (
  input [31:0] instr,
  input [31:0] rdata1, rdata2,
  output reg [2:0] mem_sel,
  output reg [31:0] result,
  output [31:0] mem_addr, mem_wdata
);
wire[5:0] opcode  = instr`SEG_OPCODE;
wire[5:0] funct   = instr`SEG_FUN;
wire[4:0] shamt   = instr`SEG_SHAMT;
wire[15:0] offset = instr`SEG_OFFSET;

wire [31:0] imm32 =  {{16{instr[15]}}, instr[15:0]};
wire [31:0] imm32u = {16'b0, instr[15:0]};

wire Itype = (opcode == `OP_ADDI || opcode == `OP_ADDIU || opcode == `OP_ANDI ||
              opcode == `OP_ORI  || opcode == `OP_XORI  || opcode == `OP_LUI  ||
              opcode == `OP_SLTI || opcode == `OP_SLTIU);
wire Btype = (opcode == `OP_BEQ  || opcode == `OP_BNE   || opcode == `OP_BGTZ ||
              opcode == `OP_BLEZ || opcode == `OP_BGEZ_OR_BLTZ);
wire Stype = (opcode == `OP_SW   || opcode == `OP_SB    || opcode == `OP_SH);
wire Ltype = (opcode == `OP_LW   || opcode == `OP_LB    || opcode == `OP_LH   ||
              opcode == `OP_LBU  || opcode == `OP_LHU);
wire Jtype = (opcode == `OP_JAL  || opcode == `OP_J);

assign mem_addr = rdata1 + $signed(offset);
assign mem_wdata = rdata2;
// mem_wdata, mem_sel
always @(*) begin
  case(opcode) 
  `OP_LB, `OP_SB:   mem_sel = `MEM_B;
  `OP_LBU:          mem_sel = `MEM_BU;
  `OP_LH, `OP_SH:   mem_sel = `MEM_H;
  `OP_LHU:          mem_sel = `MEM_HU;
  `OP_LW, `OP_SW:   mem_sel = `MEM_W;
  default:          mem_sel = `NOT_MEM;
  endcase
end

assign bsel = Itype || Stype || Ltype;

wire [31:0] op1, op2;
assign op1 = rdata1;
assign op2 = bsel ? imm32 : rdata2;

wire [31:0] subu = op1 - op2;
// result
always @(*) begin
  case(opcode)
  `OP_SPECIAL:
    case(funct)
    `FUN_ADD, `FUN_ADDU: result = op1 + op2;
    `FUN_SUB, `FUN_SUBU: result = op1 - op2;
    `FUN_AND:   result = op1 & op2;
    `FUN_NOR:   result = ~(op1 | op2);
    `FUN_OR:    result = op1 | op2;
    `FUN_XOR:   result = op1 ^ op2;

    `FUN_SLT:   result = (op1[31] != op2[31]) ? op1[31] : subu[31];
    `FUN_SLTU:  result = op1 < op2;
    `FUN_SLL:   result = op2 << shamt;
    `FUN_SRL:   result = op2 >> shamt;
    `FUN_SRA:   result = $signed(op2) >>> shamt;
    `FUN_SLLV:  result = op2 << op1[4:0];
    `FUN_SRLV:  result = op2 >> op1[4:0];
    `FUN_SRAV:  result = $signed(op2) >>> op1[4:0];

    `FUN_JR, `FUN_JALR:  result = op1;
    default:    result = `ZERO_WORD;
    endcase
  `OP_ADDI, `OP_ADDIU:   result = op1 + imm32;
  `OP_ANDI:   result = op1 & imm32u;
  `OP_ORI:    result = op1 | imm32u;
  `OP_XORI:   result = op1 ^ imm32u;
  `OP_LUI:    result = {instr`SEG_IMM, 16'b0};
  `OP_SLTI:   result = (op1 < imm32) ? 32'h0000_0001 : 32'b0;
  `OP_SLTIU:  result = (op1 < imm32u) ? 32'h0000_0001 : 32'b0;
  default:    result = `ZERO_WORD;
  endcase
end
  
endmodule