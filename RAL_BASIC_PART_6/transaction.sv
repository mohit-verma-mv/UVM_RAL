class transaction extends uvm_sequence_item;
  
  `uvm_object_utils(transaction)
  
  bit [7:0] din;
  bit wr;
  bit addr;
  bit rst;
  bit [7:0] dout;
  
  function new(string name = "transaction");
    super.new(name);
  endfunction
  
  /*`uvm_object_utils_begin(transaction)
  `uvm_field_int(din,UVM_ALL_ON)
  `uvm_field_int(wr,UVM_ALL_ON)
  `uvm_field_int(addr,UVM_ALL_ON)
  `uvm_field_int(dout,UVM_ALL_ON)
  `uvm_object_utils_end*/
  
endclass