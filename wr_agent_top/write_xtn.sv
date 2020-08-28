class write_xtn extends uvm_sequence_item;
    `uvm_object_utils(write_xtn)
    rand bit [0:3] pattern;

    extern function new(string name="write_xtn");
    extern function void do_print(uvm_printer printer);
endclass
    function write_xtn::new(string name="write_xtn");
        super.new(name);
    endfunction   

    function void write_xtn::do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field("pattern",this.pattern,4,UVM_BIN);
    endfunction: do_print    