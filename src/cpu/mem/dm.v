`include "defs.vh"
module dm(
  input clk,
  input [31:0] addr, wdata,
  input [2:0] mem_sel,
  input DMWr,
  output reg [31:0] rdata
);

wire [1:0] offset = addr[1:0];
wire [9:0] start_word_addr = addr[11:2];
localparam MEM_SIZE = 1024;
reg [31:0] dmem[MEM_SIZE-1:0];

// write, store
always @(posedge clk) begin
  if(DMWr) begin
    case(mem_sel)
    `MEM_B: 
      case(offset) 
      2'b00:  dmem[start_word_addr][7:0]   <= wdata[7:0];
      2'b01:  dmem[start_word_addr][15:8]  <= wdata[7:0];
      2'b10:  dmem[start_word_addr][23:16] <= wdata[7:0];
      2'b11:  dmem[start_word_addr][31:24] <= wdata[7:0];
      endcase
    `MEM_H: 
      // assume half word offset 0 or 2
      case(offset)
      2'b00: dmem[start_word_addr][15:0]   <= wdata[16:0];
      2'b10: dmem[start_word_addr][31:16]  <= wdata[16:0];
      endcase
    `MEM_W:  dmem[start_word_addr] <= wdata;
    endcase
  end
end 

wire [31:0] mem_data = dmem[start_word_addr];
// addr, load
always @(*) begin
  case(mem_sel)
  `MEM_B:  
    case(offset)
    2'b00:   rdata = {{24{mem_data[7]}}, mem_data[7:0]};
    2'b01:   rdata = {{24{mem_data[15]}}, mem_data[15:8]};
    2'b10:   rdata = {{24{mem_data[23]}}, mem_data[23:16]};
    2'b11:   rdata = {{24{mem_data[31]}}, mem_data[31:24]};
    endcase
  `MEM_BU: 
    case(offset)
    2'b00:  rdata = {24'b0, mem_data[7:0]};
    2'b01:  rdata = {24'b0, mem_data[15:8]};
    2'b10:  rdata = {24'b0, mem_data[23:6]};
    2'b11:  rdata = {24'b0, mem_data[31:24]};
    endcase
  `MEM_H:
    case(offset)
    2'b00:  rdata = {{16{mem_data[15]}}, mem_data[15:0]};
    2'b10:  rdata = {{16{mem_data[31]}}, mem_data[31:16]};
    default: rdata = `ERR_WORD;
    endcase
  `MEM_HU:
    case(offset)
    2'b00:  rdata = {16'b0, mem_data[15:0]};
    2'b10:  rdata = {16'b0, mem_data[31:16]};
    default: rdata = `ERR_WORD;
    endcase
  `MEM_W:  rdata = mem_data;
  default:     rdata = `ERR_WORD;
  endcase
end

  
endmodule    