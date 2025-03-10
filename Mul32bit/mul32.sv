module mul32(
		input logic [31:0]mul1, mul2,
		output logic [63:0]result
		);
		logic [31:0]a,b;
		logic [63:0]c;
		logic [31:0]x[31:0];    //and bit
		logic [63:0]y[31:0];    //shift bit
		logic [63:0]z[15:0];    //add round 1
		logic [63:0]m[7:0];     //add round 2
		logic [63:0]n[3:0];     //add round 3
		logic [63:0]p[1:0];     //add round 4

assign a=mul1;
assign b=mul2;
assign result=c;

genvar i,j;
generate
	for (i=0;i<32;i++) begin: column
		for (j=0;j<32;j++) begin: row
			assign x[i][j]=b[i]&a[j];
			end
		shiftleft(.in(x[i]),.n(i),.out(y[i]));
	end
endgenerate

		adder64bit(.a(y[0]),.b(y[1]),.cin(0),.sum(z[0]));
		adder64bit(.a(y[2]),.b(y[3]),.cin(0),.sum(z[1]));
		adder64bit(.a(y[4]),.b(y[5]),.cin(0),.sum(z[2]));
		adder64bit(.a(y[6]),.b(y[7]),.cin(0),.sum(z[3]));
		adder64bit(.a(y[8]),.b(y[9]),.cin(0),.sum(z[4]));
		adder64bit(.a(y[10]),.b(y[11]),.cin(0),.sum(z[5]));
		adder64bit(.a(y[12]),.b(y[13]),.cin(0),.sum(z[6]));
		adder64bit(.a(y[14]),.b(y[15]),.cin(0),.sum(z[7]));
		adder64bit(.a(y[16]),.b(y[17]),.cin(0),.sum(z[8]));
		adder64bit(.a(y[18]),.b(y[19]),.cin(0),.sum(z[9]));
		adder64bit(.a(y[20]),.b(y[21]),.cin(0),.sum(z[10]));
		adder64bit(.a(y[22]),.b(y[23]),.cin(0),.sum(z[11]));
		adder64bit(.a(y[24]),.b(y[25]),.cin(0),.sum(z[12]));
		adder64bit(.a(y[26]),.b(y[27]),.cin(0),.sum(z[13]));
		adder64bit(.a(y[28]),.b(y[29]),.cin(0),.sum(z[14]));
		adder64bit(.a(y[30]),.b(y[31]),.cin(0),.sum(z[15]));
		
		adder64bit(.a(z[0]),.b(z[1]),.cin(0),.sum(m[0]));
		adder64bit(.a(z[2]),.b(z[3]),.cin(0),.sum(m[1]));
		adder64bit(.a(z[4]),.b(z[5]),.cin(0),.sum(m[2]));
		adder64bit(.a(z[6]),.b(z[7]),.cin(0),.sum(m[3]));
		adder64bit(.a(z[8]),.b(z[9]),.cin(0),.sum(m[4]));
		adder64bit(.a(z[10]),.b(z[11]),.cin(0),.sum(m[5]));
		adder64bit(.a(z[12]),.b(z[13]),.cin(0),.sum(m[6]));
		adder64bit(.a(z[14]),.b(z[15]),.cin(0),.sum(m[7]));
		
		adder64bit(.a(m[0]),.b(m[1]),.cin(0),.sum(n[0]));
		adder64bit(.a(m[2]),.b(m[3]),.cin(0),.sum(n[1]));
		adder64bit(.a(m[4]),.b(m[5]),.cin(0),.sum(n[2]));
		adder64bit(.a(m[6]),.b(m[7]),.cin(0),.sum(n[3]));
		
		adder64bit(.a(n[0]),.b(n[1]),.cin(0),.sum(p[0]));
		adder64bit(.a(n[2]),.b(n[3]),.cin(0),.sum(p[1]));
		
		adder64bit(.a(p[0]),.b(p[1]),.cin(0),.sum(c));
endmodule