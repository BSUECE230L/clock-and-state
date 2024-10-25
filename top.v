module top
#(
    parameter DIVIDE_BY = 17 // Use this when passing in to your clock div!
    // The test bench will set it appropriately
)
(
    input [7:0] sw, // A and B
    input clk, // 100 MHz board clock
    input btnC, // Reset
    output [3:0] an, // 7seg anodes
    output [6:0] seg // 7seg segments
);

    wire div_clock;

    clock_div #(.DIVIDE_BY(DIVIDE_BY)) cd(
        .clock(clk),
        .reset(btnC),
        .div_clock(div_clock)
    );

    wire [3:0] A = sw[3:0];
    wire [3:0] B = sw[7:4];
    wire [3:0] AplusB;
    wire [3:0] AminusB;

    math_block mb(
        .A(A),
        .B(B),
        .AplusB(AplusB),
        .AminusB(AminusB)
    );

    seven_seg_scanner sss(
        .div_clock(div_clock),
        .reset(btnC),
        .anode(an)
    );

    seven_seg_decoder ssd(
        .A(A),
        .B(B),
        .AplusB(AplusB),
        .AminusB(AminusB)
        .anode(an)
    );

    // Instantiate the clock divider...
    // ... wire it up to the scanner
    // ... wire the scanner to the decoder

    // Wire up the math block into the decoder

    // Do not forget to wire up resets!!

endmodule