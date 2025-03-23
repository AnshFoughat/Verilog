`timescale 1ns/1ps

module codeconversion(a,b,c,d,w,x,y,z);
    input a,b,c,d;
    output w,x,y,z;
    assign x =(~b&c)|(~b&d) | (b&~c&~d);
    assign z=~d;
    assign y=(c&d) | (~c&~d);
    assign w = a | (b&c) | (b&d);

endmodule