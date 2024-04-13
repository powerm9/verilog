
module sequencer(
    input clk, 
    rst_fsm, 
    sh_en, 
    rst_lfsr, 
    output x, 
    output [3:0] anode_sel, 
    output [6:0] led_out, 
    output wire [10:0] led
);

reg [15:0] count;
clock clock1(.CCLK(clk), .clkscale(100000), .clk(clock));
lfsr lfsr1(.clk(clock), .sh_en(sh_en), .rst_n(rst_lfsr), .Q_out(led));
fsm fsm1(.clk(clock), .rst(rst_fsm), .b(led[0]), .x(x));
seven_segment_controller SS0(.clk(clk), .reset(rst_fsm), .count(count), .anode_select(anode_sel), .LED_out(led_out));


always @(posedge clock) begin
    if (!rst_lfsr || rst_fsm) begin
        count <= 0;
    end    
    else if (x) begin
        count <= count + 1;
    end
end

endmodule
