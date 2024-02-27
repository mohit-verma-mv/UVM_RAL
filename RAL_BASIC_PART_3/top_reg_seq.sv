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
    
   
    //frontdoor write
    regmodel.temp_reg_inst.write(status,8'hf);
    ref_data = regmodel.temp_reg_inst.get();
    `uvm_info("[SEQ]:",$sformatf("Desired Value backdoor: %0d",ref_data),UVM_NONE);
    ref_data = regmodel.temp_reg_inst.get_mirrored_value();
    `uvm_info("[SEQ]:",$sformatf("Mirrored Value backdoor: %0d",ref_data),UVM_NONE);
    
    
    //backdoor read
    regmodel.temp_reg_inst.read(status,rdata,UVM_BACKDOOR);
    `uvm_info(get_type_name(),$sformatf("Read start value is %x",rdata),UVM_LOW);
    
    //backdoor write
    regmodel.temp_reg_inst.write(status,8'he,UVM_BACKDOOR);
    ref_data = regmodel.temp_reg_inst.get();
    `uvm_info("[SEQ]:",$sformatf("Desired Value backdoor: %0d",ref_data),UVM_NONE);
    ref_data = regmodel.temp_reg_inst.get_mirrored_value();
    `uvm_info("[SEQ]:",$sformatf("Mirrored Value backdoor: %0d",ref_data),UVM_NONE);
    
  endtask
  
  
endclass