module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
	
    // delcaration
    parameter wl=3'b000,wr=3'b001,fl=3'b010,fr=3'b011,dl=3'b100,dr=3'b101,splat=3'b110;
    reg [2:0] state, next;
    reg [31:0] count;
    
    // state transition logic
    always @(*) begin
        case(state)
            wl:begin
                if(~ground)			next = fl;
                else if(dig)		next = dl;
                else if(bump_left)  next = wr;
                else				next = wl;
            end
            wr:begin
                if(~ground)			next = fr;
                else if(dig)		next = dr;
                else if(bump_right) next = wl;
                else				next = wr;
            end
            fl:begin
                if(ground) begin
                    if(count>19)    next = splat;
                    else            next = wl;
                end
                else 				next = fl;
            end
            fr:begin
                if(ground) begin
                    if(count>19)    next = splat;
                    else            next = wr;
                end
                else 				next = fr;
            end
            dl:begin
                if(~ground)			next = fl;
                else				next = dl;
            end
            dr:begin
                if(~ground)			next = fr;
                else				next = dr;
            end
            splat:begin
                					next = splat;
            end
        endcase
    end
    
    // state flip-flop DFF
    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= wl;
        else if(state == fl || state == fr) begin
            state <= next;
            count <= count + 1;
        end
        else begin
            state <= next;
            count <= 0;
        end
    end
    
    
    // output logical
    assign walk_left 	= (state == wl);
    assign walk_right 	= (state == wr);
    assign aaah 		= (state == fl)||(state == fr);
    assign digging 		= (state == dl)||(state == dr);
    
endmodule
