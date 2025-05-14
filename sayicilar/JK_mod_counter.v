
module jk_flip_flop (
    input clk,
    input reset,
    input j,
    input k,
    output reg q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 1'b0;
        else begin
            case ({j, k})
                2'b00: q <= q;
                2'b01: q <= 0;
                2'b10: q <= 1;
                2'b11: q <= ~q;
            endcase
        end
    end
endmodule

module jk_mod7_counter (
    input clk,
    input reset,
    output [2:0] q
);
    wire u1,u2,u3,u4,u5;

    // Flip-floplar
    and (u1,q[1],q[0]);
    jk_flip_flop ff0 (.clk(clk), .reset(reset), .j(u1), .k(q[1]), .q(q[2])); // Her zaman toggle

    or (u2,q[2],q[0]);
    jk_flip_flop ff1 (.clk(clk), .reset(reset), .j(q[0]), .k(u2), .q(q[1])); // q0 = 1 ise toggle


    nand a5(u3, q[2], q[1]); // k2 = t2
    jk_flip_flop ff2 (.clk(clk), .reset(reset), .j(u3), .k(1'b1), .q(q[0])); // q0 & q1 = 1 ise toggle


endmodule

module tb_jk_counter;
    reg clk;
    reg reset;
    wire [2:0] q;

    jk_mod7_counter uut (
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
