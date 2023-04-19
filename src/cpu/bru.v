`include "defs.vh"
//branch unit
module bru (
  input [31:0] rdata1, rdata2,
  output Breq, Brlt
);

assign Breq = rdata1 == rdata2;

assign Brlt = rdata1 < rdata2;
  
endmodule