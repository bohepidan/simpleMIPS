`ifndef DEFS_VH
`define DEFS_VH

  `define DEBUG

`define INSTR_START 32'h0000_3000

`define SEG_OPCODE [31:26]
`define SEG_RS     [25:21]
`define SEG_RT     [20:16]
`define SEG_RD     [15:11]
`define SEG_SHAMT  [10:6]
`define SEG_FUN    [5:0]
`define SEG_IMM    [15:0]
`define SEG_OFFSET [15:0]
`define SEG_ADDR   [25:0]

`define ZERO_WORD  32'h0000_0000
`define ERR_WORD   32'hxxxx_xxxx

// OPCODE
`define OP_SPECIAL      6'b000000

`define OP_LB         6'b100000
`define OP_LH         6'b100001
`define OP_LBU        6'b100100
`define OP_LHU        6'b100101
`define OP_LW         6'b100011

`define OP_SB         6'b101000
`define OP_SH         6'b101001
`define OP_SW         6'b101011

`define OP_ADDI       6'b001000
`define OP_ADDIU      6'b001001
`define OP_ANDI       6'b001100
`define OP_ORI        6'b001101 
`define OP_XORI       6'b001110
`define OP_LUI        6'b001111
`define OP_SLTI       6'b001010
`define OP_SLTIU      6'b001011

`define OP_BEQ        6'b000100
`define OP_BNE        6'b000101
`define OP_BGTZ       6'b000111
`define OP_BLEZ       6'b000110
`define OP_BGEZ_OR_BLTZ       6'b000001

`define RT_BGEZ       5'b00001
`define RT_BLTZ       5'b00000

`define OP_J          6'b000010
`define OP_JAL        6'b000011

// Funct
`define FUN_ADD     6'b100000
`define FUN_ADDU    6'b100001
`define FUN_SUB     6'b100010
`define FUN_SUBU    6'b100011
`define FUN_AND     6'b100100
`define FUN_NOR     6'b100111
`define FUN_OR      6'b100101
`define FUN_XOR     6'b100110

`define FUN_SLT     6'b101010
`define FUN_SLTU    6'b101011

`define FUN_SLL     6'b000000
`define FUN_SRL     6'b000010
`define FUN_SRA     6'b000011
`define FUN_SLLV    6'b000100
`define FUN_SRLV    6'b000110
`define FUN_SRAV    6'b000111      

`define FUN_JR      6'b001000
`define FUN_JALR    6'b001001  

// rf WD sel
`define WD_fromALU 2'b00
`define WD_fromMEM 2'b01
`define WD_fromPC  2'b10 

// rf Rd sel
`define RD_fromRD   2'b00
`define RD_fromRT   2'b01
`define RD_RA       2'b10 //Jal

// dmem sel
`define MEM_B   3'b000
`define MEM_BU  3'b001
`define MEM_H   3'b010
`define MEM_HU  3'b011
`define MEM_W   3'b100
`define NOT_MEM 3'b101

`endif