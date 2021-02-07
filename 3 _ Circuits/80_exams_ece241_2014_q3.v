module top_module (
	input c,
	input d,
	output [3:0] mux_in
);
	
	// After knowing how to split the truth table into four columns,
	// the rest of this question involves implementing logic functions
	// using only multiplexers (no other gates).
	// I will use the conditional operator for each 2-to-1 mux: (s ? a : b)
	assign mux_in[0] = (c ? 1 : (d ? 1 : 0));	// 2 muxes: c|d
	assign mux_in[1] = 0;						// No muxes:  0
	assign mux_in[2] = d ? 0 : 1;				// 1 mux:    ~d
	assign mux_in[3] = c ? (d ? 1 : 0) : 0;		// 2 muxes: c&d
	
    // my solution
    // assign mux_in = {c&d,~d,1'b0,c|d};
endmodule
