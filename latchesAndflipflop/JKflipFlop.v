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

//long version
module jkflipflopnormal1(input j, input k, input clk, output reg q, output q1);
    wire k1, w1, w2,q2;
    not n2(q2,q);
    not n1(k1, k);
    and m2(w1, q2, j);
    and m1(w2, k1, q);
    or m3(q1, w1, w2);

    initial begin
        q = 0;#10; 
        q = 1;#10; 
        q = 0;#10; 
        q = 1;#10; 
        q = 0;#10; 
        q = 1;#10; 
        q = 0;#10; 
        q = 1;#10; 
    end
    always @(posedge clk) begin
        case ({j, k})
            2'b10: q <= 1;        // Set
            2'b01: q <= 0;        // Reset
            2'b00: q <= q;        // Hold
            2'b11: q <= q2;     // Illegal state
        endcase
    end
endmodule
module jkflipflop_tb1;
    reg j, k, clk;
    wire q1;
    wire q;

    jkflipflopnormal1 uut (.j(j), .k(k), .clk(clk), .q(q), .q1(q1));

    // Clock üretimi
    initial begin
        clk = 0;
        forever #10 clk = ~clk;    // 10 birim periyot
    end

    // s ve r’yi pattern şeklinde ilerlet
    initial begin
        j = 0; k = 0; #10;  // 0000
        j = 0; k = 0; #10;
        j = 0; k = 1; #10;  // 00, 11
        j = 0; k = 1; #10;
        j = 1; k = 0; #10;  // 11, 00
        j = 1; k = 0; #10;
        j = 1; k = 1; #10;  // 11, 11
        j = 1; k = 1; #10;

        $stop;
    end
endmodule


//basit hali
module jkflipflopnormal12(input j, input k, input clk, output reg q, output q1);
    wire k1, w1, w2,q2;
    not n2(q2,q);
    not n1(k1, k);
    and m2(w1, q2, j);
    and m1(w2, k1, q);
    or m3(q1, w1, w2);

endmodule
