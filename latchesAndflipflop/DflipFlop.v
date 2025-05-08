module dFlipFlop(d, enable, q, notq);
  input d, enable;         
  output q, notq;         
  wire d0,d1, notd;     
   
  not m1(notd,d);	
  
  nand m2(d0, d, enable);    
  nand m3(d1, notd, enable); 
  nand m4(q, d0, notq);      
  nand m5(notq, d1, q);  

endmodule


//asenkron resetli
module DFF(Q, D, Clk, rst);
  input D, Clk, rst;
  output Q;
  reg Q;

  always @(posedge Clk or negedge rst)
    if (!rst)
      Q <= 1'b0;
    else
      Q <= D;

endmodule
//testbench resetli
module tb_DFF;
  reg D, Clk, rst;
  wire Q, notQ;

  DFF uut(Q, notQ, D, Clk, rst);

  initial begin
    $dumpfile("dff_tb.vcd");
    $dumpvars(0, tb_DFF);

    D = 0; Clk = 0; rst = 1;
    #5 rst = 0;  // apply reset
    #5 rst = 1;  // release reset
    #5 D = 1;
    #5 Clk = 1;
    #5 Clk = 0;
    #5 D = 0;
    #5 Clk = 1;
    #5 Clk = 0;
    #5 D = 1;
    #5 Clk = 1;
    #5 Clk = 0;
    #10 $finish;
  end

  always #2.5 Clk = ~Clk;  // Clock toggle every 2.5 time units

endmodule

//asenkron resetsiz
module D_FF(Q, D, Clk);
  input D, Clk;
  output Q;
  reg Q;

  always @(posedge Clk)
    Q <= D;

endmodule

/testbench resetsiz
module tb_D_FF;
  reg D, Clk;
  wire Q;

  D_FF uut(Q, D, Clk);

  initial begin
    $dumpfile("d_ff_tb.vcd");
    $dumpvars(0, tb_D_FF);

    D = 0; Clk = 0;
    #5 D = 1;
    #5 Clk = 1;
    #5 Clk = 0;
    #5 D = 0;
    #5 Clk = 1;
    #5 Clk = 0;
    #5 D = 1;
    #5 Clk = 1;
    #5 Clk = 0;
    #10 $finish;
  end

  always #2.5 Clk = ~Clk;  // Clock toggle every 2.5 time units

endmodule

//basic one 
module dflipflopnormal1(input d, output q, output q1);

or (q1,d);

endmodule
//uzun olan
module dflipflopnormal2(input d, input clk, output reg q, output q1);

or (q1,d);

    initial begin
        q = 0;#10; 
        q = 1;#10; 
        q = 0;#10; 
        q = 1;#10; 

    end
    always @(posedge clk) begin
        case ({d})
            1'b0: q <= d;        // Set
            1'b1: q <= d;     // Illegal state
        endcase
    end
endmodule
module dflipflop_tb1;
    reg d,clk;
    wire q1;
    wire q;

    dflipflopnormal2 uut ( .d(d), .clk(clk), .q(q), .q1(q1));

    // Clock üretimi
    initial begin
        clk = 0;
        forever #10 clk = ~clk;    // 10 birim periyot
    end

    // s ve r’yi pattern şeklinde ilerlet
    initial begin
        d = 0;#10; 
        d = 0;#10; 
        d = 1;#10; 
        d = 1;#10; 
        $stop;
    end
endmodule

//gecikmeli answer veren sanırım bu doğru
module dflipflopnormal2(input d, input clk,  output reg q1);
    initial q1 = 0;  // <-- BURAYI EKLEDİK
    always @(posedge clk) begin
        case ({d,clk})
            2'b00: q1 <= d;        // Set
            2'b01: q1 <= d;  
            2'b10: q1 <= d; 
            2'b11: q1 <= d;    // Illegal state
        endcase
    end
endmodule
module dflipflop_tb1;
    reg d,clk;
    wire q1;


    dflipflopnormal2 uut ( .d(d), .clk(clk), .q1(q1));

    // Clock üretimi
    initial begin
        clk = 0;
        forever #10 clk = ~clk;    // 10 birim periyot
    end

    // s ve r?yi pattern ?eklinde ilerlet
    initial begin
        d = 0;#20; 
        d = 0;#20; 
        d = 1;#20; 
        d = 1;#20; 
        $stop;
    end
endmodule
