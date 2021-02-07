module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
	
    parameter S0=3'b000,S1=3'b001,S11=3'b010,S110=3'b011,S1101=3'b100;
    reg [2:0] state, next;
    
    always @(posedge clk) begin
        if(reset)
            state <= S0;
        else
            state <= next;
    end
    
    always @(*) begin
        case(state)
            S0 		: next = data	?	S1	 :	S0;
            S1 		: next = data	?	S11	 :	S0;
            S11 	: next = ~data	?	S110 :	S11;
            S110 	: next = data 	?	S1101:	S0;
            S1101	: next = S1101;
            default	: next = state;
        endcase
    end
    
    assign start_shifting = (state == S1101);
endmodule
