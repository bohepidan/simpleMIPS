`include "defs.vh"
module ex (
  input [1:0] ALUOp,
  input [31:0] rdata1, rdata2, imm32,
  input BSel,
  output [31:0] ALUout
);

wire [31:0] op1, op2;
assign op1 = rdata1;
assign op2 = BSel ? imm32 : rdata2;

reg [31:0] ALUout;
always @(*) begin
  case(ALUOp)
    `ALU_ADDU:
      ALUout = op1 + op2;
    `ALU_SUBU:
      ALUout = op1 - op2;
    `ALU_OR:
      ALUout = op1 | op2;
    `ALU_ADD:
      ALUout = op1 + op2;
  endcase
end
  
endmodule