module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    MUXDFF muxdff3 (KEY[0],KEY[1],KEY[2],SW[3],KEY[3],LEDR[3]);
    MUXDFF muxdff2 (KEY[0],KEY[1],KEY[2],SW[2],LEDR[3],LEDR[2]);
    MUXDFF muxdff1 (KEY[0],KEY[1],KEY[2],SW[1],LEDR[2],LEDR[1]);
    MUXDFF muxdff0 (KEY[0],KEY[1],KEY[2],SW[0],LEDR[1],LEDR[0]);
endmodule

module MUXDFF (
    input clk,
	input E,
    input L,
	input R,
    input w,
	output Q);

	always @(posedge clk) begin
          Q <= L ? R : (E?w:Q);
    end
    
endmodule
