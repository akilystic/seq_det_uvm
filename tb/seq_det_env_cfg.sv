class seq_det_env_cfg extends uvm_object;
    `uvm_object_utils(seq_det_env_cfg);

    seq_det_wr_cfg w_cfg[];
    seq_det_rd_cfg r_cfg[];
    bit has_wagt=1;
    bit has_ragt=1;
    bit has_sb=1;
    int no_of_duts;

    function new(string name="seq_det_env_cfg");
        super.new(name);
    endfunction
endclass