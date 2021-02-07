module top_module (
	input [99:0] a,
	input [99:0] b,
	input cin,
	output cout,
	output [99:0] sum
);

	// The concatenation {cout, sum} is a 101-bit vector.
	assign {cout, sum} = a+b+cin;

    // my solution
    wire [100:0] sum_and_cout;
    assign sum_and_cout = a+b+cin;
    assign sum = sum_and_cout[99:0];
    assign cout = sum_and_cout[100];
endmodule
