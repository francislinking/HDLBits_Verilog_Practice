module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
	// declaration
    parameter A=1,B=2,C=3,D=4,E=5,F=6,G=7,H=8,I=9;
    reg [31:0] state,next;
    
    // state trasition
    always @(*) begin
        case(state)
            A:	next = ~resetn?A:B;
            B:	next = C;
            C:	next = x?D:C;
            D:	next = ~x?E:D;
            E:	next = x?F:C;
            F:	next = y?H:G;
            G:	next = y?H:I;
            H:	next = H;
            I:	next = I;    
        endcase
    end
    // state flip-flop
    always @(posedge clk) begin
        if(~resetn)		state <= A;
        else 			state <= next;
    end
    
    // outpu logic
    assign f = (state == B);
    assign g = (state == F)|(state == G)|(state == H);
endmodule
