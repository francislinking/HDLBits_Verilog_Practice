module top_module (
    input clk,
    input reset,
    output [3:0] q);
		always @(posedge clk)
            if (reset || q == 4'd10)	// Count to 10 requires rolling over 10->1 instead of the more natural 15->0
			q <= 1'b1;
		else
			q <= q+1'b1;
endmodule
