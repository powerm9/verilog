`timescale 1ns / 1ns

module dff_tb; //module declaration

    reg test_rst, test_d;
    wire test_q;
    reg CCLK;



    // Toggle CCLK to generate clock
    initial CCLK = 0;
    always #10 CCLK = ~CCLK; // Toggle CCLK every 10 time units 20ns period


    d_ff_reset uut (.reset(test_rst), .clock(CCLK), .d(test_d), .q(test_q)); //instantiate unit under test
    
    initial begin //begin timings for d input
    test_d = 1'b0;
    #30;
    test_d = 1'b1;
    #25;
    test_d = 1'b0;
    #25;
    test_d = 1'b1;
    #100;
    test_d = 1'b0;
    #50;
    
    end
    
    initial begin //begin timings for rst

    // Initialize inputs
    test_rst = 1'b1;
    #45;
    test_rst = 1'b0;
    #80;
    test_rst = 1'b1;
    #30;
    test_rst = 1'b0;
    #50;
    
    // Stop the simulation
//        $finish;
    $finish;
    end 

endmodule