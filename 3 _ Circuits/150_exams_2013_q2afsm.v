module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
	
    // declaration
    parameter A=4'b0001,B=4'b0010,C=4'b0100,D=4'b1000;
    reg [3:0] state,next;
    
    // state transition
    always@(*) begin
        case (state)
            A:  next = r[1]?B:(r[2]?C:(r[3]?D:A));
            B:	next = r[1]?B:A;
            C:	next = r[2]?C:A;
            D:	next = r[3]?D:A;
        endcase
    end
    
    // state flip-flop
    always @(posedge clk) begin
        if (~resetn)
            state <= A;
        else
            state <= next;
    end
    
    // output logic
    assign g[1] = (state == B);
    assign g[2] = (state == C);
    assign g[3] = (state == D);
    
endmodule
