class top_reg_block extends uvm_reg_block;
  
  `uvm_object_utils(top_reg_block)
  
  rand temp_reg temp_reg_inst;
  //            instance_name
  
  function new(string name = "top_reg_block");
    super.new(name,build_coverage(UVM_NO_COVERAGE));
  endfunction
  
  function void build();
    
    add_hdl_path("dut","RTL");
    
    //creating instance of register
    //calling user-defined build method of register
    //configure the instance
    temp_reg_inst = temp_reg::type_id::create("temp_reg_inst");
    temp_reg_inst.build();
    temp_reg_inst.configure(this);
    //                     parent
    
    temp_reg_inst.add_hdl_path_slice("tempin",0,8);
    //^3 argument -> register name in RTL, starting position, bit wide
    
    default_map = create_map("default_map",'h0,8,UVM_LITTLE_ENDIAN); //name,base_addr,nBytes
    //adding register into a map
    default_map.add_reg(temp_reg_inst,'h0,"RW"); //reg_inst_name,offset,access_policy
    
    //adding implicit prediction
    default_map.set_auto_predict(1);
    
    lock_model();
    
  endfunction
  
endclass