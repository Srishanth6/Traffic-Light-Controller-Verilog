`timescale 1ns/1ps
module traffic_light_controller_tb;

    // Inputs to DUT
    reg clk;
    reg reset;

    // Outputs from DUT
    wire NS_R;
    wire NS_Y;
    wire NS_G;
    wire EW_R;
    wire EW_Y;
    wire EW_G;
  // Instantiate the Design Under Test (DUT)
traffic_light_controller dut (
    .clk(clk),
    .reset(reset),

    .NS_R(NS_R),
    .NS_Y(NS_Y),
    .NS_G(NS_G),

    .EW_R(EW_R),
    .EW_Y(EW_Y),
    .EW_G(EW_G)
);
  // Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end
  // Test stimulus
initial begin

    // Start with reset active
    reset = 1;

    // Keep reset active for 20 ns
    #20;

    // Release reset
    reset = 0;

    // Allow the FSM to run
    #600;

    // End simulation
    $finish;
end
  // Waveform generation
initial begin
    $dumpfile("traffic_light_controller.vcd");
    $dumpvars(0, traffic_light_controller_tb);
end

endmodule
