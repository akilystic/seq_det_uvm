class seq_det_rd_cfg extends uvm_object;
    `uvm_object_utils(seq_det_rd_cfg)

    virtual seq_det_if vif;

    function new(string name="seq_det_rd_cfg");
        super.new(name);
    endfunction
endclass