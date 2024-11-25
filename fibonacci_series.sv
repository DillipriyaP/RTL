`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2024 12:16:06
// Design Name: Dillipriya P
// Module Name: fibonacci_series
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
// To use the below code to system verilog just replace integer with int even though its an integer it will work.
// By changing the ZERO_VALUE and FIRST_VALUE values we can generate Fibinacci series or Lucas number series.
// Since series will go infinite number we can limit the series as per requirement so that 
// utilization of resources will be limited and series can be stopped.
// As per the number of series we can decide the width required at the output side.
////////////////////////////////////////////////////////////////////////////////


module fibonacci_series #(
parameter integer ZERO_VALUE = 0,
parameter integer FIRST_VALUE = 1,
parameter MAX_VALUE_SERIES = 24,
parameter WIDTH = 16
)
(
 input clk,
 input reset_n,
 output reg [WIDTH - 1:0]fibonacci_series,
 output reg led_on
);
localparam integer Inc_Width = $clog2(MAX_VALUE_SERIES);
reg [WIDTH-1:0]fibonacci_series_i[MAX_VALUE_SERIES-1:0];
reg [Inc_Width-1:0]fibonacci_index;
reg [Inc_Width-1:0]fibonacci_index_reg;
reg [Inc_Width-1:0]fibonacci_incr;
integer i;
always@(posedge clk)begin
    if(~reset_n)begin
    //At the reset condition all the internal registers must has to be 
    //zero for proper functioning to avoid going to the unknown states.
        for( i= 0; i < MAX_VALUE_SERIES; i = i+1)begin
            fibonacci_series_i[i] <= 16'd0;
        end
        fibonacci_incr = 0;
    end else begin
        // Assogning zeroth value to the zero sequence and first value to the first sequence.
        fibonacci_series_i[0]<= ZERO_VALUE;
        fibonacci_series_i[1]<= FIRST_VALUE;
        // Except for zeosth and 1st value series equation to get 
        //nth fibonacci series will  be F(n) = F(n-1)+F(n-1)
        if(fibonacci_incr >1)begin
            fibonacci_series_i[fibonacci_incr]<= fibonacci_series_i[fibonacci_incr - 1] + fibonacci_series_i[fibonacci_incr - 2];
        end
        // Incrementing the index value for storing new sequence value in a memory F(n)
        fibonacci_incr <= fibonacci_incr + 1;
    end
end
// Assiging calculated series ti the output at every clock.
always@(posedge clk)begin
    if(~reset_n)begin
        fibonacci_series <= 0;
        fibonacci_index <= 0;
        fibonacci_index_reg <= 0;
    end else begin
        if(fibonacci_index == MAX_VALUE_SERIES-1)begin
            fibonacci_index <= 0;
            led_on <= 1'b1;
        end else begin
            fibonacci_index <= fibonacci_index+1;
            led_on <= 1'b0;
        end
        fibonacci_series <= fibonacci_series_i[fibonacci_index_reg];
        //incrementing the index value for providing new value in the sequence.
        fibonacci_index_reg <= fibonacci_index;
    end
end
endmodule
