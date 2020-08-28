class seq_det_wr_monitor extends uvm_monitor;
    `uvm_component_utils(seq_det_wr_monitor)
    virtual seq_det_if.MON_MP vif;
    uvm_analysis_port#(write_xtn) monitor_port;
    seq_det_wr_cfg w_cfg;
    write_xtn xtn;
    extern function new(string name="seq_det_wr_monitor",uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
endclass

    function seq_det_wr_monitor::new(string name="seq_det_wr_monitor",uvm_component parent);
        super.new(name,parent);
        monitor_port=new("monitor_port",this);
    endfunction

    function void seq_det_wr_monitor::build_phase(uvm_phase phase);
        if(!uvm_config_db#(seq_det_wr_cfg)::get(this,"","seq_det_wr_cfg",w_cfg))
            `uvm_fatal(get_name(), "Unable to get wr_cfg. Have you set it");             
    endfunction: build_phase
    
    function void seq_det_wr_monitor::connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        vif=w_cfg.vif;        
    endfunction: connect_phase
    
    task seq_det_wr_monitor::run_phase(uvm_phase phase);
        xtn=write_xtn::type_id::create("xtn");
        forever
        begin
            foreach(xtn.pattern[i])
            begin
            xtn.pattern[i]=vif.mon_cb.din;
            @(vif.mon_cb);
            end
            monitor_port.write(xtn);
            `uvm_info(get_type_name(), $sformatf("printing from Monitor:\n %s",xtn.sprint()), UVM_NONE); 
        end
    endtask


    