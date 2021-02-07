module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
	
    //clock enable signal
    wire SecL_EN,SecH_EN,MinL_EN,MinH_EN,Hour_EN;
    assign SecL_EN = ena;
    assign SecH_EN = ena && (ss[3:0] == 4'h9);
    assign MinL_EN = ss == 8'h59;
    assign MinH_EN = (mm[3:0] == 4'h9)&&(ss == 8'h59);
    assign Hour_EN = (mm == 8'h59)&&(ss == 8'h59);
    
    //clock
    counter10	SecL	(clk,reset,SecL_EN,ss[3:0]);
    counter6	SecH	(clk,reset,SecH_EN,ss[7:4]);
    counter10	MinL	(clk,reset,MinL_EN,mm[3:0]);
    counter6	MinH	(clk,reset,MinH_EN,mm[7:4]);
    counter12	HourHL	(clk,reset,Hour_EN,hh[7:4],hh[3:0],pm);
   
endmodule

module counter10(
    input clk,
    input reset,
    input en,
    output [3:0] Q);

    always@(posedge clk)
    begin
        if(reset)				Q <= 4'b0000;
        else if(~en)			Q <= Q;
        else if(Q == 4'b1001)	Q <= 4'b0000;
        else					Q <= Q+1'b1;
    end
endmodule 

module counter6(
    input clk,
    input reset,
    input en,
    output [3:0] Q);

    always@(posedge clk)
    begin
        if(reset)				Q<=4'b0000;
        else if(~en)			Q<=Q;
        else if(Q == 4'b0101)	Q<=4'b0000;
        else					Q<=Q+1'b1;
    end
endmodule 


module counter12(
    input clk,
    input reset,
    input en,
    output [3:0] CntH,
    output [3:0] CntL,
	output pm);

    always@(posedge clk)
    begin
        if(reset) 
            begin {CntH,CntL}<=8'h12;pm <= 1'b0; end
        else if(~en)	
            {CntH,CntL}<={CntH,CntL};
        else if ( {CntH,CntL}==8'h12 )
            begin {CntH,CntL}<=8'h01; end
        else if(CntL ==9)
            begin CntH<=CntH+1'b1; CntL<=4'b0000;end
        else if ({CntH,CntL}==8'h11 )
            begin CntH<=CntH; CntL<=CntL+1'b1;pm <= ~pm; end
        else 
            begin CntH<=CntH; CntL<=CntL+1'b1;end
    end
    
endmodule 