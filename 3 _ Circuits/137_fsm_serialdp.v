module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Modify FSM and datapath from Fsm_serialdata
    parameter [3:0] idle = 4'ha,start = 4'hb,stop = 4'hc,err=4'hd,odd_check=4'he;
    parameter [3:0] d0=4'h0,d1=4'h1,d2=4'h2,d3=4'h3,d4=4'h4,d5=4'h5,d6=4'h6,d7=4'h7;

    reg [3:0] state,next;
    reg [7:0] rcv;
    
    always @(posedge clk)begin
        if(reset)
            state <= idle;
        else
            state <= next;
        
		case(next)
            d0: 	rcv <= {in,rcv[7:1]};
            d1: 	rcv <= {in,rcv[7:1]};
            d2: 	rcv <= {in,rcv[7:1]};
            d3: 	rcv <= {in,rcv[7:1]};
            d4: 	rcv <= {in,rcv[7:1]};
            d5:		rcv <= {in,rcv[7:1]};
            d6:		rcv <= {in,rcv[7:1]};
            d7: 	rcv <= {in,rcv[7:1]};
            default: rcv <= rcv;
        endcase
    end
    
    always @(*)begin
        case(state)
            idle: 		next = (~in)? start : idle;
            start:		next = d0;
            d0: 		next = d1;
            d1: 		next = d2;
            d2: 		next = d3;
            d3: 		next = d4;
            d4: 		next = d5;
            d5:			next = d6;
            d6:			next = d7;
            d7: 		next = (odd^in)	? odd_check : err ; // XOR the odd of input byte and parity bit, confirm odd parity
            odd_check:	next = in 		? stop		: err ; // high end bit
            stop: 		next = (~in)	? start 	: idle;
            err:  		next = (~in)	? err		: idle;
            default: next = idle;
        endcase
    end
    
    // New: Datapath to latch input bits.
	assign done = (state == stop);
    assign out_byte = done ? rcv : 8'bx;
    // New: Add parity checking.
	
    // record odd of the input 8 bytes [7:0] 
    wire odd;
    parity parity1(
        .clk(clk),
        .reset(state == idle),	// reset when idle
        .in(in),
        .odd(odd));
endmodule
