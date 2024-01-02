`timescale 1ns/1ps

module tb_nor2 ();

    logic       a, b, c;

    initial begin
        $dumpfile("tb_bor2.vcd");
        $dumpvars(0, tb_nor2);

        a = 'b0; b = 'b0;
        #(10) a = 1'b0; b = 1'b0;
        #(10) a = 1'b0; b = 1'b1;
        #(10) a = 1'b1; b = 1'b0;
        #(10) a = 1'b1; b = 1'b1;
        #(10)
        $finish;
    end

    nor2 dut (a, b, c);
endmodule