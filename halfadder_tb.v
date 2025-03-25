`timescale 1ns/1ps
`include "halfadder.v"

module halfadder_tb;
   reg a;
   reg b;
   
   wire s;
   wire c;

   // Instantiating the halfadder module
   halfadder uut (
      .s(s),
      .c(c),
      .a(a),
      .b(b)
   );

   // Stimulus
   initial begin
      a = 1'b0;
      b = 1'b0;
      #2 a = 1'b0; b = 1'b1;
      #2 a = 1'b1; b = 1'b0;
      #2 a = 1'b1; b = 1'b1;
   end

   // Dump VCD file
   initial begin
      $dumpfile("halfadder_tb.vcd");  // Set the VCD file name
      $dumpvars(0, halfadder_tb);     // Dump all variables in the top module
   end

   // Monitor signal values and add enough time for the VCD file to be generated
   initial begin
      $monitor("time=%g, s=%b, c=%b, a=%b, b=%b", $time, s, c, a, b);
      #10;  // Provide enough time for the VCD file to be written
      $finish;  // End the simulation
   end
endmodule


