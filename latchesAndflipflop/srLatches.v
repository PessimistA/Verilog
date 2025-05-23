//nand gate
module srlatchesnand(s,r,q,notq);
input s,r;
output q,notq;
nand m2(notq,s,q);
nand m1(q,r,notq);

endmodule

//nor gate
module srlatches(s,r,q,notq);
input s,r;
output q,notq;

nor m1(q,r,notq);
nor m2(notq,s,q);

endmodule

//testBench
module testBench;
  reg s, r;
  wire q_nor, notq_nor;
  wire q_nand, notq_nand;

  srlatches      uut(s, r, q_nor, notq_nor);       // NOR SR latch
  srlatchesnand  uub(s, r, q_nand, notq_nand);     // NAND SR latch

  initial begin
    $monitor("Time=%0t | S=%b R=%b || NOR: Q=%b notQ=%b || NAND: Q=%b notQ=%b", 
              $time, s, r, q_nor, notq_nor, q_nand, notq_nand);

    s = 0; r = 0; #10;
    s = 1; r = 0; #10;
    s = 0; r = 1; #10;
    s = 0; r = 0; #10;
    s = 1; r = 1; #10;

    $finish;
  end
endmodule

//enable kodu
module srlatchesenable(s, r, enable, q, notq);
  input s, r, enable;     
  output q, notq;         
  wire s2,r2;   

  nand (s2, s, enable);  
  nand (r2, r, enable);   
  nand (q, s2, notq);  
  nand (notq, r2, q);   

endmodule
//test bench for the enable
module testBench;
  reg s, r, enable;
  wire q, notq;

  srlatchesenable uut(s, r, enable, q, notq);  // SR latch with enable

  initial begin
    $monitor("Time=%0t | S=%b R=%b Enable=%b || Q=%b notQ=%b", 
             $time, s, r, enable, q, notq);

    // Başlangıç durumu
    s = 0; r = 0; enable = 1; #10;

    // Set durumu
    s = 1; r = 0; enable = 1; #10;

    // Reset durumu
    s = 0; r = 1; enable = 1; #10;

    // Hold durumu
    s = 0; r = 0; enable = 1; #10;

    // Enable = 0, çıkışlar değişmemeli
    s = 1; r = 1; enable = 0; #10;

    // Enable tekrar 1, çıkışlar güncellenmeli
    enable = 1; #10;

    // Testi bitir
    $finish;
  end
endmodule


