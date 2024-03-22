
module dff_tb;

reg test_rst, test_d, test_clk;
wire test_q;

clock m0(.CCLK(CCLK), .clkscale(1), .clk(test_clk));

d_ff_reset uut (.reset(test_rst), .clk(test_clk), .d(test_d), .q(test_q));

always #10 CCLK = ~CCLK;
    
initial begin
    
//test vector 1
test_rst = 1'b0;
test_d   = 1'b0;
#20;

$finish;
end 
      
endmodule
