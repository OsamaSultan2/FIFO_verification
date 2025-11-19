package FIFO_trans_pkg;
  class FIFO_transaction;
    parameter                  FIFO_WIDTH = 16;
    parameter                  FIFO_DEPTH = 8;
    int                        RD_EN_ON_DIST, WR_EN_ON_DIST;
    rand bit                   rst_n, wr_en, rd_en;
    rand bit [FIFO_WIDTH-1:0]  data_in;
    logic [FIFO_WIDTH-1:0]     data_out;
    logic                      wr_ack, overflow;
    logic                      full, empty, almostfull, almostempty, underflow;
    
  //============== constructor ==============
    function new(int RD_VAL=30, int WR_VAL=70);
      RD_EN_ON_DIST = RD_VAL;
      WR_EN_ON_DIST = WR_VAL;
    endfunction
  //============== constraints definition ==============

  //----> RST_CHK  
  constraint rst_n_c {
    rst_n dist {1 := 95, 0 := 5};
  }

  //-----> WR_EN_CHK
  constraint wr_en_c {
    wr_en dist {1 := WR_EN_ON_DIST , 0 := 100-WR_EN_ON_DIST};
  }

  //-----> RD_EN_CHK 
  constraint rd_en_c {
    rd_en dist {1 := RD_EN_ON_DIST , 0 := 100 - RD_EN_ON_DIST};
  }
  endclass 
  

endpackage