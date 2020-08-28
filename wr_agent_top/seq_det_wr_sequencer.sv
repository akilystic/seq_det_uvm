class seq_det_wr_sequencer extends uvm_sequencer#(write_xtn);
	`uvm_component_utils(seq_det_wr_sequencer)
	
	extern function new(string name="seq_det_wr_sequencer", uvm_component parent);
endclass

	function seq_det_wr_sequencer::new(string name="seq_det_wr_sequencer", uvm_component parent);
		super.new(name,parent);
	endfunction