`timescale 1ns / 1ps

module lfsr_tb; //instantiate testbench module

 reg clk, sh_en, rst_n; //registers for clock enable and reset
 wire [14:0] Q_out; //output for Q
 wire  max_tick_reg; //wire for max tick reg
 wire [14:0] msb_one, msb_zer;
 

 lfsr uut(.clk(clk), .sh_en(sh_en), .rst_n(rst_n), .Q_out(Q_out), .max_tick_reg(max_tick_reg), .msb_one(msb_one), .msb_zer(msb_zer)); //instantiate lfsr
 
 initial clk = 0; //start clock at 0
 always #10 clk = ~clk; //period of 20ns high every 10ns 
 
 initial begin //begin
    rst_n = 0; //reset set to 0 for first 10 cycles
    #100; 
    rst_n = 1; //then set to 1 

    
    sh_en = 1; //enable shifting
    
    #10000000; //wait for some time
    
    sh_en = 0; //turn it off 
    
    #100; //wait 10 cycles 
    
 $finish; //finish sim
 end 
      
    
endmodule
