//birleştiren kod
module five2x1decoders(a,en,d);
input [3:0]a;
input en;
output [15:0]d;
wire [3:0]w;

decoder2x4withen m1(a[3:2],en,w[3:0]);
decoder2x4withen m2(a[1:0],w[0],w[6:4]);
decoder2x4withen m3(a[1:0],w[1],w[9:7]);
decoder2x4withen m4(a[1:0],w[2],w[12:10]);
decoder2x4withen m5(a[1:0],w[3],w[15:13]);



endmodule

//decoder 2x4 with enable
module decoder2x4withen(a,en,d);
input [1:0]a;
input en;
output [3:0]d;

wire nota1, nota0;

not n1(nota0, a[0]);
not n2(nota1, a[1]);


and a1(d[0],en ,nota1, nota0);
and a2(d[1],en ,nota1, a[0]);  
and a3(d[2],en ,a[1], nota0); 
and a4(d[3],en ,a[1], a[0]);  

endmodule

NOT: give enable min value as 1 
