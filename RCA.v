module RCA (xr, yr, cir, sr, cor);
parameter BW = 8;
localparam RT = BW - 1;
localparam RT1 = RT-1;

input [RT1:0] xr, yr;
input cir;
output [RT1:0] sr;
output cor;

wire [RT1-1:0] tc;

FA R0 (xr[0], yr[0], cir, sr[0], tc[0]);
genvar i;

generate
	for(i = 1; i < RT1; i = i+1) begin : RCA
		FA R1 (xr[i], yr[i], tc[i-1], sr[i], tc[i]);
	end
endgenerate

FA R2 (xr[RT1], yr[RT1], tc[RT1-1], sr[RT1], cor);

endmodule 
