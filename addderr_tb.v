`timescale 1ns/1ps

`include "adder.v"

module addderr_tb;
   reg a,b,c1;
   wire s,c,d,e,f;

   adddddder uut (
      .s(s),
      .c(c),
      .a(a),
      .b(b),
      .c1(c1)
   );
   initial begin
      a = 1'b0;
      b = 1'b0;
      c1 = 1'b0;
      #2 a = 1'b0; b = 1'b1; c1 = 1'b0; 
      #2 a = 1'b1; b = 1'b0; c1 = 1'b1;
      #2 a = 1'b1; b = 1'b1; c1 = 1'b0;
      #2 a = 1'b0; b = 1'b1; c1 = 1'b1;
      #2 a = 1'b1; b = 1'b0; c1 = 1'b0;
      #2 a = 1'b1; b = 1'b1; c1 = 1'b1;

   end



   initial begin
      $dumpfile("addderr_tb.vcd");  
      $dumpvars(0, addderr_tb); 
   end

   // Monitor signal values and add enough time for the VCD file to be generated or we can comment it out if donot want to see it in terminal
   initial begin
      $monitor("time=%g, s=%b, c=%b, a=%b, b=%b", $time, s, c, a, b);
      #50; 
      $finish;  // End the simulation
   end 

endmodule

