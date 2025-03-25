`timescale 1ns/1ps

`include "trafficlightbyme1.v"

module trafficlightbyme1_tb;

// Declare testbench signals
reg clock, clear, X, B;
reg [4:0] hours;
reg [5:0] minutes;
reg [7:0] char;
wire is_true;
wire is_true1;
wire [1:0] hwy, country;


// Instantiate the main module
first uut (
    .hwy(hwy),
    .country(country),
    .X(X),
    .B(B),
    .clock(clock),
    .clear(clear),
    .hours(hours),
    .minutes(minutes),
    .char(char),
    .is_true(is_true),
    .is_true1(is_true1)
);

// Clock generation
initial begin
    clock = 0;
    forever #5 clock = ~clock; // 10ns clock period
end

// Stimulus
initial begin
    // Initialize inputs
        X = 0;
        B = 0;
        clock = 0;
        clear = 1;
        hours = 0;
        minutes = 0;
        char = 8'h00;

        // Wait for global reset
        #100;
        clear = 0;

        // Test case 1: 5:00 AM, no car on country road
        hours = 5;
        minutes = 0;
        X = 0;
        #10;
        $display("5:00 AM, no car on country: hwy=%b, country=%b", hwy, country);
        #100;
        // Test case 2: Detect car on country road during 5:00 AM to 9:00 PM
        X = 1;
        #10;
        $display("Car detected on country road: hwy=%b, country=%b", hwy, country);
        #100;
        X = 0;

        // Test case 3: 8:00 PM, no B signal
        hours = 20;
        minutes = 0;
        char = 8'h69;
        #10;
        $display("8:00 PM, no B signal: hwy=%b, country=%b", hwy, country);
        #100;

        // Test case 4: 9:01 PM, no car on country road, B = 0
        hours = 21;
        minutes = 1;
        X = 0;
        B = 0;
        #10;
        $display("9:01 PM, no B signal: hwy=%b, country=%b", hwy, country);
        #100;

        // Test case 5: 9:01 PM, B detects character 'a'
        char = 8'h61; // ASCII for 'a'
        B = 1;
        #10;
        $display("9:01 PM, B detects 'a': hwy=%b, country=%b, is_true=%b", hwy, country, is_true);
        #100;

        // Test case 6: B detects character not in ('a', 'b', 'c')
        char = 8'h64; // ASCII for 'd'
        #10;
        $display("9:01 PM, B detects 'd': hwy=%b, country=%b, is_true=%b", hwy, country, is_true);
        #100;
        B = 0;

        // Finish simulation
        #800;
        $stop;
end
    initial begin
        $dumpfile("trafficlightbyme1_tb.vcd");
        $dumpvars(0, trafficlightbyme1_tb);
    end
    initial begin
        $monitor("Time: %0d, hwy = %b, country = %b, X = %b, B = %b, clock = %b, clear = %b, hours = %b, minutes = %b, char = %b, is_true = %b, is_true1 = %b", $time, hwy, country, X, B, clock, clear, hours, minutes, char, is_true, is_true1);
    end
//     initial begin
//     $monitor("Time: %0d, hwy = %b, country = %b, X = %b, B = %b, clock = %b, clear = %b, hours = %b, minutes = %b, char = %b, char_is_true = %b", 
//              $time, hwy, country, X, B, clock, clear, hours, minutes, char, char_is_true);
// end


endmodule
