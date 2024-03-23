`timescale 1ns / 1ps
module clock_tb;

    reg CCLK;
    reg [31:0] clkscale;
    
    wire clk;
    clock uut (.CCLK(CCLK), .clkscale(clkscale), .clk(clk));
    
//    always #(1) CCLK = ~CCLK;
    
    initial begin
//    clk = 0;
    CCLK = 0;
    clkscale = 1;
    
    #100
    
    $finish;
    end
     
endmodule
