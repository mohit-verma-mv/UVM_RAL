class rst_seq extends uvm_sequence;
  
  `uvm_object_utils(rst_seq)
  
  top_reg_block regmodel;
  
  virtual top_if tif;
  
  function new(string name = "rst_seq");
    super.new(name);
  endfunction
  
  
  //------>RESET METHODS DEMONSTRATION
  
  /*task body();
    
    uvm_status_e status;
    bit [7:0] rdata_d,rdata_m;
    
    bit [7:0] rst_reg;
    
    bit rst_status;
    
    //check if register has reset value
    rst_status = regmodel.temp_reg_inst.has_reset();
    `uvm_info("[SEQ]:",$sformatf("Reset Enabled: %0b",rst_status),UVM_NONE);
    
    //accessing default register value
    rst_reg = regmodel.temp_reg_inst.get_reset();
    `uvm_info("[SEQ]:",$sformatf("Register Reset Value: %0d",rst_reg),UVM_NONE);
    
    //accessing desired and mirrored value before reset
    rdata_d = regmodel.temp_reg_inst.get();
    rdata_m = regmodel.temp_reg_inst.get_mirrored_value();
    `uvm_info("[SEQ]:",$sformatf("Before Reset->  Desired Value: %0d & Mirrored Value: %0d",rdata_d,rdata_m),UVM_NONE);
    
    //Applying reset and accessing desired and mirror value
    $display("========APPLYING RESET TO REGISTER MODEL========");
    regmodel.temp_reg_inst.reset();
    
    rdata_d = regmodel.temp_reg_inst.get();
    rdata_m = regmodel.temp_reg_inst.get_mirrored_value();
    `uvm_info("[SEQ]:",$sformatf("After Reset->  Desired Value: %0d & Mirrored Value: %0d",rdata_d,rdata_m),UVM_NONE);
    
    $display("--------------Updating Register Reset Value and Applying Reset--------------");
    regmodel.temp_reg_inst.set_reset(8'hff);
    regmodel.temp_reg_inst.reset();
    
    rdata_d = regmodel.temp_reg_inst.get();
    rdata_m = regmodel.temp_reg_inst.get_mirrored_value();
    `uvm_info("[SEQ]:",$sformatf("After Reset->  Desired Value: %0d & Mirrored Value: %0d",rdata_d,rdata_m),UVM_NONE);
    
  endtask*/
  
  
  //------>CONNECTING RESET METHODS TO DUT
  task body();
    
    uvm_status_e status;
    bit [7:0] rdata_d,rdata_m;
    bit [7:0] rst_reg;
    
    //getting access to interface 
    if(!uvm_config_db #(virtual top_if)::get(null,"uvm_test_top","tif",tif))
      `uvm_error("[SEQ]:","Unable to access interface");
    
    tif.rst  <= 1'b1;
    tif.wr   <= 1'b0;
    tif.addr <= 1'b0;
    tif.din  <= 8'h00;
    regmodel.temp_reg_inst.reset();
    repeat(6)
      @(posedge tif.clk);
    tif.rst <= 1'b0;
    rdata_d = regmodel.temp_reg_inst.get();
    rdata_m = regmodel.temp_reg_inst.get_mirrored_value();
    `uvm_info("[SEQ]:",$sformatf("After Reset Desired Value:%0d & Mirrored Value:%0d",rdata_d,rdata_m),UVM_NONE);    
    
  endtask 
  
endclass