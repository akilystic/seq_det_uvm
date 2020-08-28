class seq_det_wr_cfg extends uvm_object;
    `uvm_object_utils(seq_det_wr_cfg)

    uvm_active_passive_enum is_active;
    virtual seq_det_if vif;

    function new(string name="seq_det_wr_cfg");
        super.new(name);
    endfunction
endclass
    