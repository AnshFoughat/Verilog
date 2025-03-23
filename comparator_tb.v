`timescale 1ns/1ps

`include "comparator.v"

module comparator_tb;

    reg [3:0]A;
    reg [3:0]B;
    wire r,s,t,u;
    wire k,l,m;

    comparator dut(
        .a(A[0]),
        .b(A[1]),
        .c(A[2]),
        .d(A[3]),
        .f(B[0]),
        .g(B[1]),
        .h(B[2]),
        .j(B[3]),
        .equal(k),
        .agreater(l),
        .bgreater(m),
        .r(r),
        .s(s),
        .t(t),
        .u(u)
    );
    reg clk;
    initial begin
        clk=0;
        forever #5 clk=~clk;
    end
    initial begin
        A = 4'b1001; B = 4'b1000; #10;
        A = 4'b1001; B = 4'b1010; #10;
        A = 4'b1101; B = 4'b1100; #10;
        A = 4'b1011; B = 4'b1100; #10;
        A = 4'b1101; B = 4'b1100; #10;
        A = 4'b1111; B = 4'b1101; #10;
        A = 4'b1101; B = 4'b1110; #10;
    end
    initial begin
        $dumpfile("comparator_tb.vcd");  // Set the VCD file name
        $dumpvars(0, comparator_tb);     // Dump all variables in the top module
    end
    initial begin
        $monitor("time=%g,A=%b, B=%b, k=%b, l=%b, m=%b", $time,A,B, k, l, m);
        #200;  // Provide enough time for the VCD file to be written
        $finish;  // End the simulation
    end 


endmodule