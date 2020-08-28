class seq_det_wr_agent extends uvm_agent;
    `uvm_component_utils(seq_det_wr_agent);
    
    seq_det_wr_monitor monh;
    seq_det_wr_driver drvh;
    seq_det_wr_sequencer seqrh;
    seq_det_wr_cfg w_cfg;
  
    extern function new(string name = "seq_det_wr_agent", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    
endclass: seq_det_wr_agent

    function seq_det_wr_agent::new(string name = "seq_det_wr_agent", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void seq_det_wr_agent::build_phase(uvm_phase phase);
        if(!uvm_config_db#(seq_det_wr_cfg)::get(this,"","seq_det_wr_cfg",w_cfg))
            `uvm_fatal(get_name(), "Unable to get Config. Have you set it");

        if(w_cfg.is_active==UVM_ACTIVE)
        begin
            drvh=seq_det_wr_driver::type_id::create("drvh",this);
            seqrh=seq_det_wr_sequencer::type_id::create("seqrh",this);
        end
        monh=seq_det_wr_monitor::type_id::create("monh",this); 
    endfunction: build_phase

    function void seq_det_wr_agent::connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if(w_cfg.is_active==UVM_ACTIVE)
        drvh.seq_item_port.connect(seqrh.seq_item_export);
    endfunction: connect_phase
