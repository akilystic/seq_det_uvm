class seq_det_env extends uvm_env;
    `uvm_component_utils(seq_det_env);

    seq_det_env_cfg e_cfg;
    seq_det_wragt_top wagt_top;
    seq_det_rdagt_top ragt_top;
    seq_det_scoreboard sb;
    seq_det_virtual_seqr vseqr;

    extern function new(string name="seq_set_env",uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern function void start_of_simulation_phase(uvm_phase phase);
    
endclass

    function seq_det_env::new(string name="seq_set_env",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void seq_det_env::build_phase(uvm_phase phase);
        if(!uvm_config_db#(seq_det_env_cfg)::get(this,"","seq_det_env_cfg",e_cfg))
            `uvm_fatal(get_name(), "Unable to get env_config. Have you set it?");
        if(e_cfg.has_wagt)
            wagt_top=seq_det_wragt_top::type_id::create("wagt_top",this);

        if(e_cfg.has_ragt)
            ragt_top=seq_det_rdagt_top::type_id::create("ragt_top",this);

        if(e_cfg.has_sb)
            sb=seq_det_scoreboard::type_id::create("sb",this);
        
        vseqr=seq_det_virtual_seqr::type_id::create("vseqr",this);

    endfunction
    
    function void seq_det_env::connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if(e_cfg.has_sb)
        begin
            if(e_cfg.has_wagt)   
            begin
                for(int i=0;i<e_cfg.no_of_duts;i++)
                begin
                    wagt_top.wagt[i].monh.monitor_port.connect(sb.wr_fifo[i].analysis_export);
                    vseqr.wr_seqr[i]=wagt_top.wagt[i].seqrh;
                end
            end
            if(e_cfg.has_ragt)   
            begin
                for(int i=0;i<e_cfg.no_of_duts;i++)
                begin
                    ragt_top.ragt[i].monh.monitor_port.connect(sb.rd_fifo[i].analysis_export);
                end
            end
        end
    endfunction: connect_phase

    function void seq_det_env::start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        uvm_top.print_topology;    
    endfunction: start_of_simulation_phase
    