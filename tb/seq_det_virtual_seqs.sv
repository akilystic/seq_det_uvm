class seq_det_virtual_seqs extends uvm_sequence#(uvm_sequence_item);
    `uvm_object_utils(seq_det_virtual_seqs)

    seq_det_wr_sequencer wr_seqr[];
    seq_det_virtual_seqr v_seqr;
    seq_det_env_cfg e_cfg;

    extern function new(string name="seq_det_virtual_seqs");
    extern task body();
endclass

    function seq_det_virtual_seqs::new(string name="seq_det_virtual_seqs");
        super.new(name);
    endfunction

    task seq_det_virtual_seqs::body();
        if(!uvm_config_db#(seq_det_env_cfg)::get(null,"","seq_det_env_cfg",e_cfg))
            `uvm_fatal(get_name(), "Unable to get env_config. Have you set it?");
        if(!$cast(v_seqr,m_sequencer))
            `uvm_fatal("VIRTUAL_SEQ","CASTING IS FAILED");
        wr_seqr=new[e_cfg.no_of_duts];
        foreach(wr_seqr[i])
            wr_seqr[i]=v_seqr.wr_seqr[i];
    endtask

class vseq1 extends seq_det_virtual_seqs;
    `uvm_object_utils(vseq1)
    sequence1 seq1;

    extern function new(string name="seq1");
    extern task body();
endclass

    function vseq1::new(string name="seq1");
        super.new(name);
    endfunction

    task vseq1::body();
        super.body();
        seq1=sequence1::type_id::create("seq1");
        seq1.start(wr_seqr[0]);
    endtask