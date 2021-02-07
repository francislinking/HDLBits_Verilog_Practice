module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
	
    // declaration
    parameter none = 4'd0, one = 4'd1, two = 4'd2, three = 4'd3, four = 4'd4, five = 4'd5, six = 4'd6;
    parameter ERR = 4'd7, DISC = 4'd8, FLAG = 4'd9;
    reg [3:0] state, next;
    
    // state transition
    always @(*) begin
        case(state)
            none: 	next = in ?	one		: none;
            one:	next = in ?	two		: none;
            two:	next = in ? three 	: none;
            three: 	next = in ? four	: none;
            four: 	next = in ? five 	: none;
            five: 	next = in ? six 	: DISC;
            six: 	next = in ? ERR		: FLAG;
            ERR:	next = in ? ERR		: none;
            DISC:	next = in ? one	 	: none;
            FLAG: 	next = in ? one 	: none;
        endcase
    end
    // state flip-flop
    always @(posedge clk) begin
        if(reset)
            state <= none;
        else
            state <= next;
    end
    // output logic
    
    assign disc = (state == DISC);
    assign flag = (state == FLAG);
    assign err 	= (state == ERR);
endmodule
