interface seq_det_if(input clock);
logic reset;
logic din;
logic dout;

clocking drv_cb@(posedge clock);
default input#1 output#0;
	output din,reset;
endclocking

clocking mon_cb@(posedge clock);
default input#1 output#0;
	input din,dout,reset;
endclocking

modport DRV_MP(clocking drv_cb);
modport MON_MP(clocking mon_cb);

endinterface



