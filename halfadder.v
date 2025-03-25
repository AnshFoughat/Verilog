module halfadder(s,cout,a,b,cin);
wire t1,t2,k;
input a,b,cin;
output s,cout;
xor (s,a,b,cin);
and (t1,a,b);
and (cout,t1,t2);

endmodule