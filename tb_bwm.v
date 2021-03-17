`timescale 1ns / 1ns
module tb_bwm;

reg [31:0] x, y;
wire [62:0] p;


bwm #(32) DUT (x, y, p);

initial begin
x = 32'd523;
y = -32'd3333;
#100
x = 32'd123;
y = 32'd0;
#100
y = 32'd5555;
#100
x = -32'd1133;
y = -32'd3123;
$stop;
end


endmodule
