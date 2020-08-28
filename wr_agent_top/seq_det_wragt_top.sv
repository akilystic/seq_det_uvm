class seq_det_wragt_top extends uvm_env;
    `uvm_component_utils(seq_det_wragt_top)
    
    seq_det_wr_agent wagt[];
    seq_det_env_cfg e_cfg;

    extern function new(string name="seq_det_wragt_top", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
endclass

      function seq_det_wragt_top::new(string name="seq_det_wragt_top", uvm_component parent);
          super.new(name,parent);
      endfunction: new

      function void seq_det_wragt_top::build_phase(uvm_phase phase);
           if(!uvm_config_db#(seq_det_env_cfg)::get(this,"","seq_det_env_cfg",e_cfg))
            `uvm_fatal(get_name(), "unable ro get env_config.Have you set it?");
            wagt=new[e_cfg.no_of_duts];
           foreach(wagt[i])
           begin
            wagt[i]=seq_det_wr_agent::type_id::create($sformatf("wagt[%0d]",i),this);
            uvm_config_db#(seq_det_wr_cfg)::set(this,$sformatf("wagt[%0d]*",i),"seq_det_wr_cfg",e_cfg.w_cfg[i]);
           end            
      endfunction: build_phase