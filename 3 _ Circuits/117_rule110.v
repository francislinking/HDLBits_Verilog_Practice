module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 
	
    wire [511:0] L,R;
    assign L = {1'b0,q[511:1]};
    assign R = {q[510:0],1'b0};
    
    always @(posedge clk) begin
        if (load)
            q<=data;
        else 
            q<=L&(q^R) | (~L)&(q|R);

    end
    
endmodule