module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
	parameter A=0,B=1,C=2,D=3,E=4,F=5;
    reg [5:0] state;
    
    // State transition logic: Derive an equation for each state flip-flop.
    assign state[A] = (~w)&(y[A]|y[D]);
    assign state[B] = w&y[A];
    assign state[C] = w&(y[B]|y[F]);
    assign state[D] = (~w)&(y[B]|y[C]|y[E]|y[F]);
    assign state[E] = w&(y[C]|y[E]);
    assign state[F] = w&(y[D]);


    // Output logic: 
    assign Y1 = state[B];
    assign Y3 = state[D];
endmodule
