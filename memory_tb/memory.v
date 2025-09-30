module memory(clk,res,wr_rd,addr,wdata,rdata,valid,ready);
	parameter WIDTH=8;
	parameter DEPTH=32;
	parameter ADDR_WIDTH=$clog2(DEPTH);
	input clk,res,wr_rd,valid;
	input[ADDR_WIDTH-1:0]addr;
	input [WIDTH-1:0]wdata;
	output reg[WIDTH-1:0]rdata;
	output reg ready;
	
	// declare the memory 
		reg[WIDTH-1:0]mem[DEPTH-1:0];
	integer i;

	always @(posedge clk) begin
		if(res==1) begin
			rdata=0;
			ready=0;
			for(i=0;i<DEPTH;i=i+1) mem[i]=0;
		end
		else begin
			if(valid==1) begin
				ready=1;
				if(wr_rd==1) mem[addr]=wdata;
				else rdata=mem[addr];
			end
			else ready=0;
		end
	end
endmodule



