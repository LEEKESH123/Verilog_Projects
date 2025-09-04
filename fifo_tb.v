`include "syn_fifo.v"
module tb;
	parameter WIDTH =8;
	parameter FIFO_SIZE =16;
	parameter PTR_WIDTH =$clog2(FIFO_SIZE);
	reg clk,res,wr_en,rd_en;
	reg[WIDTH-1:0]wdata;
	wire[WIDTH-1:0]rdata;
	wire full,overflow,empty,underflow;
	syn_fifo dut(.clk(clk),.res(res),.wr_en(wr_en),.rd_en(rd_en),.wdata(wdata),.rdata(rdata),.full(full),.overflow(overflow),.empty(empty),.underflow(underflow));

integer i;
	always #5 clk=~clk;
	
	initial begin
		clk=0;
		res=1;
		wr_en=0;
		rd_en=0;
		wdata=0;
		repeat(2) @(posedge clk);
		res=0;
		writes(FIFO_SIZE);
		reads(FIFO_SIZE);
		#100;
		$finish;
	end
	task writes(input integer num_writes); begin
		for(i=0;i<num_writes;i=i+1) begin
			@(posedge clk);
			wr_en=1;
			wdata=$random;
		end
		@(posedge clk);
		wr_en=0;
		wdata=0;
	end
	endtask
	
	task reads(input integer num_reads); begin
		for(i=0;i<num_reads;i=i+1) begin
			@(posedge clk);
			rd_en=1;
		end
		@(posedge clk);
		rd_en=0;
	end
	endtask
endmodule



