
module controller(
    input clk,
    input reset,
    input [4:0] button_input,
    output [3:0] anode_sel,
    output [6:0] led_out
   );
   
  //instantiate 8 version of the DFF
  reg  [7:0]Q_next, Q_reg;
  wire [7:0]Q;
  wire [4:0] buttons;

  d_ff_reset DFF0(.clk(clk), .reset(reset), .d(Q_next[0]), .q(Q[0]));
  d_ff_reset DFF1(.clk(clk), .reset(reset), .d(Q_next[1]), .q(Q[1]));
  d_ff_reset DFF2(.clk(clk), .reset(reset), .d(Q_next[2]), .q(Q[2]));
  d_ff_reset DFF3(.clk(clk), .reset(reset), .d(Q_next[3]), .q(Q[3]));
  
  d_ff_reset DFF4(.clk(clk), .reset(reset), .d(Q_next[4]), .q(Q[4]));
  d_ff_reset DFF5(.clk(clk), .reset(reset), .d(Q_next[5]), .q(Q[5]));
  d_ff_reset DFF6(.clk(clk), .reset(reset), .d(Q_next[6]), .q(Q[6]));
  d_ff_reset DFF7(.clk(clk), .reset(reset), .d(Q_next[7]), .q(Q[7]));
  
  debouncer DB0(.clk(clk), .reset(reset), .button_in(button_input), .button_out(buttons)); 
  seven_segment_controller SS0(.clk(clk), .reset(reset), .temp(Q), .anode_select(anode_sel), .LED_out(led_out));
  

 always @(posedge clk)
 begin
    
    if(buttons[0] | buttons[3]) begin
        Q_next = Q;
        Q_next = Q + 1'b1;
    end    
    if(buttons[2] | buttons[1]) begin
        Q_next = Q;
        Q_next = Q_next - 1'b1;
    end
    if (buttons[4]) begin
        Q_next = 8'd22;
    end
    if (reset) begin
       Q_next = 8'd0;
    end
end
endmodule
