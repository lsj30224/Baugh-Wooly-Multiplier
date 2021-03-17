module FA (x, y, ci, s, co);
input x, y, ci;
output s, co;

assign s = x ^ y ^ ci;
assign co = (x & ci) | (y & ci) | (x & y);

endmodule
