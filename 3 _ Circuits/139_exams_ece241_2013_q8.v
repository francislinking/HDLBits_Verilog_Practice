module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
	
    // declaration 
    parameter S0 = 2'b00,S1 = 2'b01,S2 = 2'b10,S3 = 2'b11;
    reg [1:0] state,next;
    
    // state transition
    always @(*) begin
        case(state)
            S0: next = x? S1: S0;
            S1: next = x? S1: S2;
            S2: next = x? S3: S0;
            S3: next = x? S1: S2;
        endcase
    end
    //state flip-flop
    always @(posedge clk,negedge aresetn) begin
        if(~aresetn)
            state <= S0;
        else
            state <= next;
    end
    
    // outpu logic
    assign z = x&(state == S2);
endmodule
