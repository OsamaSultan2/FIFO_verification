package FIFO_cov_pkg;
import FIFO_trans_pkg::*;
  
  class FIFO_cov;
    FIFO_transaction F_cvg_txn;

    //========== coverage ===========================
    covergroup cvg; 
    //-------- coverpoints ----------
    WR_EN_COV:coverpoint F_cvg_txn.wr_en{
      option.weight =0;
      bins wr_high = {1'b1} ; 
      bins wr_low  = {1'b0} ;
    }
    RD_EN_COV: coverpoint F_cvg_txn.rd_en{
        option.weight =0;
        bins rd_high = {1'b1} ; 
        bins rd_low  = {1'b0} ;
    }
    FULL_COV: coverpoint F_cvg_txn.full{
        option.weight =0;
        bins full_high = {1'b1} ; 
        bins full_low  = {1'b0} ;
    }
    A_FULL_COV: coverpoint F_cvg_txn.almostfull{
        option.weight =0;
        bins a_full_high = {1'b1} ; 
        bins a_full_low  = {1'b0} ;
    }
    EMPTY_COV: coverpoint F_cvg_txn.empty{
        option.weight =0;
        bins empty_high = {1'b1} ; 
        bins empty_low  = {1'b0} ;
    }
    A_EMPTY_COV: coverpoint F_cvg_txn.almostempty{
        option.weight =0;
        bins a_empty_high = {1'b1} ; 
        bins a_empty_low  = {1'b0} ;
    }
    OVERFLOW_COV: coverpoint F_cvg_txn.overflow{
        option.weight =0;
        bins overflow_high = {1'b1} ; 
        bins overflow_low  = {1'b0} ;
    }
    UNDERFLOW_COV: coverpoint F_cvg_txn.underflow{
        option.weight =0;
        bins under_high = {1'b1} ; 
        bins under_low  = {1'b0} ;
    }
    WR_ACK_COV: coverpoint F_cvg_txn.wr_ack{
        option.weight =0;
        bins wr_ack_high = {1'b1} ; 
        bins wr_ack_low  = {1'b0} ;
    }
    //------------- CROSS COVERAGE --------------------
    FULL_CROSS:       cross WR_EN_COV, RD_EN_COV, FULL_COV {
      ignore_bins cant_occur = binsof(RD_EN_COV.rd_high) && binsof(FULL_COV.full_high);
    }
    A_FULL_CROSS:     cross WR_EN_COV, RD_EN_COV, A_FULL_COV;
    A_EMPTY_CROSS:    cross WR_EN_COV, RD_EN_COV, A_EMPTY_COV;
    EMPTY_CROSS:      cross WR_EN_COV, RD_EN_COV, EMPTY_COV;
    OVERFLOW_CROSS:   cross WR_EN_COV, RD_EN_COV, OVERFLOW_COV;
    UNDERFLOW_CROSS:  cross WR_EN_COV, RD_EN_COV, UNDERFLOW_COV;
    WR_ACK_CROSS:     cross WR_EN_COV, RD_EN_COV, WR_ACK_COV;
    endgroup

    //==========  methods ===================
    
    function new();
      cvg = new();
    endfunction
    
    function void sample_data(FIFO_transaction F_txn);
    F_cvg_txn = F_txn;
    cvg.sample();
    endfunction
  endclass //FIFO_cov
endpackage