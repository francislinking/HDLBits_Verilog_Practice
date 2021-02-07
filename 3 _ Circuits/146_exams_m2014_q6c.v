module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);
    
	parameter A=1,B=2,C=3,D=4,E=5,F=6;
    reg [6:1] state;
    
    // State transition logic: Derive an equation for each state flip-flop.
    assign state[A] = w&(y[A]|y[D]);
    assign state[B] = (~w)&y[A];
    assign state[C] = (~w)&(y[B]|y[F]);
    assign state[D] = w&(y[B]|y[C]|y[E]|y[F]);
    assign state[E] = (~w)&(y[C]|y[E]);
    assign state[F] = (~w)&(y[D]);


    // Output logic: 
    assign Y2 = state[B];
    assign Y4 = state[D];
endmodule
