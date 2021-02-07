module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
	parameter byte1=2'b00,byte2=2'b01,byte3=2'b10,byte4=2'b11;
    reg [1:0 ] state,next;
    reg [23:0] temp;
    
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
        else if(state == byte1 | state == byte4)
            begin state <= next; temp = {16'b0,in}; end
        else if(state == byte2 | state == byte3)
            begin state <= next; temp = {temp[15:0],in}; end   
    end
    
    // Output logic
    assign done = (state == byte4);
    
    // New: Datapath to store incoming bytes.
	assign out_bytes = done ? temp : 24'bx;
endmodule
