`timescale 1ns/1ps

module test();

    reg [7:0] sw;
    reg clk;
    reg btnC;
    wire [3:0] an;
    wire [6:0] seg;

    top #(.DIVIDE_BY(2)) uut(
        .sw(sw),
        .clk(clk),
        .btnC(btnC),
        .an(an),
        .seg(seg)
    );

    task automatic advance_clock;
        begin
            #1 clk = ~clk;
            #1 clk = ~clk;
            #1 clk = ~clk;
            #1 clk = ~clk;
        end
    endtask

    task automatic test_segs(
        input [7:0] expected_segR,
        input [7:0] expected_segRC,
        input [7:0] expected_segLC,
        input [7:0] expected_segL
    );
        begin
            if (seg != expected_segR) begin
                $display("Test failed, segment R!");
                $finish;
            end
            advance_clock();
            if (seg != expected_segRC) begin
                $display("Test failed, segment RC!");
                $finish;
            end
            advance_clock();
            if (seg != expected_segLC) begin
                $display("Test failed, segment LC!");
                $finish;
            end
            advance_clock();
            if (seg != expected_segL) begin
                $display("Test failed, segment L!");
                $finish;
            end
            advance_clock();
        end
    endtask

    initial begin
        $dumpvars(0,test);
        clk = 0;
        sw = 0;
        btnC = 1;
        #5;
        btnC = 0;
        test_segs(7'h40, 7'h40, 7'h40, 7'h40);
        #5;
        sw = 8'b00010011;
        #5;
        test_segs(7'h30, 7'h79, 7'h19, 7'h24);
    end

endmodule
