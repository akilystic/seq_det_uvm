module top;
	import seq_det_pkg::*;
	import uvm_pkg::*;
	
	bit clock;

	seq_det_if vif(clock);
	
	seq_det DUT(.clock(clock),
				.reset(vif.reset),
				.din(vif.din),
				.dout(vif.dout));
				
	initial
		begin
		uvm_config_db #(virtual seq_det_if)::set(null,"*","vif_0",vif);
		run_test();
		end
		
	always #10 clock=~clock;

endmodule	