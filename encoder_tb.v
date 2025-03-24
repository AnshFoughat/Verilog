`timescale 1ns / 1ps
`include "encoder.v"
module encoder_8to3_tb;

  reg [7:0] in_data;
  wire [2:0] out_data;

  // Instantiate the encoder module
  encoder_8to3 uut (
    .in_data(in_data),
    .out_data(out_data)
  );

  // Test scenarios
  initial begin
    $dumpfile("encoder_tb.vcd"); // For waveform viewing
    $dumpvars(0, encoder_8to3_tb);

    $display("Time\t Input\t Output");
    $monitor("%0t\t %b\t %b", $time, in_data, out_data);

    // Test all positions with a single bit set
    in_data = 8'b00000001; #10;
    in_data = 8'b00000010; #10;
    in_data = 8'b00000100; #10;
    in_data = 8'b00001000; #10;
    in_data = 8'b00010000; #10;
    in_data = 8'b00100000; #10;
    in_data = 8'b01000000; #10;
    in_data = 8'b10000000; #10;

    // Test an invalid case (multiple bits set)
    in_data = 8'b00001100; #10;

    // Finish simulation
    $finish;
  end

endmodule
