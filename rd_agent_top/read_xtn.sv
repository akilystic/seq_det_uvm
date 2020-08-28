class read_xtn extends uvm_sequence_item;
    `uvm_object_utils(read_xtn)
    bit [3:0]pattern;
    bit dout;
    extern function new(string name="read_xtn");
    extern function void do_print(uvm_printer printer);
endclass
    function read_xtn::new(string name="read_xtn");
        super.new(name);
    endfunction
    
    function void read_xtn::do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field("Input Pattern",this.pattern,4,UVM_BIN);
        printer.print_field("data_out",this.dout,1,UVM_BIN);
    endfunction: do_print