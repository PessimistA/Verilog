module fourmult(I,s, f);
input [3:0] I;
input [1:0] s;
output f;
wire w0, w1, w2, w3;
wire nsel0, nsel1;

not (nsel0, s[0]);
not (nsel1, s[1]);

and (w0, I[0], nsel1, nsel0); 
and (w1, I[1], nsel1, s[0]); 
and (w2, I[2], s[1], nsel0);
and (w3, I[3], s[1], s[0]); 

or (f, w0, w1, w2, w3);
endmodule
