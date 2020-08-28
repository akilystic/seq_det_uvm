module seq_det(
    input clock,
    input reset,
    input din,
    output dout
    );
	 
parameter IDLE=5'b10000,
			 STATE1=5'b01000,
			 STATE2=5'b00100,
			 STATE3=5'b00010,
			 STATE4=5'b00001;

reg [4:0] state,next_state;

	always@(posedge clock)
	begin
		if(reset)
			state<=IDLE;
		else
			state<=next_state;
	end
	
	always@(*)
	begin
	next_state=IDLE;
	case(state)
	IDLE:  begin
				if(din)
					next_state=STATE1;
			 end
	STATE1:begin
				if(!din)
					next_state=STATE2;
				else
					next_state=STATE1;
			 end		
	STATE2:begin
				if(din)
					next_state=STATE3;
			 end	
	STATE3:begin
				if(!din)
					next_state=STATE4;
				else
					next_state=STATE1;
			 end	
	STATE4:begin
				if(din)
					next_state=STATE3;
			 end	
	endcase
	end
	
assign dout=(state==STATE4);

endmodule