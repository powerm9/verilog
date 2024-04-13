module sequencer_tb;

// Parameters
parameter CLK_PERIOD = 10; // Clock period in ns

// Signals
reg clk;
reg rst_fsm;
reg sh_en;
reg rst_lfsr;
wire x;
wire [20:0] Q_out;
wire [20:0] count;
wire b;
wire max_tick_reg;

// Output signal
reg [20:0] validate, Q_out_prev;

// Instantiate the sequencer module
sequencer uut (
    .clk(clk), 
    .rst_fsm(rst_fsm), 
    .sh_en(sh_en), 
    .rst_lfsr(rst_lfsr), 
    .x(x), 
    .Q_out(Q_out), 
    .count(count), 
    .max_tick_reg(max_tick_reg)
);

// Clock generation
initial clk = 0; //start clock at 0
always #((CLK_PERIOD / 2)) clk = ~clk;

always @(posedge clk) begin
    Q_out_prev <= Q_out[10:0];
end

// Check condition for outputting a high value
always @(posedge clk) begin
    if (x && (Q_out_prev == 11'b11011111010)) begin
        validate = validate +1'b1;
    end          
end
        

// Initial stimulus
initial begin
    // Initialize inputs
    validate = 0;
    rst_fsm = 0;
    sh_en = 0;
    rst_lfsr = 1;

    // Apply reset for a few clock cycles
    #20 rst_fsm = 1;
    #20 rst_fsm = 0;

    // Apply test stimuli
    // You can add more test cases here
    #100;
    sh_en = 1; // Enable shifting
    #200;
    sh_en = 0; // Disable shifting
    #100;
    rst_lfsr = 0; // Reset LFSR
    #50;
    rst_lfsr = 1;
    #200;
    sh_en = 1;
    #21000000;
    sh_en = 0;
    #100
    // End simulation
    $finish;
end

endmodule