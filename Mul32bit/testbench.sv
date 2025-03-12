module testbench;
logic [31:0]mul1;
logic [31:0]mul2;
logic [64:0]result;
mul32bit xyz(.mul1(mul1),.mul2(mul2),.result(result));
initial begin
	$fsdbDumpfile("testbench,fsdb");
	$fsdbDumpvars(0,testbench,"+all");
end

initial begin: test1
	#10 mul1=1530; mul2=69768253;
	#20 mul1=2; mul2=2;
	#10 mul1=2; mul2=3;
	#10 mul1=2; mul2=4;
end 
initial begin
	#100
	$finish;
end
endmodule
