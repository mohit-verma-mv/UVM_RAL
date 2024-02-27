class temp_reg extends uvm_reg;
  
  `uvm_object_utils(temp_reg)
  
  rand uvm_reg_field temp;
  
  
  //adding coverpoint
  covergroup temp_cov;
    
    option.per_instance = 1;
    
    //value variable store the value to be sampled
    //in a functional coverage
    coverpoint temp.value[7:0]
    {
      bins lower = {[0:63]};
      bins mid   = {[64:127]};
      bins high  = {[128:255]};	
    }
    
  endgroup
  
  function new(string name = "temp_reg");
    super.new(    name,                 8,                UVM_CVR_FIELD_VALS);
    //        instance_name    size of DUT register         coverage enabler 
    
    if(has_coverage(UVM_CVR_FIELD_VALS))
      temp_cov = new();
  endfunction
  
  //implementation of sample and sample_values
  virtual function void sample(uvm_reg_data_t data,
                              uvm_reg_data_t byte_en,
                              bit is_read,
                              uvm_reg_map map);
    temp_cov.sample();
  endfunction
  
  
  virtual function void sample_values();
    super.sample_values();
    temp_cov.sample();
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