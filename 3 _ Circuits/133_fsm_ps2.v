module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
	
    parameter byte1=2'b00,byte2=2'b01,byte3=2'b10,byte4=2'b11;
    reg [1:0 ]state,next;
    // State transition logic (combinational)
    always @(*) begin
        case(state)
            byte1: next = in[3]?byte2:byte1;
            byte2: next = byte3;
            byte3: next = byte4;
            byte4: next = in[3]?byte2:byte1;
        endcase
    end
    // State flip-flops (sequential)
    always @(posedge clk) begin
        if(reset)
            state <= byte1;
        else
            state <= next;
    end
    // Output logic
    assign done = (state == byte4);
endmodule
