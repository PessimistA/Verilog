//fulladder kodu
module fulladder3x8decoder(a,b,c_in,c,s);

input a,b,c_in;
output s,c;
wire [7:0]d;
wire nota, notb, notc;

not n0(nota, a);
not n1(notb, b);
not n2(notc, c_in);

and m1(d[0], nota, notb, notc); 
and m2(d[1], nota, notb, c_in);  
and m3(d[2], nota, b,  notc); 
and m4(d[3], nota, b,  c_in); 
and m5(d[4], a,  notb, notc); 
and m6(d[5], a,  notb, c_in); 
and m7(d[6], a,  b,  notc); 
and m8(d[7], a,  b,  c_in);  

or m9(s,d[1],d[2],d[4],d[7]);
or m10(c,d[3],d[5],d[6],d[7]);

endmodule

//binary adder kodu
module binaryAdderwithdecoders(c,s,a,b,c_in);

input [3:0]a;
input  [3:0]b;
input c_in;
output [3:0]c;
output [3:0]s;


fulladder3x8decoder m1(a[0],b[0],c_int,c[0],s[0]);
fulladder3x8decoder m2(a[1],b[1],c[0],c[1],s[1]);
fulladder3x8decoder m3(a[2],b[2],c[1],c[2],s[2]);
fulladder3x8decoder m4(a[3],b[3],c[2],c[3],s[3]);


endmodule
