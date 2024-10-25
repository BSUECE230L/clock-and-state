module seven_seg_scanner(
    input div_clock,
    input reset,
    output reg [3:0] anode
);

    wire [1:0] count;

    always (posedge div_clock, posedge reset) begin
        if (reset) begin
            count = 0;
        end
        else begin
           count = count + 1;

         case(count)
            2'b00: anode  = 'b1110;
            2'b01: anode  = 'b1101;
            2'b10: anode  = 'b1011;
            2'b11: anode  = 'b0111;
        endcase

        end
    end


endmodule