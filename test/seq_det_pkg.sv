package seq_det_pkg;
    import uvm_pkg::*;

    `include "uvm_macros.svh"
    
    `include "write_xtn.sv"
    `include "read_xtn.sv"

    `include "seq_det_wr_cfg.sv"
    `include "seq_det_rd_cfg.sv"
    `include "seq_det_env_cfg.sv"
    
    `include "seq_det_wr_driver.sv"
    `include "seq_det_wr_monitor.sv"
    `include "seq_det_wr_sequencer.sv"
    `include "seq_det_wr_seqs.sv"
    `include "seq_det_wr_agent.sv"
    `include "seq_det_wragt_top.sv"

    `include "seq_det_rd_monitor.sv"
    `include "seq_det_rd_agent.sv"
    `include "seq_det_rdagt_top.sv"

    `include "seq_det_virtual_seqr.sv"
    `include "seq_det_virtual_seqs.sv"
    `include "seq_det_scoreboard.sv"
    `include "seq_det_env.sv"
    `include "seq_det_test.sv"
endpackage

