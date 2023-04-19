`include "defs.vh"
module im (
  input [11:2] addr,
  output [31:0] data
);

localparam MEM_SIZE = 1024;
reg [31:0] instr_mem [MEM_SIZE-1:0];

assign data = instr_mem[addr];
  
endmodule