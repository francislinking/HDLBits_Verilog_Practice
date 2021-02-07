module top_module (
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
