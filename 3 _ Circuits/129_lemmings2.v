module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
	
    // declaration
    parameter wl=2'b00,wr=2'b01,fl=2'b10,fr=2'b11;
    reg [1:0] state,next;
    
    // state transition logic
    always @(*) begin
        case(state)
            wl: begin
                if(~ground)			next = fl;
                else if(bump_left) 	next = wr;
                else 				next = wl;
            end
            wr:begin
                if(~ground)			next = fr;
                else if(bump_right) next = wl;
                else 				next = wr;
            end
            fl:begin
                if(ground)			next = wl;
                else 				next = fl;
            end
           	fr:begin
                if(ground)			next = wr;
                else 				next = fr;
            end
        endcase
    end
    
    // state flip-flops (DFF)
    always @(posedge clk, posedge areset) begin
        if(areset)
            state <=wl;
        else
            state <= next;
    end
    
    // output logic
	assign walk_left = (state == wl);
	assign walk_right = (state == wr);
    assign aaah = (state == fl)||(state == fr);
endmodule
