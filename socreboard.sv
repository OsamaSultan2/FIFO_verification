package FIFO_scoreboard_pkg;
  import FIFO_trans_pkg::*;
  import shared_pkg::*;
  class FIFO_scoreboard;
  parameter FIFO_WIDTH = 16;
  parameter FIFO_DEPTH = 8;
  //------------- VARIABLES -----------------------
  logic [FIFO_WIDTH-1:0]  data_out_ref   = 0;
  logic                   wr_ack_ref     = 0, overflow_ref    = 0;
  logic                   full_ref       = 0, empty_ref       = 0;
  logic                   almostfull_ref = 0, almostempty_ref = 0;
  logic                   underflow_ref  = 0;
  logic [FIFO_WIDTH-1:0]  mem_ref[$:FIFO_DEPTH];
  
  //=============== METHODS =============================
  function void reference_model(FIFO_transaction F_txn) ; 
    if (!F_txn.rst_n) begin
      mem_ref.delete();
      data_out_ref = 0;
    end
    else begin
    //------- write operation --------------------
    full_ref        =  (mem_ref.size() == FIFO_DEPTH)    ? 1:0;
    almostfull_ref  =  (mem_ref.size() == FIFO_DEPTH -1) ? 1:0;
    empty_ref       =  (mem_ref.size() == 0)   ? 1:0;
    almostempty_ref =  (mem_ref.size() == 1)   ? 1:0;
      if (F_txn.wr_en) begin
        if(!full_ref)begin
          mem_ref.push_back(F_txn.data_in);
          wr_ack_ref    = 1;
          overflow_ref  = 0;
        end
        else begin
          overflow_ref  = 1;
          wr_ack_ref    = 0;
        end
      end
    //-------- read operation -------------------
      if (F_txn.rd_en) begin
        if (!empty_ref) begin
          data_out_ref  = mem_ref.pop_front();
          underflow_ref = 0;
        end
        else begin
          data_out_ref  = 0;
          underflow_ref = 1;
        end
      end
    //--------- flags assignements --------------
    end
  endfunction

  function void check_result(FIFO_transaction F_txn);
    reference_model(F_txn);
    if(F_txn.data_out == data_out_ref) begin
      correct_count ++;
    end
    else begin
      $error("data_out = %0d, expected = %0d" , F_txn.data_out, data_out_ref);
      error_count ++;
    end
  endfunction
  
  endclass
endpackage