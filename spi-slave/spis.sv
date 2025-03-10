module spis( 
	input logic mosi, cs, rstn, clk,sck,
	input logic [7:0]tx,
	output logic miso, flag,
	output logic [7:0]rx
	);
	logic [2:0]cnt; /// dem so bit truyen
	logic [7:0]data;
	logic next, current;
	logic e,stop; /// e:cho phep truyen di; stop: ngung truyen de lay du lieu
	
	localparam idle = 1'b0;
	localparam load = 1'b1;
	
	always_comb begin 
	case (current)
	idle: next = (!cs) ? load : idle;
	load: next = (cnt==0)? idle : load;
	default: next = idle;
	endcase
	end
	
	always_ff @ (posedge clk, negedge rstn) begin
	if (!rstn) begin 
		current <= idle;
		end else begin
		current <= next;
	end
	end
	
	always_comb begin
				flag=0;
				e=0;
				rx=0;
				stop=0;
		case (current)
		
		idle:	begin
				flag =1;
				rx = data;
				stop =1;
				end
		load: e=1;
			
		default: begin
				flag=0;
				e=0;
				rx=0;
				stop=0;
				end
			endcase
	end
	
	always_ff @ (posedge sck) begin
				if (stop) 	data <= tx;
				else if (e) begin
						miso <= data[7];
						data <= {data[6:0], mosi};	
						cnt <= cnt+1;
						end
						else begin
						miso <=0;
						cnt <= 0;
						data<=0;
						end
					end	
endmodule