//full adder with 2 half adder
module fulladderwithdecoder(x,y,z,c,s);

input x,y,z;
output c,s;
wire w1,w2,w3;

halfadderdecoder h1(x,y,w1,w2);

halfadderdecoder h2(w2,z,w3,s );

or m1(c,w3,w1);

endmodule

//half adder 
module halfadderdecoder(a,b,c,s);
input a,b;
output c,s;
wire [3:0]d;

wire nota, notb;

not n1(nota, a);
not n2(notb, b);

and a1(d[0], nota, notb);
and a2(d[1], nota, b);  
and a3(d[2], a, notb); 
and a4(d[3], a, b);  

or r1(s,d[1],d[2]);
or r2(c,d[3]);

endmodule
