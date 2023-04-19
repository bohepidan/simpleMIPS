`include "defs.vh"
module dm(
  input clk,
  input [31:0] addr, wdata,
  input DMWr,
  output [31:0] DMout
);
    
localparam MEM_SIZE = 4096;
reg [31:0] dmem[MEM_SIZE-1:0];

always @(posedge clk) begin
  if (DMWr)
      dmem[addr] <= wdata;
end 

assign DMout = dmem[addr];
  
endmodule    