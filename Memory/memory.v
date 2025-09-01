module mem #(
	       parameter WIDTH = 8,
		   parameter DEPTH = 8,
		   parameter ADDR_WIDTH = $clog2(DEPTH)

		   )(
	 	   input clk,res,
	       input wr_rd,
		   input [ADDR_WIDTH-1:0] addr,
		   input [WIDTH-1:0] wdata,
		   input valid,
		   output reg [WIDTH-1:0] rdata,
		   output reg ready
		   );

		   integer i;

		   //declare the memory

		   reg[WIDTH-1:0] mem [DEPTH-1:0];

		   always@(posedge clk) begin
		   if(res) begin
		   		rdata <= 0;
				ready <= 0;
					for(i = 0; i<DEPTH; i=i+1) begin
						mem[i] <= 0;
					end
			end
			else begin
				if(valid) begin
					ready <= 1; // HANDSHAKING done
					if(wr_rd)begin
						mem[addr] <= wdata;
					end else begin
						rdata <= mem[addr];
					end
				end else begin
					ready <= 0;
				end
			end
		end
endmodule


						



