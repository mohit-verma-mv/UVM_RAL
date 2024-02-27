class temp_reg extends uvm_reg;
  
  `uvm_object_utils(temp_reg)
  
  rand uvm_reg_field temp;
  
  function new(string name = "temp_reg");
    super.new(    name,                 8,                UVM_NO_COVERAGE);
    //        instance_name    size of DUT register       coverage enabler 
  endfunction
  
  function void build;
    temp = uvm_reg_field::type_id::create("temp");
    
    temp.configure(.parent(this),
                   .size(8),
                   .lsb_pos(0),
                   .access("RW"),
                   .volatile(0),
                   .reset(8'h11),
                   .has_reset(1),
                   .is_rand(1),
                   .individually_accessible(1));
    
  endfunction
  
  
endclass