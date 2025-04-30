module twomulti(s,en,f);
input [1:0]s;
input en;
output f;
wire en1,w1,w2;

not g1(en1,en);
and g2(w1,en1,s[0]);
and g3(w2,en,s[1]);
or g4(f,w1,w2);
endmodule
