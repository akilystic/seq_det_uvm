class seq_det_wr_seqs extends uvm_sequence#(write_xtn);
    `uvm_object_utils(seq_det_wr_seqs)

    extern function new(string name="seq_det_wr_seqs");
endclass

    function seq_det_wr_seqs::new(string name="seq_det_wr_seqs");
        super.new(name);
    endfunction

class sequence1 extends seq_det_wr_seqs;
    `uvm_object_utils(sequence1);
    extern function new(string name="sequence1");
    extern task body();
endclass

    function sequence1::new(string name="sequence1");
        super.new(name);
    endfunction

    task sequence1::body();
        req=write_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize)
        finish_item(req);

        start_item(req);
        assert(req.randomize with {pattern==4'b1010;})
        finish_item(req);
    endtask