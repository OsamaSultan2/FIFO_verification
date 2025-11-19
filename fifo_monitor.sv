import shared_pkg::*;
import FIFO_cov_pkg::*;
import FIFO_trans_pkg::*;
import FIFO_scoreboard_pkg::*;

module FIFO_monitor (FIFO_ifc.monitor ifc);
  FIFO_transaction signals;
  FIFO_cov         cov_collect;
  FIFO_scoreboard  scoreboard;
  initial begin
    signals     = new();
    cov_collect = new();
    scoreboard  = new();
    forever begin
      wait(samp.triggered);
      @(negedge ifc.clk);
      signals.rst_n       = ifc.rst_n;
      signals.wr_en       = ifc.wr_en;
      signals.rd_en       = ifc.rd_en;
      signals.data_in     = ifc.data_in;
      signals.data_out    = ifc.data_out;
      signals.almostfull  = ifc.almostfull;
      signals.empty       = ifc.empty;
      signals.almostempty = ifc.almostempty;
      signals.overflow    = ifc.overflow;
      signals.full        = ifc.full;
      signals.underflow   = ifc.underflow;
      signals.wr_ack      = ifc.wr_ack;

      fork
      //------- coverage thread -------------------
        begin
        cov_collect.sample_data(signals);
        end
      //------- correctness checking thread ---------------
        begin
          scoreboard.check_result(signals);
        end
      join
      if (test_finished) begin
        @(posedge ifc.clk);
        $display("===========================> TEST FINISHED <===================================");
        $display("correct = %0d , errors = %0d", correct_count , error_count);
        $stop;
      end
    end
  end
endmodule