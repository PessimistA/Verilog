module fulladderdecoder4x16(a,s,c,c1);
input [3:0]a;
output s,c,c1;
wire [15:0]d;
wire na0, na1, na2,na3;

not n0(na0, a[0]);
not n1(na1, a[1]);
not n2(na2, a[2]);
not n3(na3, a[3]);

and (d[0],  na3, na2, na1, na0);  
and (d[1],  na3, na2, na1,  a[0]);
and (d[2],  na3, na2,  a[1], na0);
and (d[3],  na3, na2,  a[1],  a[0]);
and (d[4],  na3,  a[2], na1, na0);
and (d[5],  na3,  a[2], na1,  a[0]);
and (d[6],  na3,  a[2],  a[1], na0);
and (d[7],  na3,  a[2],  a[1],  a[0]);
and (d[8],   a[3], na2, na1, na0);
and (d[9],   a[3], na2, na1,  a[0]);
and (d[10],  a[3], na2,  a[1], na0);
and (d[11],  a[3], na2,  a[1],  a[0]);
and (d[12],  a[3],  a[2], na1, na0);
and (d[13],  a[3],  a[2], na1,  a[0]);
and (d[14],  a[3],  a[2],  a[1], na0);
and (d[15],  a[3],  a[2],  a[1],  a[0]); 

or r1(s, d[1], d[2], d[4], d[7], d[8], d[11], d[13], d[14],d[15]);
or r2(c, d[3], d[5], d[6], d[7], d[9], d[10], d[11], d[12], d[13], d[14], d[15]);
or r3(c1,d[15]);

endmodule
