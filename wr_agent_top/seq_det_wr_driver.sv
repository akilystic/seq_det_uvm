class seq_det_wr_driver extends uvm_driver#(write_xtn);
    `uvm_component_utils(seq_det_wr_driver);
    virtual seq_det_if.DRV_MP vif;
    seq_det_wr_cfg w_cfg;
    
    extern function new(string name = "seq_det_wr_driver", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task drive2dut(write_xtn xtn);
endclass: seq_det_wr_driver

    function seq_det_wr_driver::new(string name = "seq_det_wr_driver", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void seq_det_wr_driver::build_phase(uvm_phase phase);
        if(!uvm_config_db#(seq_det_wr_cfg)::get(this,"","seq_det_wr_cfg",w_cfg))
            `uvm_fatal(get_name(), "Unable to get wr_cfg. Have you set it");           
    endfunction: build_phase

    function void seq_det_wr_driver::connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        vif=w_cfg.vif;
    endfunction: connect_phase

    task seq_det_wr_driver::run_phase(uvm_phase phase);
    @(vif.drv_cb)
    vif.drv_cb.reset<=1'b1;
    @(vif.drv_cb)
    vif.drv_cb.reset<=1'b0;
    forever
    begin
        seq_item_port.get_next_item(req);
        drive2dut(req);
        seq_item_port.item_done();
    end
    endtask: run_phase
    
    task seq_det_wr_driver::drive2dut(write_xtn xtn);
        foreach(req.pattern[i])
        begin
            vif.drv_cb.din<=req.pattern[i];
            @(vif.drv_cb);
        end
            `uvm_info(get_type_name(), $sformatf("printing from Driver:\n %s",req.sprint()), UVM_NONE);
            
    endtask
