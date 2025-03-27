module adddddder(s,c,a,b,c1);
   input a,b,c1;
   output s,c;
   wire d,e,f;
   xor(d,a,b);
   xor(s,d,c1);
   and(e,a,b);
   and(f,d,c1);
   or(c,f,e);


endmodule