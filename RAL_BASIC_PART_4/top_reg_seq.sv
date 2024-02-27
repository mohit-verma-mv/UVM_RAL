class top_reg_seq extends uvm_sequence;
  
  `uvm_object_utils(top_reg_seq)
  
  top_reg_block regmodel;
  
  uvm_reg_data_t ref_data;
  
  function new(string name = "top_reg_seq");
    super.new(name);
  endfunction
  
  task body();
    
    uvm_status_e status;
    bit [7:0] rdata;
    bit [7:0] des,mir;
    
    //writing using poke
    regmodel.temp_reg_inst.poke(status,8'hf);
    des = regmodel.temp_reg_inst.get();
    mir = regmodel.temp_reg_inst.get_mirrored_value();
    `uvm_info("SEQ:",$sformatf("Write -> Des: %0d, Mir: %0d",des,mir),UVM_NONE);
    
    $display("-------------------------------------------------------");
    
    //reading using peek
    regmodel.temp_reg_inst.peek(status,rdata);
    `uvm_info("SEQ",$sformatf("Read: %0d",rdata),UVM_LOW);
    des = regmodel.temp_reg_inst.get();
    mir = regmodel.temp_reg_inst.get_mirrored_value();
    `uvm_info("SEQ:",$sformatf("Write -> Des: %0d, Mir: %0d",des,mir),UVM_NONE);
    
  endtask
  
  
endclass