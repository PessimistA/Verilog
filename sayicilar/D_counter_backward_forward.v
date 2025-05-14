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
module d_counter_updown_3bit (
    input clk,
    input reset,
    input U,
    input D,
    output [2:0] q
);
    wire d0, d1, d2;
    wire up0, up1, up2;
    wire down1, down2;
    wire u_and_q0, d_and_nq0, nq0;

    // FF0: q[0] = q0
    or x0(up0, U, D);       // up0 = U ^ D
    xor x1(d0, q[0], up0);     // d0 = q0 ^ (U ^ D)
    d_flip_flop ff0 (.clk(clk), .reset(reset), .d(d0), .q(q[0]));

    // FF1: q[1] = q1
    not n1(nq0, q[0]);
    and a1(u_and_q0, U, q[0]);
    and a2(d_and_nq0, D, nq0);
    or  o1(up1, u_and_q0, d_and_nq0); // up1 = (U & ~q0) | (D & q0)
    xor x2(d1, q[1], up1);              // d1 = q1 ^ up1
    d_flip_flop ff1 (.clk(clk), .reset(reset), .d(d1), .q(q[1]));

    // FF2: q[2] = q2
    wire q0_and_q1, nq0_and_nq1;
    wire nq1, u_path, d_path;

    not n2(nq1, q[1]);
    and a3(q0_and_q1, q[0], q[1],U);
    and a4(nq0_and_nq1,D,nq0, nq1);
    or  o2(up2, q0_and_q1, nq0_and_nq1); // up2 = (U & q0 & q1) | (D & ~q0 & ~q1)
    xor x3(d2, q[2], up2);         // d2 = q2 ^ up2
    d_flip_flop ff2 (.clk(clk), .reset(reset), .d(d2), .q(q[2]));

endmodule

module tb_updown;
    reg clk, reset;
    reg U, D;
    wire [2:0] q;

    d_counter_updown_3bit uut (
        .clk(clk),
        .reset(reset),
        .U(U),
        .D(D),
        .q(q)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1; U = 0; D = 0;
        #10 reset = 0;

        // İleri say//7 ye kadar çıkması için zamanla oynamalısın
        #10 U = 1;
        #50 U = 0;

        // Geri say
        #10 D = 1;
        #50 D = 0;

        #10 $stop;
    end

    initial begin
        $monitor("Zaman = %0t | q = %b", $time, q);
    end
endmodule
