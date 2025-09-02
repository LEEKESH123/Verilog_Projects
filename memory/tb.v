`include "mem.v"
module tb;
		parameter WIDTH = 8;
		parameter DEPTH = 32;
		parameter ADDR_WIDTH = $clog2(DEPTH);

	reg clk,res;
	reg wr_rd;
	reg valid;
	reg [ADDR_WIDTH-1:0]addr;
	reg [WIDTH-1:0]wdata;
	wire [WIDTH-1:0]rdata;
	wire ready;

	mem #(
	 .WIDTH(WIDTH),
     .ADDR_WIDTH(ADDR_WIDTH),
     .DEPTH(DEPTH))
	 DUT (.clk(clk),.res(res),.wr_rd(wr_rd),.valid(valid),.addr(addr),.wdata(wdata),.rdata(rdata),.ready(ready));
	integer i,j;
	initial begin
	clk = 0;
	forever #5 clk = ~clk;
	end


task reset;
	begin
	res = 1;
	 wr_rd = 0;
     valid = 0;
	 addr = 0;
     wdata = 0;
	 #10;
	 res = 0;
	end
endtask

task write;
	begin
	for(i = 0; i< DEPTH; i = i+1) begin
	@(posedge clk)
	wr_rd = 1;
	wdata = $random;
	addr = i;
	valid = 1;

	wait(ready);
	end
	valid = 0;
end
endtask

task reads;
	begin
	for(j = 0 ; j< DEPTH; j=j+1) begin
	@(posedge clk)
	wr_rd = 0;
	addr = j;
	valid = 1;

	wait(ready);
	end
	valid = 0;
end
endtask

	initial begin
	reset;
	#10;
	write;
	#10;
	reads;
	#100;
	$finish;

	end
endmodule 





