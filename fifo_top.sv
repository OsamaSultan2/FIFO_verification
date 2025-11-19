module top ();
  bit clk;
  //------- clock generation  -----------
  initial begin
    clk=0;
    forever begin
       #5 clk= ~clk;
    end
  end
  //------ modules instantiations ----------
  FIFO_ifc     ifc(clk);
  FIFO         DUT(ifc);
  FIFO_tb      tb (ifc);
  FIFO_monitor monitor(ifc);
  //--------------- reset asseration ---------
  always_comb begin
    if(! ifc.rst_n)
    RESET_OUT_CHK: assert final(ifc.data_out == 0) 
    else   $error("ERROR IN RESETING THE DATA_OUT asychronusly");

  end
endmodule