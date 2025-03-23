`timescale 1ns/1ps

module comparator(a,b,c,d,f,g,h,j,r,s,t,u,equal,agreater,bgreater);
input a,b,c,d,f,g,h,j;
output r,s,t,u,equal,agreater,bgreater;
// wire ;
assign r=~(d^j);
assign s=~(c^h);
assign t=~(b^g);
assign u=~(a^f);
assign equal=((r&s)&t)&u;
assign agreater=d&(~j) | r&(c&(~h)) | s&(b&(~g)) | t&(a&(~f)); 
assign bgreater=j&(~d) | r&(h&(~c)) | s&(g&(~b)) | t&(f&(~a));

endmodule