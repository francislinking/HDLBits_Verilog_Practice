module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);
	
    // delcaration
    parameter A=3'b000,B=3'b001,C=3'b010,D=3'b011,E=3'b100,F=3'b101;
    reg [2:0] state,next;
    
    // state transition
    always @(*) begin
        case(state)
            A: next = w ? B : A;
            B: next = w ? C : D;
            C: next = w ? E : D;
            D: next = w ? F : A;
            E: next = w ? E : D;
            F: next = w ? C : D;
            
        endcase
    end
    
    // state flip-flop
    always @(posedge clk) begin
        if(reset)
            state <= A;
        else 
            state <= next;
    end
    
    // output logic
    assign z = (state == E) | (state == F);
endmodule
