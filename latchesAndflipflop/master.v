odule dlatch(d, enable, q, notq);
  input d, enable;         
  output q, notq;         
  wire d0,d1, notd;     
   
  not m1(notd,d);	
  
  nand m2(d0, d, enable);    
  nand m3(d1, notd, enable); 
  nand m4(q, d0, notq);      
  nand m5(notq, d1, q);  

endmodule

module master(d,clk, q);
input d,clk;
output q;
wire q1,clk1;
not n1(clk1,clk);

dlatch m1(d,clk,q1);
dlatch m2(q1,clk1,q);

endmodule
