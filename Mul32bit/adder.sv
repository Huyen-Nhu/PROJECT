module adder (input logic a,b,ci,
					output logic S,co);

assign S=ci^(a^b);
assign co=(a&b)|(ci&(a^b));
endmodule