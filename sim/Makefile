RTL= ../rtl/*
work=work
SVTB1= ../tb/top.sv
INC= +incdir+../tb +incdir+../test +incdir+../wr_agt_top +incdir+../rd_agt_top
SVTB2= ../test/seq_det_pkg.sv
VSIMOPT= -vopt -voptargs=+acc
VSIMCOV= -coverage -sva
VSIMBATCH1= -c -do  " log -r /* ;run -all; exit"

sv_cmp:
        vlib $(work)
        vmap work $(work)
        vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1)

run_test:sv_cmp
        vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log  -sv_seed random  work.top +UVM_TESTNAME=seq_det_test

clean:
        rm -rf transcript* *log* work *wlf fcover* covhtml* mem_cov*
        clear
