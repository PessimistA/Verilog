module dlatches(d, enable, q, notq);
  input d, enable;         
  output q, notq;         
  wire d2, notd;     
   
  not m1(notd,d);	
  
  nand m2(d2, d, enable);    
  nand m3(notd, notq, enable); 
  nand m4(q, d2, notq);      
  nand m5(notq, notd, q);  

endmodule

//test bench

module testBench;
  reg d, enable;
  wire q, notq;

  dlatchesenable uut(d, enable, q, notq);  // D latch with enable

  initial begin
    $monitor("Time=%0t | D=%b Enable=%b || Q=%b notQ=%b", 
             $time, d, enable, q, notq);

    // Başlangıç durumu
    d = 0; enable = 1; #10;

    // D = 1 durumu
    d = 1; enable = 1; #10;

    // Enable = 0, çıkışlar değişmemeli
    enable = 0; #10;

    // Enable = 1, D = 0 durumu
    d = 0; enable = 1; #10;

    // Enable = 0, çıkışlar değişmemeli
    enable = 0; #10;

    // Testi bitir
    $finish;
  end
endmodule
