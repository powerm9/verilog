// Listing 4.2
`timescale 1ns / 1ps

module d_ff_reset //module declaration
   (
    input wire clock, reset,
    input wire d,
    output reg q
   );
   

   always @(negedge clock)begin //awlays block that runs at rising edge of the clock cycle and rising edge of the reset
      if (reset) //if reset is high
         q <= 1'b0; //q is 0
      else //if not high
         q <= d; //q is d
      end     
      
endmodule //end module