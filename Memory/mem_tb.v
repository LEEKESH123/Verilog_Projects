`include "memory.v"
module tb;
	parameter WIDTH = 16;
	parameter ADDR_WIDTH = 8;
	parameter DEPTH = 1 << ADDR_WIDTH; 

		   reg clk,res;
	       reg wr_rd;
		   reg [ADDR_WIDTH-1:0] addr;
		   reg [WIDTH-1:0] wdata;
		   reg valid;
		   wire [WIDTH-1:0] rdata;
		   wire ready;
		   
mem #(
        .WIDTH(WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .DEPTH(DEPTH)
    ) dut (
        .clk(clk),
        .res(res),
        .wr_rd(wr_rd),
        .addr(addr),
        .wdata(wdata),
        .valid(valid),
        .rdata(rdata),
        .ready(ready)
    );
		  

	initial begin
		clk =0;
        forever #5 clk =~clk;
    end

	integer i,j;
	initial begin
	res = 1;
	wr_rd = 0;
	wdata = 0;
	valid = 0;
	addr = 0;

	repeat(2) @(posedge clk);
	res = 0;

	  //write
	  for(i=0;i < 16;i=i+1) begin
	  @(posedge clk);
	  wr_rd = 1;
	  addr = i;
	  wdata = i*10;
	  valid = 1;
	  
	  wait(ready);
	 
	  @(posedge clk);
	  valid = 0;
	  end
	  
	  //read
	  for(j=0;j<16;j=j+1) begin
	  @(posedge clk);
	  wr_rd = 0;
	  addr = j;
	  valid =1;
	  
	  wait(ready);
	  @(posedge clk);
	  valid = 0;

	  end
	  #100;
	  $finish;
	  
	 end
	  
	 initial begin
	        $monitor("Time=%0t clk=%b res=%b wr_rd=%b valid=%b addr=%d wdata=%d rdata=%d ready=%b",
	                 $time , clk, res, wr_rd, valid, addr, wdata, rdata, ready);
	    end
	
endmodule











		   

