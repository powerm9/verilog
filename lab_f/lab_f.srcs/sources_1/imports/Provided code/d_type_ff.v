// Listing 4.2
`timescale 1ns / 1ps

module d_ff_reset
   (
    input wire clock, reset,
    input wire d,
    output reg q
   );
   
   // body
   always @(posedge clock, posedge reset)
      if (reset)
         q <= 1'b0;
      else
         q <= d;

endmodule