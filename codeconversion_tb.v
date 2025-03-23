`timescale 1ns / 1ps

`include "codeconversion.v"

module codeconversion_tb;
    reg [3:0]bcd;
    wire [3:0]excess3;
    codeconversion dut(
        .a(bcd[3]),
        .b(bcd[2]),
        .c(bcd[1]),
        .d(bcd[0]),
        .w(excess3[3]),
        .x(excess3[2]),
        .y(excess3[1]),
        .z(excess3[0])
    );
    reg clk;  
    initial begin
        clk=0;
        forever #5 clk=~clk;
    end  
    initial begin
        $dumpfile("codeconversion_tb.vcd"); 
        $dumpvars(0, codeconversion_tb); 
    end
    reg[3:0]i;
    initial begin
    i = 0;
    end

    always @(posedge clk) begin
        bcd <= i;
        i = i + 1;
        if (i == 10) $finish;
    end

    initial begin
        $monitor("time=%g, BCD=%b, excess3=%b", $time, bcd, excess3);
    end

    // #200;
    // $finish;

endmodule