module decoder3x8(a,en,d);
input [2:0]a;
input en;
output [7:0]d;
wire nota0, nota1, nota2;
wire e0, e1, e2, e3, e4, e5, e6, e7;

not n0(nota0, a[0]);
not n1(nota1, a[1]);
not n2(nota2, a[2]);

and m1(d[0], en,nota2, nota1, nota0); 
and m2(d[1], en,nota2, nota1, a[0]);  
and m3(d[2], en,nota2, a[1],  nota0); 
and m4(d[3], en,nota2, a[1],  a[0]); 
and m5(d[4], en,a[2],  nota1, nota0); 
and m6(d[5], en,a[2],  nota1, a[0]); 
and m7(d[6], en,a[2],  a[1],  nota0); 
and m8(d[7], en,a[2],  a[1],  a[0]);  

endmodule
