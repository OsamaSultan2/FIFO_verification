////////////////////////////////////////////////////////////////////////////////
// Author: Kareem Waseem
// Course: Digital Verification using SV & UVM
//
// Description: FIFO Design 
// 
////////////////////////////////////////////////////////////////////////////////
module FIFO(FIFO_ifc.dut ifc);
parameter FIFO_WIDTH = 16;
parameter FIFO_DEPTH = 8;
 
localparam max_fifo_addr = $clog2(FIFO_DEPTH);

reg [FIFO_WIDTH-1:0] mem [FIFO_DEPTH-1:0];
	 
reg [max_fifo_addr-1:0] wr_ptr, rd_ptr;
reg [max_fifo_addr:0] count; //bug count didn't wraparound 

always @(posedge ifc.clk or negedge ifc.rst_n) begin
	if (!ifc.rst_n) begin
		
		wr_ptr   <= 0;

	end
	else if (ifc.wr_en && count < FIFO_DEPTH) begin
		mem[wr_ptr] <= ifc.data_in;
		ifc.wr_ack <= 1;
		wr_ptr <= wr_ptr + 1;
	end
	else begin 
		ifc.wr_ack <= 0; 
		if (ifc.full & ifc.wr_en)
			ifc.overflow <= 1;
		else
			ifc.overflow <= 0;
	end
end

always @(posedge ifc.clk or negedge ifc.rst_n) begin
	if (!ifc.rst_n) begin
		rd_ptr <= 0;
		// data_out signals didn't reset
		ifc.data_out <= 0;
	end
	else 
		if (ifc.rd_en && count != 0) begin
			ifc.data_out <= mem[rd_ptr];
			rd_ptr <= rd_ptr + 1;
			ifc.underflow <= 0; // bug
		end
		else if (ifc.rd_en && count == 0) begin
			ifc.data_out  <= 0;
			ifc.underflow <= 1; // bug
		end
 
end

always @(posedge ifc.clk or negedge ifc.rst_n) begin
	if (!ifc.rst_n) begin
		count <= 0;
	end
	else begin
		if	( ({ifc.wr_en, ifc.rd_en} == 2'b10) && !ifc.full) 
			count <= (count + 1);
		else if ( ({ifc.wr_en, ifc.rd_en} == 2'b01) && !ifc.empty)
			count <= (count - 1) ;
			//error didn't handle both writing and reading  case 
		else if (({ifc.wr_en, ifc.rd_en} == 2'b11)) begin
			if (ifc.empty) begin
				count <= (count + 1);
			end
			else if (ifc.full) begin
				count <= (count - 1);
			end
		end
	end
end

assign ifc.full = (count == FIFO_DEPTH)? 1 : 0;
assign ifc.empty = (count == 0)? 1 : 0;
// BUG underflow signal should be squential.
assign ifc.almostfull = (count == FIFO_DEPTH-1)? 1 : 0; //==> bug almost full should assert when the fifo has only one empty space
assign ifc.almostempty = (count == 1)? 1 : 0;
//=========================== ASSERATION ================================
//-->RESET CHK
`ifdef SIM
	always_comb begin : RESET_CHK
		if(!ifc.rst_n) begin
			ASNYC_RST: assert final( wr_ptr == 0  && rd_ptr == 0 && count == 0 ) 
			else  $error("error in reseting the internal pointers and counters");
		end
	end
//-->WR_ACK_CHK
  property wr_ack_p;
	@(posedge ifc.clk) disable iff(!ifc.rst_n)
		(ifc.wr_en && !ifc.full) |=> ifc.wr_ack;
  endproperty
	WR_ACK_CHK:assert property (wr_ack_p) 
	else $error("error in writing ack");
	cover property (wr_ack_p);

//--> OVERFLOW_CHK
	property overflow_p;
		@(posedge ifc.clk) disable iff(!ifc.rst_n)
		(ifc.wr_en && ifc.full) |=> ifc.overflow ;
	endproperty
	OVERFLOW_CHK:assert property (overflow_p)
	else $error("error in overflow flag");
	cover property (overflow_p);	

//--> UNDERFLOW_CHK
	property underflow_p;
		@(posedge ifc.clk) disable iff(!ifc.rst_n)
		(ifc.rd_en && ifc.empty) |=> ifc.underflow ;
	endproperty
	UNDERFLOW_CHK:assert property (underflow_p)
	else $error("error in underflow flag");
	cover property (underflow_p);
//-->	FULL_CHK
	property full_p;
 		@(posedge ifc.clk) 
		(count == FIFO_DEPTH) |-> ifc.full;
	endproperty
	FULL_CHK: assert property (full_p)
	else $error("error in full flag");
	cover property (full_p);

//--> EMPTY_CHK
	property empty_p; 
		@(posedge ifc.clk) 
		(count == 0) |-> ifc.empty;
	endproperty
	EMPTY_CHK: assert property (empty_p)
	else $error("error in empty flag");
	cover property (empty_p);

//-->	ALMOSTFULL_CHK
	property a_full_p;
 		@(posedge ifc.clk) 
		(count == FIFO_DEPTH - 1) |-> ifc.almostfull;
	endproperty
	ALMOST_FULL_CHK: assert property (a_full_p)
	else $error("error in almostfull flag");
	cover property (a_full_p);

//--> ALMOSTEMPTY_CHK
	property a_empty_p; 
		@(posedge ifc.clk) 
		(count == 1) |-> ifc.almostempty;
	endproperty
	ALMOST_EMPTY_CHK: assert property (a_empty_p)
	else $error("error in almostempty flag");
	cover property (a_empty_p);
//--> write_pointer_wraparound
  property wr_wrap_p;
	@(posedge ifc.clk) disable iff(!ifc.rst_n)
	ifc.wr_en && !ifc.full && wr_ptr == (FIFO_DEPTH - 1'b1)|=>  (wr_ptr == 0); 
  endproperty
	WR_WRAP: assert property (wr_wrap_p) 
	else $error("ERROR in wr_pointer wraparound");
	cover property(wr_wrap_p);

//-->READ_POINTER_WRAPAROUND
	property rd_wrap_p;
	@(posedge ifc.clk) disable iff(!ifc.rst_n)
	ifc.rd_en && !ifc.empty && rd_ptr == (FIFO_DEPTH - 1'b1 )|=>  (rd_ptr == 0); 
	endproperty
	RD_WRAP: assert property (rd_wrap_p) 
	else $error("ERROR in rd_pointer wraparound");
	cover property(rd_wrap_p);


//--> POINTERS_THRESHOLD
	property pointer_threshold; 
	@(posedge ifc.clk) 
	wr_ptr <= FIFO_DEPTH && rd_ptr <= FIFO_DEPTH && count <= FIFO_DEPTH;
	endproperty
	THRESHOLD:assert property(pointer_threshold)
	else $error("POINTERS exceeded the FIFO_DEPTH");
	cover property(pointer_threshold);
`endif
endmodule