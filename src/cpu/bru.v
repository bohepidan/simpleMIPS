`include "defs.vh"
//branch unit
module bru (
  input [31:0] rdata1, rdata2,
  output Breq, Brlt, Breqz, Brltz
);

assign Breq = rdata1 == rdata2;

assign Brlt = $signed(rdata1) < $signed(rdata2);

assign Breqz = rdata1 == 32'b0;

assign Brltz = $signed(rdata1) < 32'b0;
  
endmodule