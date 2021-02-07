module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
	always @(posedge clk)
        if (reset)	// Count to 10 requires rolling over 9->0 instead of the more natural 15->0
				q <= 1'b0;
			else
                q <= slowena?(q == 4'h9 ? 1'b0:q+1'b1):q;
endmodule
