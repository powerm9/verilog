`timescale 1ns / 1ns

module dff_tb;

    reg test_rst, test_d;
    wire test_q;
    reg CCLK;
    reg clock;
//    wire clock; // Change reg to wire


    // Toggle CCLK to generate clock
    initial CCLK = 0;
    always #10 CCLK = ~CCLK; // Toggle CCLK every 5 time units
//    clock m0(.CCLK(CCLK), .clkscale(1), .clk(clock)); //scales CCLK outputs to clock

    d_ff_reset uut (.reset(test_rst), .clock(clock), .d(test_d), .q(test_q));

    initial begin

        // Initialize inputs
        
        test_rst = 1'b0;
        test_d   = 1'b1;
        
        // Simulate for some time
        #100;
        
        // Stop the simulation
        $finish;
    end 
      
endmodule