`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.11.2024 16:26:26
// Design Name: 
// Module Name: Fibonacci_series_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Fibonacci_series_TB(  );
parameter integer ZERO_VALUE = 0;
parameter integer FIRST_VALUE = 1;
parameter MAX_VALUE_SERIES = 24;
parameter WIDTH = 16;
 reg clk;
 reg reset_n;
 wire [WIDTH - 1:0]fibonacci_series;
 wire led_on;
 fibonacci_series #(
 .ZERO_VALUE(ZERO_VALUE),
 .FIRST_VALUE(FIRST_VALUE),
 .MAX_VALUE_SERIES(MAX_VALUE_SERIES),
 .WIDTH(WIDTH)
 )
 fibonacci_inst(
 .clk(clk),
 .reset_n(reset_n),
 .fibonacci_series(fibonacci_series),
 .led_on(led_on)
 );
 
 initial begin
    clk = 0;
    reset_n = 0;
    reset_task();
  end
  always #5 clk= ~clk;
 task automatic reset_task;
  begin
     reset_n <= 0;
     repeat(20) @(posedge clk);
     reset_n <= ~reset_n;
  end  
  endtask
  
endmodule
