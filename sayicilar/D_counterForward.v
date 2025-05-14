module d_flip_flop (
    input clk,
    input reset,
    input d,
    output reg q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule

module d_counter_3bit (
    input clk,
    input reset,
    output [2:0] q
);
    wire a1,b1,c1,c2;
    wire t3;

    // Flip-floplar
    xor m2(a1,q[0],1);
    d_flip_flop ff0 (.clk(clk), .reset(reset), .d(a1), .q(q[0]));
    xor m3(b1,q[0],q[1]);
    d_flip_flop ff1 (.clk(clk), .reset(reset), .d(b1), .q(q[1]));
    and m4(c1,q[0],q[1]);
    xor m1(c2,c1,q[2]);
    d_flip_flop ff2 (.clk(clk), .reset(reset), .d(c2),    .q(q[2]));


endmodule

module tb_d_counter;
    reg clk;
    reg reset;
    wire [2:0] q;

    d_counter_3bit uut (
        .clk(clk),
        .reset(reset),
        .q(q)
    );

    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;
    end

    always #5 clk = ~clk; // 10 birimlik periyot

    initial begin
        #100 $stop; // 100 zaman birimi sonra simülasyonu bitir
    end
endmodule
