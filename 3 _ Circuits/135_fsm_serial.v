module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    
    parameter [3:0] idle  = 4'ha,start = 4'hb,stop = 4'hc,err=4'hd;
    parameter [3:0] d0=4'h0,d1=4'h1,d2=4'h2,d3=4'h3,d4=4'h4,d5=4'h5,d6=4'h6,d7=4'h7;

    reg [3:0] state,next;
    
    always @(posedge clk)begin
        if(reset)
            state <= idle;
        else
            state <= next;
    end
    
    always @(*)begin
        case(state)
            idle: 	next = (~in)? start : idle;
            start:	next = d0;
            d0: 	next = d1;
            d1: 	next = d2;
            d2: 	next = d3;
            d3: 	next = d4;
            d4: 	next = d5;
            d5:		next = d6;
            d6:		next = d7;
            d7: 	next = in? stop : err;
            stop: 	next = (~in)? start : idle;
            err:  	next = (~in)? err	: idle;
            default: next = idle;
        endcase
    end
    
    assign done = (state == stop);
endmodule