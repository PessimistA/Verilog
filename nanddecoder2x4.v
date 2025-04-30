module nanddecoder2x4(a,d);
input [1:0]a;
output [3:0]d;

wire nota1, nota0;

not n1(nota0, a[0]);
not n2(nota1, a[1]);

nand a1(d[0], nota1, nota0);
nand a2(d[1], nota1, a[0]);  
nand a3(d[2], a[1], nota0); 
nand a4(d[3], a[1], a[0]);  

endmodule
