`timescale 1ns/1ps

module paritybitgenerator(a,b,c,d,p);
    input a,b,c,d;
    output p;

    assign p=(((a^b)^c)^d);

endmodule