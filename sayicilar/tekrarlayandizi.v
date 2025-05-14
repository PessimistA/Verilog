//0->4->7->2->3

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

module t_counter_3bitt (
    input clk,
    input reset,
    output [2:0] q
);
    wire nq0,nq1,nq2;
    wire ta,tb,tc;
    wire w1,w2,w3,w4,w5,w6;
    // T girişleri
    not (nq0, q[0]);   
    not (nq1, q[1]);  
    not (nq2, q[2]);             
    or (ta, q[1], q[2]);   
    and (w1, q[0], nq2);  
    and (w2, q[2], nq1);
    or (tb,w1,w2);
    and (w4,nq2,nq1);
    and (w5,q[0],q[2]);
    or (tc,w4,w5);     

    // Flip-floplar
    t_flip_flop ff0 (.clk(clk), .reset(reset), .t(ta), .q(q[0])); // T0 = 0
    t_flip_flop ff1 (.clk(clk), .reset(reset), .t(tb), .q(q[1]));
    t_flip_flop ff2 (.clk(clk), .reset(reset), .t(tc), .q(q[2]));


endmodule

module tb_t_countert;
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
        #5 reset = 0;
    end

    always #2 clk = ~clk; // 10 birimlik periyot

    initial begin
        #100 $stop; // 100 zaman birimi sonra simülasyonu bitir
    end
endmodule


//0 2 4 6 

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

module t_counter_3bitt1 (
    input clk,
    input reset,
    output [2:0] q
);

    // Flip-floplar
    t_flip_flop ff0 (.clk(clk), .reset(reset), .t(1'b0), .q(q[0])); // T0 = 0
    t_flip_flop ff1 (.clk(clk), .reset(reset), .t(1'b1), .q(q[1]));
    t_flip_flop ff2 (.clk(clk), .reset(reset), .t(q[1]), .q(q[2]));


endmodule

module tb_t_countert;
    reg clk;
    reg reset;
    wire [2:0] q;

    t_counter_3bitt1 uut (
        .clk(clk),
        .reset(reset),
        .q(q)
    );

    initial begin
        clk = 0;
        reset = 1;
        #5 reset = 0;
    end

    always #2 clk = ~clk; // 10 birimlik periyot

    initial begin
        #100 $stop; // 100 zaman birimi sonra simülasyonu bitir
    end
endmodule
