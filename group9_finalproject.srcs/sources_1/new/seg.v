module segmodule
(
input [3:0] bcd,
output reg [6:0] seg
);

always@(bcd)begin
case(bcd)
    0:
        seg = 7'b0111111;
    1:
        seg = 7'b0110000;
    2:
        seg = 7'b1011011;
    3:
        seg = 7'b1001111;
    4:
        seg = 7'b1100110;
    5:
        seg = 7'b1101101;
    6:
        seg = 7'b1111100;
    7:
        seg = 7'b0100111;
    8:
        seg = 7'b1111111;
    9:
        seg = 7'b1101111;
endcase
end

endmodule