module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg[255:0] q );
    
    reg [255:0] update; // updated q
    reg [255:0] L,R,U,D,UL,UR,DL,DR; // neighbour
	integer i;
	
    // generate 8 neighbours [255:0], combinational logic circuit
    always@(*)begin
    	for(i=0;i<16;i=i+1)begin
		L[16*i +:16] = {q[16*i],q[16*i+1 +:15]};
        R[16*i +:16] = {q[16*i +:15],q[16*i+15]};
	end

        D = {q[15:0],q[255:16]};
        U = {q[239:0],q[255:240]}; 
        DL = {L[15:0],L[255:16]};
        UL = {L[239:0],L[255:240]};
        DR = {R[15:0],R[255:16]};
        UR = {R[239:0],R[255:240]};
    end
    
    // calculate updated q, combinational logic circuit
    always@(*) begin
 		for(i=0;i<256;i=i+1)begin
			if(R[i]+L[i]+D[i]+U[i]+DL[i]+DR[i]+UL[i]+UR[i] <= 1)
				update[i] = 1'b0;
			else if(R[i]+L[i]+D[i]+U[i]+DL[i]+DR[i]+UL[i]+UR[i] == 2)
				update[i] = q[i];
			else if(R[i]+L[i]+D[i]+U[i]+DL[i]+DR[i]+UL[i]+UR[i] == 3)
				update[i] = 1'b1;
			else
				update[i] = 1'b0;
        end
    end
    
    // load or update, sequential logic circuit
	always@(posedge clk)begin
        if(load)
            q <= data;
        else
            q <= update;
    end
    
endmodule