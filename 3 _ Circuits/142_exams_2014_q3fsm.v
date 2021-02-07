module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
	parameter A=0,B=1,C=2,D=3;
    reg [2:0] state,next;
    reg [2:0] count;
    
    always@(*)begin
        case(state)
            A:	next = s?B:A;
            B:	next = C;
			C: 	next = D;
            D: 	next = B;
        endcase
    end
    
    always@(posedge clk) begin
        if(reset)
            state <= A;
        else
            state <= next;
    end
    
    always@(posedge clk) begin
        case(state) 
            A:count <= 3'b000;
            B:count <= {2'b00,w};
        	C:count <= {count[1:0],w};
            D:count <= {count[1:0],w};
        endcase
    end
    
    assign z = (state==B) & (count == 3'b011)|(count == 3'b101)|(count == 3'b110);
endmodule
