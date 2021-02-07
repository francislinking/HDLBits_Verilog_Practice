module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
	parameter A0 = 2'b00,A1 = 2'b01, B0 = 2'b10, B1 = 2'b11;
    reg [1:0] state,next;
    
    always@(*) begin
        case(state)
            A0: next = x ? A1 : A0;
            A1: next = x ? B1 : B0;
            B0: next = x ? B1 : B0;
            B1: next = x ? B1 : B0;
        endcase
    end
    
    always@(posedge clk, posedge areset) begin
        if(areset)
            state <= A0;
        else
            state <= next;
    end
    
        always@(*) begin
        case(state)
            A0: z = 1'b0;
            A1: z = 1'b1;
            B0: z = 1'b1;
            B1: z = 1'b0;
        endcase
    end
    
endmodule
