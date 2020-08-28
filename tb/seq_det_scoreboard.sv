class seq_det_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(seq_det_scoreboard);


    write_xtn wrxtn;
    read_xtn rdxtn;
    uvm_tlm_analysis_fifo #(read_xtn) rd_fifo[];
    uvm_tlm_analysis_fifo #(write_xtn) wr_fifo[];
    seq_det_env_cfg e_cfg;
    extern function new( string name="seq_det_scoreboard",uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    //  Function: run_phase
    extern task run_phase(uvm_phase phase);
    //  Function: extract_phase
    extern function void check_data(write_xtn xtn1, read_xtn xtn2);
        
endclass

    function seq_det_scoreboard::new(string name="seq_det_scoreboard",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void seq_det_scoreboard::build_phase(uvm_phase phase);
        if(!uvm_config_db#(seq_det_env_cfg)::get(this,"","seq_det_env_cfg",e_cfg))
            `uvm_fatal(get_name(), "Unable to get env_config. Have you set it?");

        rd_fifo=new[e_cfg.no_of_duts];
        foreach(rd_fifo[i])
            rd_fifo[i]=new($sformatf("rd_fifo[%0d]",i),this);

        wr_fifo=new[e_cfg.no_of_duts];
        foreach(wr_fifo[i])
            wr_fifo[i]=new($sformatf("wr_fifo[%0d]",i),this);
    endfunction: build_phase
    
    task seq_det_scoreboard::run_phase(uvm_phase phase);
        forever
        fork
            begin
                wr_fifo[0].get(wrxtn);
            end
            begin
                rd_fifo[0].get(rdxtn);
                check_data(wrxtn,rdxtn);
            end
        join
    endtask: run_phase
    
    function void seq_det_scoreboard::check_data(write_xtn xtn1, read_xtn xtn2);
       xtn1.print;
       xtn2.print;
       if(xtn1.pattern==4'b1010 & xtn2.dout==1)
       `uvm_info(get_name(), "Pattern Detected", UVM_NONE)
       
    endfunction     
    