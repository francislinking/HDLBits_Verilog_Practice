module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);
	
	reg [7:0] d_last;	
			
	always @(posedge clk) begin
		d_last <= in;			// Remember the state of the previous cycle
		pedge <= in & ~d_last;	// A positive edge occurred if input was 0 and is now 1.
	end
	
    // my solution
    // integer i;
    // reg [7:0] in_ref,p_ref;
    // always @(posedge clk) begin
    //     in_ref <= in;
    //     for (i=0;i<8;i++) begin
    //         if (in[i] & (in[i]^in_ref[i]))
    //             pedge[i] <= 1'b1;
    //        	else
    //             pedge[i] <= 1'b0;
    //     end
    // end
endmodule
