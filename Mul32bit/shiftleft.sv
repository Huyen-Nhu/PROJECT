module shiftleft (input logic [31:0]in,
						input logic [4:0]n,
						output logic [63:0]out);
always_comb begin
	case (n)
		0: out = {32'b0, in};
		1: out = {31'b0, in[31:0], 1'b0};
		2: out = {30'b0, in[31:0], 2'b0};
		3: out = {29'b0, in[31:0], 3'b0};
		4: out = {28'b0, in[31:0], 4'b0};
		5: out = {27'b0, in[31:0], 5'b0};
		6: out = {26'b0, in[31:0], 6'b0};
		7: out = {25'b0, in[31:0], 7'b0};
		8: out = {24'b0, in[31:0], 8'b0};
		9: out = {23'b0, in[31:0], 9'b0};
		10: out = {22'b0, in[31:0], 10'b0};
		11: out = {21'b0, in[31:0], 11'b0};
		12: out = {20'b0, in[31:0], 12'b0};
		13: out = {19'b0, in[31:0], 13'b0};
		14: out = {18'b0, in[31:0], 14'b0};
		15: out = {17'b0, in[31:0], 15'b0};
		16: out = {16'b0, in[31:0], 16'b0};
		17: out = {15'b0, in[31:0], 17'b0};
		18: out = {14'b0, in[31:0], 18'b0};
		19: out = {13'b0, in[31:0], 19'b0};
		20: out = {12'b0, in[31:0], 20'b0};
		21: out = {11'b0, in[31:0], 21'b0};
		22: out = {10'b0, in[31:0], 22'b0};
		23: out = {9'b0, in[31:0], 23'b0};
		24: out = {8'b0, in[31:0], 24'b0};
		25: out = {7'b0, in[31:0], 25'b0};
		26: out = {6'b0, in[31:0], 26'b0};
		27: out = {5'b0, in[31:0], 27'b0};
		28: out = {4'b0, in[31:0], 28'b0};
		29: out = {3'b0, in[31:0], 29'b0};
		30: out = {2'b0, in[31:0], 30'b0};
		31: out = {1'b0, in[31:0], 31'b0};
		32: out = {in[31:0], 32'b0};
		default: out = 0;
	endcase
	end
endmodule
		
		
		
		