module adder64bit (input logic [63:0]a, b,
						input logic cin,
						output logic [63:0]sum,
						output logic cout);
						logic [63:0]tmp;
	adder ad(.a(a[0]),.b(b[0]),.ci(cin),.S(sum[0]),.co(tmp[0]));					
	genvar i;
	generate
	for (i=1; i<64; i=i+1) begin: add
		adder ad(.a(a[i]),.b(b[i]),.ci(tmp[i-1]),.S(sum[i]),.co(tmp[i]));
		end
	endgenerate
	assign cout=tmp[63];
endmodule