module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,	// delay [3:0]
    output counting,
    output done,
    input ack );
	
    // declaration
    parameter S=0, S1=1, S11=2, S110=3, B0=4, B1=5, B2=6, B3=7, Count=8, Wait=9;
    reg [3:0] state,next;
    reg [9:0] q;	// for 1000 counts
    wire done_counting;
    wire shift_ena;
    wire count_ena;
    
    // state transition
    always @(*) begin
        case (state)
            S	:	next = data	?	S1	:	S;
            S1	:	next = data	?	S11	:	S;
            S11	:	next = data	?	S11	:	S110;
            S110:	next = data	?	B0	:	S;
            B0	:	next = B1;
            B1	:	next = B2;
            B2	:	next = B3;
            B3	:	next = Count;
            Count:	next = done_counting ? Wait : Count;
            Wait:	next = ack	?	S	:	Wait;
        endcase
    end
        
    // instance
    shift_and_count U1 (clk, shift_ena, count_ena, data, count);
    count1k U2 (clk, ~counting, q);
    // state flip-flop
    always  @(posedge clk) begin
        if(reset)
            state <= S;
        else 
            state <= next;
    end
        
    // output logic
    assign shift_ena = (state == B0)|(state == B1)|(state == B2)|(state == B3);
    assign counting = (state == Count);
    assign done = (state == Wait);
        
    assign count_ena = counting & (q == 999);
    assign done_counting = (count == 0) & (q == 999);
    
endmodule

// module for shift and count
// Exams/review2015 shiftcount
module shift_and_count (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);
	
    always@(posedge clk) begin
        case({shift_ena,count_ena})
            2'b10:begin
                q <= {q[2:0],data};
            end
            2'b01:begin
                q <= q - 1'b1;
            end
            default: q <= q;
        endcase
    end

endmodule

// module for counting 1000
// Exams/review2015 count1k
module count1k (
    input clk,
    input reset,
    output [9:0] q);
	
    always@(posedge clk) begin
        if (reset)
            q <= 10'd0;
        else if (q == 999)
            q <= 10'd0;
        else
            q <= q + 10'd1;
    end
endmodule