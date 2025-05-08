module srflipflopnormal1(input s, input r, input clk, output reg q, output q1);
    wire r1, w1, w2;

    not n1(r1, r);
    and m2(w1, r1, s);
    and m1(w2, r1, q);
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
        case ({s, r})
            2'b10: q <= 1;        // Set
            2'b01: q <= 0;        // Reset
            2'b00: q <= q;        // Hold
            2'b11: q <= 1'bx;     // Illegal state
        endcase
    end
endmodule
module srflipflop_tb1;
    reg s, r, clk;
    wire q1;
    wire q;

    srflipflopnormal1 uut (.s(s), .r(r), .clk(clk), .q(q), .q1(q1));

    // Clock üretimi
    initial begin
        clk = 0;
        forever #10 clk = ~clk;    // 10 birim periyot
    end

    // s ve r’yi pattern şeklinde ilerlet
    initial begin
        s = 0; r = 0; #10;  // 0000
        s = 0; r = 0; #10;
        s = 0; r = 1; #10;  // 00, 11
        s = 0; r = 1; #10;
        s = 1; r = 0; #10;  // 11, 00
        s = 1; r = 0; #10;
        s = 1; r = 1; #10;  // 11, 11
        s = 1; r = 1; #10;

        $stop;
    end
endmodule




//easy way
module srflipflopnormal1(input s, input r, output q, output q1);
    wire r1, w1, w2;

    not n1(r1, r);
    and m2(w1, r1, s);
    and m1(w2, r1, q);
    or m3(q1, w1, w2);


endmodule
