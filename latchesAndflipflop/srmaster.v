module srlatch(input s, input r, input enable, output q, output qn);
    wire s_en, r_en;
    nand(s_en, s, enable);
    nand(r_en, r, enable);
    nand(q, s_en, qn);
    nand(qn, r_en, q);
endmodule

module mastersr(input s, input r, input clk, output q);
    wire q1, q1n, clk1;

    not(clk1, clk);

    srlatch master(.s(s), .r(r), .enable(clk), .q(q1), .qn(q1n));
    srlatch slave(.s(q1), .r(q1n), .enable(clk1), .q(q), .qn());
endmodule
