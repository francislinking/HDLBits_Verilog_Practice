module top_module (
	input x3,
	input x2,
	input x1,
	output f
);
	// This truth table has four minterms. 
	assign f = ( ~x3 & x2 & ~x1 ) | 
				( ~x3 & x2 & x1 ) |
				( x3 & ~x2 & x1 ) |
				( x3 & x2 & x1 ) ;
				
	// It can be simplified, by boolean algebra or Karnaugh maps.
	// assign f = (~x3 & x2) | (x3 & x1);
	
	// You may then notice that this is actually a 2-to-1 mux, selected by x3:
	// assign f = x3 ? x1 : x2;
	
    // my solution
    // always @(*) begin
    //     case({x3,x2,x1})
    //         3'b000:f = 0;
    //         3'b001:f = 0;
    //         3'b010:f = 1;
    //         3'b011:f = 1;
    //         3'b100:f = 0;
    //         3'b101:f = 1;
    //         3'b110:f = 0;
    //         3'b111:f = 1;
    //     endcase
    // end
endmodule
