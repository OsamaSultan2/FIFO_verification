interface FIFO_ifc(input bit clk);
parameter FIFO_WIDTH = 16;
parameter FIFO_DEPTH = 8;
logic                   rst_n, wr_en, rd_en;
logic [FIFO_WIDTH-1:0]  data_in;
logic [FIFO_WIDTH-1:0]  data_out;
logic                   wr_ack, overflow;
logic                   full, empty, almostfull, almostempty, underflow;

modport dut (
  input   clk,
          rst_n,
          wr_en,
          rd_en,
          data_in,

  output  wr_ack,
          data_out,
          full,
          empty,
          almostfull,
          almostempty,
          overflow,
          underflow
);

modport tb (
  output  clk,
          rst_n,
          wr_en,
          rd_en,
          data_in,

  input   wr_ack,
          data_out,
          full,
          empty,
          almostfull,
          almostempty,
          overflow,
          underflow
);

modport monitor (
  input   clk,
          rst_n,
          wr_en,
          rd_en,
          data_in,
          wr_ack,
          data_out,
          full,
          empty,
          almostfull,
          almostempty,
          overflow,
          underflow
);

endinterface 