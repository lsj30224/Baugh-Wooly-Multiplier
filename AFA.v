module AFA (xs, ys, cis, ss, cos); // ArrayFullAdder
parameter BW = 8;
localparam QT = BW - 1; // modify have to, BW-1
localparam QT1 = QT - 1;

input [QT1:0] xs, ys, cis;
output [QT1:0] ss, cos;

genvar i;

generate
	for(i = 0; i < QT; i = i+1) begin : GEN
		FA U0 (xs[i], ys[i], cis[i], ss[i], cos[i]);
	end
endgenerate

endmodule
