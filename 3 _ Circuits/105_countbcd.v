module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
	    

    bcd bcd0 (clk,1'b1,reset,q[3:0]);
    bcd bcd1 (clk,ena[1],reset,q[7:4]);
    bcd bcd2 (clk,ena[2],reset,q[11:8]);
    bcd bcd3 (clk,ena[3],reset,q[15:12]);
    
    assign ena[1] = (q[3:0]==4'h9)?1:0;
    assign ena[2] = (ena[1] & q[7:4]==4'h9)?1:0;
    assign ena[3] = (ena[2] & q[11:8]==4'h9)?1:0;
endmodule

module bcd (
    input clk,
    input ena,
    input reset,        // Synchronous active-high reset
    output [3:0] q);
	always @(posedge clk) begin
        if (reset)
            q<=4'h0;
        else 
            if (q == 4'h9)
                q<=ena?4'h0:q;
        	else
                q<=ena?q+1'b1:q;
    end
endmodule