`timescale 1ns / 1ps

module sequencer(
    input clk, 
    rst_fsm, 
    sh_en, 
    rst_lfsr, 
    output x, 
    output wire [20:0] Q_out, 
    output reg [20:0] count, 
    output wire max_tick_reg
);

//reg [20:0] Q_out_internal;
lfsr lfsr1(.clk(clk), .sh_en(sh_en), .rst_n(rst_lfsr), .Q_out(Q_out), .max_tick_reg(max_tick_reg));
fsm fsm1(.clk(clk), .rst(rst_fsm), .b(Q_out[0]), .x(x));
//clock clock1(.CCLK(clk), .clkscale(50000000), .clk(clk));



always @(posedge clk) begin
    if (!rst_lfsr) begin
        count <= 0;
    end    
    else if (x) begin
        count <= count + 1;
    end
end

endmodule
