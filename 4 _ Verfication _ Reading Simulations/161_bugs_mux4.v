module top_module (
    input [1:0] sel,
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output [7:0] out  ); //

    wire [7:0] muxw0, muxw1;
    mux2 mux0 ( sel[0],    a,    b, muxw0 );
    mux2 mux1 ( sel[0],    c,    d, muxw1 );
    mux2 mux2 ( sel[1], muxw0, muxw1,  out );

endmodule
