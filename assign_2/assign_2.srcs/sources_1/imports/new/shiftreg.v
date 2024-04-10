`timescale 1ns / 1ps

module lfsr
    #(parameter seed = 21'h164057) //seed value calculation shown in report // 2^ 15 - 1 = 32767
    (
    input clk, sh_en, rst_n, //define clock enable and reset inputs
    output [20:0] Q_out,     //define Q output
    output reg max_tick_reg,  //define value for measuring when lfsr has ran whole way through
    output reg [20:0] msb_one, msb_zer
    ); 
    
    reg  [20:0] Q_state; //state reg for holding value 
    wire [20:0] Q_ns;   //holds next state of lfsr
    
    reg  [20:0] count_r;  //state reg for counter for max tick register
    wire [20:0] count;  //count output
    wire [20:0] count_n; //next counter number holder
    clock m0(.CCLK(clk), .clkscale(50000000), .clk(clock));
    
    always @ (posedge clock) begin //do these instructions at rising edge of clock
        if (!rst_n) begin        //if reset is not right value
            Q_state <= seed;     //initialize lfsr with seed value
            count_r <= 0;       //counter reg set to 0
            max_tick_reg <= 0;  //max reg set to 0
        end
        
        else if (sh_en) begin  //if shift enable high
            Q_state <= Q_ns;   //q_state is the next state
             count_r <= count_n;//count register set to next value
                if (count == 21'h1FFFFE) begin  //check if counter has reached max value
                    max_tick_reg <= 1;        //if it has max tick set to 1 
                    count_r <= 0;               //set coutner back to 0
                end 
                else begin
                max_tick_reg <= 0;        //but only for 1 clock cycle
                end        
        end    
    end 
    
    assign count_n = count_r + 1'b1;        //calculate next value 
    assign count = count_r;                 //set count output as the count register value
    
    assign Q_fb = (Q_state[20] ^ Q_state[18]); //tap 21, 19 funnelled to feedback 
    assign Q_ns = {Q_state[19:0], Q_fb};        //next value calculated from feedback and state value (seed at beginning)
    assign Q_out = Q_state;                     //assign the output
    
endmodule
