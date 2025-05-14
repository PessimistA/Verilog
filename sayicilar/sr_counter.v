
module sr_flip_flop (
    input clk,
    input reset,
    input s,
    input r,
    output reg q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 1'b0;
        else begin
            case ({s, r})
                2'b00: q <= q;          // No change
                2'b01: q <= 0;       // Reset
                2'b10: q <= 1;       // Set
                2'b11:  q <= q; 
            endcase
        end
    end
endmodule

module sr_counter (
    input clk,
    input reset,
    output [2:0] q
);
    wire nq0,nq1,nq2;

    not (nq0,q[0]);
    not (nq1,q[1]);
    not (nq2,q[2]);

    wire sc,rc,sb,rb,sa,ra;

    and (sc,q[0],q[1],nq2);
    and (rc,q[0],q[1],q[2]);

    and (sb,q[0],nq1);
    and (rb,q[0],q[1]);	

    and (sa,nq0);
    and (ra,q[0]);	

    sr_flip_flop ff0 (.clk(clk), .reset(reset), .s(sa), .r(ra), .q(q[0])); 

    sr_flip_flop ff1 (.clk(clk), .reset(reset), .s(sb), .r(rb), .q(q[1])); 

    sr_flip_flop ff2 (.clk(clk), .reset(reset), .s(sc), .r(rc), .q(q[2])); 

endmodule

module tb_sr_counter;
    reg clk;
    reg reset;
    wire [2:0] q;

    sr_counter uut (
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
