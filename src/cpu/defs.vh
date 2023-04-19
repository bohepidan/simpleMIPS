`ifndef DEFS_VH
`define DEFS_VH

  `define DEBUG

`define INSTR_START 32'h0000_3000

`define SEG_OPCODE [31:26]
`define SEG_RS     [25:21]
`define SEG_RT     [20:16]
`define SEG_RD     [15:11]
`define SEG_SHAMT  [10:6]
`define SEG_FUNCT  [5:0]
`define SEG_IMM    [15:0]
`define SEG_ADDR   [25:0]

`define OP_R          6'b000000
`define OP_LW         6'b100011
`define OP_SW         6'b101011
`define OP_ORI        6'b001101  
`define OP_BEQ        6'b000100
`define OP_JAL        6'b000011

// Funct
`define FUNCT_ADDU    6'b100001
`define FUNCT_SUBU    6'b100011

// ALU OP
`define ALU_ADDU  2'b00
`define ALU_SUBU  2'b01
`define ALU_OR    2'b10
`define ALU_ADD     2'b11

// rf WD sel
`define WD_fromALU 2'b00
`define WD_fromMEM 2'b01
`define WD_fromPC  2'b10 

// rf Rd sel
`define RD_fromRD   2'b00
`define RD_fromRT   2'b01
`define RD_RA       2'b10 //Jal

`endif