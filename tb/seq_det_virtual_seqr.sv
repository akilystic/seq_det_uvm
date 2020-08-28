class seq_det_virtual_seqr extends uvm_sequencer#(uvm_sequence_item);
    `uvm_component_utils(seq_det_virtual_seqr)

    seq_det_wr_sequencer wr_seqr[];
    seq_det_env_cfg e_cfg;
    extern function new( string name="seq_det_virtual_seqr",uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    
endclass

function seq_det_virtual_seqr::new( string name="seq_det_virtual_seqr",uvm_component parent);
    super.new(name,parent);
endfunction

function void seq_det_virtual_seqr::build_phase(uvm_phase phase);
    if(!uvm_config_db#(seq_det_env_cfg)::get(this,"","seq_det_env_cfg",e_cfg))  
        `uvm_fatal(get_name(), "Uanble to get wr_cfg. have you set it?");
    wr_seqr=new[e_cfg.no_of_duts];          
endfunction: build_phase
