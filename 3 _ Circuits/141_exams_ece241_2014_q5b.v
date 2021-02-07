module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
	parameter A = 1'b0,B = 1'b1;
    reg state,next;
    
    always@(*) begin
        case(state)
            A: next = x ? B : A;
            B: next = B;
        endcase
    end
    
    always@(posedge clk, posedge areset) begin
        if(areset)
            state <= A;
        else
            state <= next;
    end
    
    always@(*) begin
        if(areset)
            z <= x;
        else
            case(state)
                A: z = x;
                B: z = ~x;
            endcase
    end
endmodule
