//kısa hali
module Tflipflopnormal1(input T,  input clk, output reg q, output q1);
xor m1(q1,T,q);

endmodule


//uzun hali
module tflipflopnormal2(input t, input clk, output reg q, output q1);

xor m1(q1,t,q);

    initial begin
        q = 0;
        forever #10 q = ~q;

    end
    always @(posedge clk) begin
        case ({t,q})
            2'b00: q <= 0;        // Set
            2'b01: q <= 1;  
            2'b10: q <= 1; 
            2'b11: q <= 0;    // Illegal state
        endcase
    end
endmodule
module tflipflop_tb1;
    reg t,clk;
    wire q1;
    wire q;

    tflipflopnormal2 uut ( .t(t), .clk(clk), .q(q), .q1(q1));

    // Clock üretimi
    initial begin
        clk = 0;
        forever #10 clk = ~clk;    // 10 birim periyot
    end

    // s ve r?yi pattern ?eklinde ilerlet
    initial begin
        t = 0;#10; 
        t = 0;#10; 
        t = 1;#10; 
        t = 1;#10; 
        $stop;
    end
endmodule
