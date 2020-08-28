class seq_det_rd_monitor extends uvm_monitor;
    `uvm_component_utils(seq_det_rd_monitor)
    virtual seq_det_if.MON_MP vif;
    uvm_analysis_port#(read_xtn) monitor_port;
    seq_det_rd_cfg r_cfg;
    read_xtn xtn;
    extern function new(string name="seq_det_rd_monitor",uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    //  Function: run_phase
    extern task run_phase(uvm_phase phase);
    
endclass

    function seq_det_rd_monitor::new(string name="seq_det_rd_monitor",uvm_component parent);
        super.new(name,parent);
        monitor_port=new("monitor_port",this);
    endfunction

    function void seq_det_rd_monitor::build_phase(uvm_phase phase);
        if(!uvm_config_db#(seq_det_rd_cfg)::get(this,"","seq_det_rd_cfg",r_cfg))
            `uvm_fatal(get_name(), "Unable to get rd_cfg. Have you set it");             
    endfunction: build_phase
    
    function void seq_det_rd_monitor::connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        vif=r_cfg.vif;        
    endfunction: connect_phase

    task seq_det_rd_monitor::run_phase(uvm_phase phase);
        xtn=read_xtn::type_id::create("xtn");
        forever
        begin
            xtn.dout=vif.mon_cb.dout;
            @(vif.mon_cb);
            monitor_port.write(xtn);
        end
    endtask: run_phase