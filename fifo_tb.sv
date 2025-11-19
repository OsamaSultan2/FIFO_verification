import FIFO_trans_pkg::*;
import shared_pkg::*;
module FIFO_tb (FIFO_ifc.tb ifc);
  FIFO_transaction packet;
  //-------- stimulus generation --------------
  initial begin
    packet    = new(30,70);
    ifc.rst_n = 0;
    -> samp;
    @(negedge ifc.clk);
    ifc.rst_n = 1;
    -> samp;
    @(negedge ifc.clk);
    repeat(10000) begin
      assert (packet.randomize()) 
      else   $fatal("packet can't be randomized");
      ifc.rst_n   = packet.rst_n;
      ifc.wr_en   = packet.wr_en;
      ifc.rd_en   = packet.rd_en;
      ifc.data_in = packet.data_in;
        -> samp;
      @(negedge ifc.clk);
    end
    packet    = new(80,40);
    repeat(10000) begin
      assert (packet.randomize()) 
      else   $fatal("packet can't be randomized");
      ifc.rst_n   = packet.rst_n;
      ifc.wr_en   = packet.wr_en;
      ifc.rd_en   = packet.rd_en;
      ifc.data_in = packet.data_in;
      -> samp;
      @(negedge ifc.clk);
    end
    test_finished = 1;
    ->samp;
  end
endmodule