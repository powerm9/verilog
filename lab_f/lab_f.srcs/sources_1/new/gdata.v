module gendata(input clock, output reg [7:0] gdata);

always@(negedge clock)
	gdata=gdata+1;
	
endmodule
