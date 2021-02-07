module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire lo_cout;
    add16 lo (a[15:0],b[15:0],0,sum[15:0],lo_cout);
    
    wire [15:0] hi_sum0,hi_sum1;
    add16 hi0 (a[31:16],b[31:16],0,hi_sum0[15:0]);
    add16 hi1 (a[31:16],b[31:16],1,hi_sum1[15:0]);
    
    always @(*)
        begin
            case(lo_cout)
                1'b0:sum[31:16] = hi_sum0[15:0];
                1'b1:sum[31:16] = hi_sum1[15:0];
            endcase
        end
endmodule
