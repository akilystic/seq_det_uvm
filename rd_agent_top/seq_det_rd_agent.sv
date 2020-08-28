class seq_det_rd_agent extends uvm_agent;
    `uvm_component_utils(seq_det_rd_agent);
    
    seq_det_rd_monitor monh;
    seq_det_rd_cfg r_cfg;

    virtual seq_det_if.MON_MP vif;
  
    extern function new(string name = "seq_det_rd_agent", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    
endclass: seq_det_rd_agent

    function seq_det_rd_agent::new(string name = "seq_det_rd_agent", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void seq_det_rd_agent::build_phase(uvm_phase phase);
        if(!uvm_config_db#(seq_det_rd_cfg)::get(this,"","seq_det_rd_cfg",r_cfg))
            `uvm_fatal(get_name(), "Unable to get Config. Have you set it");

        monh=seq_det_rd_monitor::type_id::create("monh",this); 
    endfunction: build_phase