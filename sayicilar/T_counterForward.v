module t_flip_flop (
    input clk,
    input reset,
    input t,
    output reg q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 1'b0;
        else if (t)
            q <= ~q;
    end
endmodule

module t_counter_3bit (
    input clk,
    input reset,
    output reg [2:0] q
);
    wire q0, q1, q2;
    reg t1, t2;

    // Flip-floplar
    t_flip_flop ff0 (.clk(clk), .reset(reset), .t(1'b1), .q(q0));
    t_flip_flop ff1 (.clk(clk), .reset(reset), .t(t1),    .q(q1));
    t_flip_flop ff2 (.clk(clk), .reset(reset), .t(t2),    .q(q2));

    always @(*) begin
        t1 = q0;
        t2 = q0 & q1;
    end

    // Çıkışı birleştir (assign kullanmadan)
    always @(*) begin
        q = {q2, q1, q0};
    end
endmodule


module tb_t_counter;
    reg clk;
    reg reset;
    wire [2:0] q;

    t_counter_3bit uut (
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
