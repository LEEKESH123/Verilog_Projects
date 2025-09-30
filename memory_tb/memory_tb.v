`include "memory.v"
module tb;
	parameter WIDTH=8;
	parameter DEPTH=32;
	parameter ADDR_WIDTH=$clog2(DEPTH);
	reg clk,res,wr_rd,valid;
	reg[ADDR_WIDTH-1:0]addr;
	reg [WIDTH-1:0]wdata;
	wire[WIDTH-1:0]rdata;
	wire ready;
	memory dut(.clk(clk),.res(res),.wr_rd(wr_rd),.addr(addr),.wdata(wdata),.rdata(rdata),.valid(valid),.ready(ready));
	
	integer i;
	always #5 clk=~clk;
	reg[20*8-1:0]test_name;
	
	initial begin
		$value$plusargs("test_name=%0s",test_name);
	end
	initial begin
		clk=0;
		res=1;
		wr_rd=0;
		addr=0;
		wdata=0;
		valid=0;
		repeat(2) @(posedge clk);
		res=0;
		case(test_name)
			"1wr_1rd": begin
				writes(15,1);
				reads(15,1);
			end
			"5wr_5rd": begin
				writes(20,5);
				reads(20,5);	
			end
			"FD_WR_FD_RD": begin
				writes(0,DEPTH);
				reads(0,DEPTH);
			end
			"BD_WR_BD_RD": begin
				bd_writes();
				bd_reads();
			end
			"FD_WR_BD_RD": begin
				writes(0,DEPTH);
				bd_reads();
			end
			"BD_WR_FD_RD": begin
				bd_writes();
				reads(0,DEPTH);	
			end
			"1ST_QUATOR_WR_RD": begin
				writes(0,DEPTH/4);	
				reads(0,DEPTH/4);	
			end
			"2ND_QUATOR_WR_RD": begin
				writes(DEPTH/4,DEPTH/4);	
				reads(DEPTH/4,DEPTH/4);		
			end
			"3RD_QUATOR_WR_RD": begin
				writes(DEPTH/2,DEPTH/4);	
				reads(DEPTH/2,DEPTH/4);	
			
			end
			"4TH_QUATOR_WR_RD": begin
				writes((3*DEPTH)/4,DEPTH/4);	
				reads((3*DEPTH)/4,DEPTH/4);	
			
			end
			"CONSECUTIVE": begin
				for(i=0;i<DEPTH;i=i+1) begin
					consecutive(i);
				end
			end
		endcase
		#100;
		$finish;
	end
	task writes(input reg[ADDR_WIDTH-1:0]start_loc,input reg[ADDR_WIDTH:0]num_writes); begin
		for(i=start_loc;i<(start_loc+num_writes);i=i+1) begin	
			@(posedge clk);
			wr_rd=1;
			addr=i;
			wdata=$random;
			valid=1;
			wait(ready==1);
		end
		@(posedge clk);
		wr_rd=0;
		addr=0;
		wdata=0;
		valid=0;
	end
	endtask

	task reads(input reg[ADDR_WIDTH-1:0]start_loc,input reg[ADDR_WIDTH:0]num_reads); begin
		for(i=start_loc;i<(start_loc+num_reads);i=i+1) begin	
			@(posedge clk);
			wr_rd=0;
			addr=i;
			valid=1;
			wait(ready==1);
		end
		@(posedge clk);
		wr_rd=0;
		addr=0;
		valid=0;

	end
	endtask

	task bd_writes();
		$readmemh("input.hex",dut.mem);
	endtask
	task bd_reads();
		$writememh("output.hex",dut.mem);
	endtask
	task consecutive(input reg[ADDR_WIDTH-1:0]loc); begin
			@(posedge clk);
			wr_rd=1;
			addr=loc;
			wdata=$random;
			valid=1;
			wait(ready==1);
			@(posedge clk);
			wr_rd=0;
			addr=loc;
			valid=1;
			wait(ready==1);
	end
	endtask
endmodule




