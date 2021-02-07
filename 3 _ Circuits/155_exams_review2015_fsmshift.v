module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
	
    reg [2:0] count;
    
    always @(posedge clk) begin
        if (reset)
            count <= 3'b000;
        else if (count == 3'b100)
            count <= count;
        else
            count <= count + 1'b1;
    end

    assign shift_ena = (~reset) & (~count[2]) | reset;
    
endmodule
