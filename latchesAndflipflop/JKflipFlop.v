module JK_FF(J, K, Clk, Q, Q_b);
  input J, K, Clk;
  output Q, Q_b;
  wire jclk, kclk, nq, s, r;

  nand m1(jclk, J, Clk);
  nand m2(kclk, K, Clk);
  nand m3(s, jclk, nq);
  nand m4(r, kclk, Q);
  nand m5(Q, s, Q_b);
  nand m6(Q_b, r, Q);

endmodule
