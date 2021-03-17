module bwm (x, y, p);
parameter BW = 8; // bit width
localparam PW = BW*2;
localparam BW1 = BW-1;
localparam BW2 = BW-2;

input [BW-1:0] x, y;
output [PW-2:0] p;

wire [BW1:0] xy [0:BW1];
wire [BW1-1:0] cos [0:BW1-1]; //Carry OutS
wire [BW1-1:0] ss [0:BW1-1]; // Sum OutS

genvar i;

generate // magnitude calculate
	for(i = 0; i < BW1; i=i+1) begin : MG
		assign xy[i][BW1-1:0] = {BW1{y[i]}} & x[BW1-1:0];
	end
endgenerate

generate // sigma hat calculate
	for(i=0; i < BW1; i=i+1) begin : MMG
		assign xy[i][BW1] = ~(x[i] & y[BW1]);
		assign xy[BW1][i] = ~(x[BW1] & y[i]);
	end
endgenerate

assign xy[BW1][BW1] = x[BW1] & y[BW1]; 
//end setting xy

// pp compute operation start
AFA #(BW) A0 (xy[0][BW1:1], xy[1][BW1-1:0], {BW1{1'b0}}, ss[0], cos[0]); // first stage

generate // array full adder
	for(i=1; i<BW1; i=i+1) begin : AF
		AFA #(BW) A1 ({xy[i][BW1], ss[i-1][BW-2:1]}, xy[i+1][BW1-1:0], cos[i-1], ss[i], cos[i]);
	end
endgenerate

RCA #(BW) RA0 ({xy[BW1][BW1], ss[BW1-1][BW1-1:1]}, cos[BW1-1], 1'b1, p[PW-2:BW], ); // last ripple carry adder setting high bits of p

assign p[0] = xy[0][0];  // setting p0

generate // setting low bits of p
	for(i = 1; i < BW; i=i+1) begin : EE
		assign p[i] = ss[i-1][0];
	end
endgenerate

endmodule

