`timescale 1ns/1ps
`include "paritybitgenerator.v"

module paritybitgenerator_tb;
    reg [3:0]bits;
    wire parityout;
    paritybitgenerator dut(
        .a(bits[3]),
        .b(bits[2]),
        .c(bits[1]),
        .d(bits[0]),
        .p(parityout)
    );
    reg clk;  
    initial begin
        clk=0;
        forever #5 clk=~clk;
    end  
    initial begin
        $dumpfile("paritybitgenerator_tb.vcd"); 
        $dumpvars(0, paritybitgenerator_tb); 
    end
    reg[3:0]i;
    initial begin
    i = 0;
    end

    always @(posedge clk) begin
        bits <= i;
        i = i + 1;
        if (i == 10) $finish;
    end

    // initial begin
    //     $monitor("time=%g, bits=%b, parityout=%b", $time, bits, parityout);
    // end

endmodule