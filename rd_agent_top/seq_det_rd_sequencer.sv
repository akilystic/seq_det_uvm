class seq_det_rd_sequencer extends uvm_sequencer#(master_xtn);
	`uvm_component_utils(seq_det_rd_sequencer)
	
	extern function new(string name="seq_det_rd_sequencer", uvm_component parent);
endclass

	function seq_det_rd_sequencer::new(string name="seq_det_rd_sequencer", uvm_component parent);
		super.new(name,parent);
	endfunction