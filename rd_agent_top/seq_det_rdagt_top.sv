class seq_det_rdagt_top extends uvm_env;
    `uvm_component_utils(seq_det_rdagt_top)
    
    seq_det_rd_agent ragt[];
    seq_det_env_cfg e_cfg;

    extern function new(string name="seq_det_rdagt_top", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
endclass

      function seq_det_rdagt_top::new(string name="seq_det_rdagt_top", uvm_component parent);
          super.new(name,parent);
      endfunction: new

      function void seq_det_rdagt_top::build_phase(uvm_phase phase);
           if(!uvm_config_db#(seq_det_env_cfg)::get(this,"","seq_det_env_cfg",e_cfg))
            `uvm_fatal(get_name(), "unable ro get env_config.Have you set it?");
            ragt=new[e_cfg.no_of_duts];
           foreach(ragt[i])
           begin
            ragt[i]=seq_det_rd_agent::type_id::create($sformatf("ragt[%0d]",i),this);
            uvm_config_db#(seq_det_rd_cfg)::set(this,$sformatf("ragt[%0d]*",i),"seq_det_rd_cfg",e_cfg.r_cfg[i]);
           end            
      endfunction: build_phase