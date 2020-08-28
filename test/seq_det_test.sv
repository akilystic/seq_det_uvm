class seq_det_test extends uvm_test;
	`uvm_component_utils(seq_det_test);
	
	seq_det_env_cfg e_cfg;
	seq_det_wr_cfg w_cfg[];
	seq_det_rd_cfg r_cfg[];
	seq_det_env envh;
	
	int no_of_duts=1;
	bit has_wagt=1;
	bit has_ragt=1;
	bit has_sb=1;
	
	extern function new( string name="seq_det_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
endclass

	function seq_det_test::new(string name="seq_det_test", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void seq_det_test::build_phase(uvm_phase phase);
		e_cfg=seq_det_env_cfg::type_id::create("e_cfg");

		if(has_wagt)
		begin
			w_cfg=new[no_of_duts];
			e_cfg.w_cfg=new[no_of_duts];
			foreach(w_cfg[i])
			begin
				w_cfg[i]=seq_det_wr_cfg::type_id::create($sformatf("w_cfg[%0d]",i));
				if(!uvm_config_db#(virtual seq_det_if)::get(this,"",$sformatf("vif_%0d",i),w_cfg[i].vif))
					`uvm_fatal("CONFIG ERROR","Unable to get the config. Have you set it?");
				w_cfg[i].is_active=UVM_ACTIVE;
				e_cfg.w_cfg[i]=w_cfg[i];
			end
		end
		if(has_ragt)
		begin
			r_cfg=new[no_of_duts];
			e_cfg.r_cfg=new[no_of_duts];
			foreach(r_cfg[i])
			begin
				r_cfg[i]=seq_det_rd_cfg::type_id::create($sformatf("r_cfg[%0d]",i));
				if(!uvm_config_db#(virtual seq_det_if)::get(this,"",$sformatf("vif_%0d",i),r_cfg[i].vif))
					`uvm_fatal("CONFIG ERROR","Unable to get the config. Have you set it?");
				e_cfg.r_cfg[i]=r_cfg[i];
			end
		end
		e_cfg.no_of_duts=no_of_duts;
		e_cfg.has_ragt=has_ragt;
		e_cfg.has_wagt=has_wagt;
		e_cfg.has_sb=has_sb;
		uvm_config_db#(seq_det_env_cfg)::set(this,"*","seq_det_env_cfg",e_cfg);
		envh=seq_det_env::type_id::create("envh",this);
		super.build_phase(phase);
	endfunction	

class test1 extends seq_det_test;
	`uvm_component_utils(test1)

	vseq1 vs1;
	extern function new(string name="test1",uvm_component parent);
	//  Function: build_phase
	extern function void build_phase(uvm_phase phase);
	//  Function: run_phase
	extern task run_phase(uvm_phase phase);
endclass

	function test1::new(string name="test1",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void test1::build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction: build_phase
	
	task test1::run_phase(uvm_phase phase);
		phase.raise_objection(this);
			vs1=vseq1::type_id::create("vs1",this);
			vs1.start(envh.vseqr);
			#1000;
		phase.drop_objection(this);
	endtask: run_phase
	