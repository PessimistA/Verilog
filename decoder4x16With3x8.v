module decoderwith3s(a,d);
input [3:0]a;
output [15:0]d;
wire nota;
not n1(nota,a[3]);

decoder3x8 m1(a[2:0],a[3],d[7:0]); 
decoder3x8 m2(a[2:0],nota,d[15:8]); 
endmodule
