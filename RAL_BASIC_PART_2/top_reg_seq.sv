class top_reg_seq extends uvm_sequence;
  
  `uvm_object_utils(top_reg_seq)
  
  top_reg_block regmodel;
  
  function new(string name = "top_reg_seq");
    super.new(name);
  endfunction
  
  
  //------>WORKING WITH DESIRED AND MIRRORED VALUE\\
  
  /*task body;
  
    uvm_status_e status;
    bit [7:0] rdata_d,rdata_m;
    
    //----->Initial value without performing transaction
    
    rdata_d = regmodel.temp_reg_inst.get();   //accessing desired variable
    rdata_m = regmodel.temp_reg_inst.get_mirrored_value(); //accessing mirrored value
    `uvm_info("SEQ",$sformatf("At Initial State -> Desired Value: %0d & Mirrored Value: %0d",rdata_d,rdata_m),UVM_NONE);
    
    //----->Update desired value
    
    regmodel.temp_reg_inst.set(8'h11);
    
    //------>Get desired value
    
    rdata_d = regmodel.temp_reg_inst.get();   //accessing desired variable
    rdata_m = regmodel.temp_reg_inst.get_mirrored_value();   //accessing mirrored variable
    `uvm_info("SEQ",$sformatf("After calling set -> Desired Value: %0d & Mirrored Value: %0d",rdata_d,rdata_m),UVM_NONE);
    
    //------>Call write method to perform transaction to a dut
    
    regmodel.temp_reg_inst.update(status);     //for performing wr_txn to the dut we use update method 
    rdata_d = regmodel.temp_reg_inst.get();   //accessing desired variable
    rdata_m = regmodel.temp_reg_inst.get_mirrored_value();   //accessing mirrored variable
    `uvm_info("SEQ",$sformatf("After Tx to DUT -> Desired Value: %0d & Mirrored Value: %0d",rdata_d,rdata_m),UVM_NONE);
    
    
    //for register model to see the current state (i.e. Mirrored Variable) of 
    //an hardware register predictor is mandatory.
    
    //regmodel.temp_reg_inst.write(status,4'h4);
    //regmodel.temp_reg_inst.write(status,4'hf);
    
  endtask*/
  
  
  
  //------>UNDERSTANDING PREDICT AND MIRROR METHOD\\
  
  /*task body();
    
    uvm_status_e status;
    bit [7:0] rdata_d,rdata_m;
    
    
    //->write_xtn
    
    regmodel.temp_reg_inst.write(status,5'h10);
    rdata_d = regmodel.temp_reg_inst.get();
    rdata_m = regmodel.temp_reg_inst.get_mirrored_value();
    `uvm_info("[SEQ]:", $sformatf("Desired Value: %0d & Mirrored Value: %0d",rdata_d,rdata_m),UVM_NONE);

    //->updating the register model
    
    regmodel.temp_reg_inst.predict(5'h05);
    rdata_d = regmodel.temp_reg_inst.get();
    rdata_m = regmodel.temp_reg_inst.get_mirrored_value();
    `uvm_info("[SEQ]:", $sformatf("Desired Value: %0d & Mirrored Value: %0d",rdata_d,rdata_m),UVM_NONE);
    
    //->reading a data back from hardware register
    
    //regmodel.temp_reg_inst.mirror(status,UVM_CHECK);
    regmodel.temp_reg_inst.mirror(status,UVM_NO_CHECK);
    rdata_d = regmodel.temp_reg_inst.get();
    rdata_m = regmodel.temp_reg_inst.get_mirrored_value();
    `uvm_info("[SEQ]:", $sformatf("Desired Value: %0d & Mirrored Value: %0d",rdata_d,rdata_m),UVM_NONE);
    
  endtask*/
  
  
  //------>SINGLE WRITE AND READ TRANSACTION\\
  
  task body();
    
    uvm_status_e status;
    bit [7:0] rdata_d,rdata_m;
    
    bit [7:0] dout_t;
    
    regmodel.temp_reg_inst.write(status,5'h05,UVM_FRONTDOOR);
    rdata_d = regmodel.temp_reg_inst.get();
    rdata_m = regmodel.temp_reg_inst.get_mirrored_value();
    `uvm_info("[SEQ]:", $sformatf("Write Tx to DUT -> Desired Value: %0d & Mirrored Value: %0d",rdata_d,rdata_m),UVM_NONE);
   
    
    regmodel.temp_reg_inst.read(status,dout_t,UVM_FRONTDOOR);
    rdata_d = regmodel.temp_reg_inst.get();
    rdata_m = regmodel.temp_reg_inst.get_mirrored_value();
    `uvm_info("[SEQ]:", $sformatf("Read Tx from DUT -> Desired Value: %0d & Mirrored Value: %0d & Data Read: %0d",rdata_d,rdata_m,dout_t),UVM_NONE);
    
  endtask
  
  
  
  //------>MULTIPLE WRITE AND READ TRANSACTIONS\\
  
  /*task body();
    
    uvm_status_e status;
    bit [7:0] rdata_d,rdata_m;
    
    bit [7:0] dout_t;
    bit [7:0] din_temp; 
    int no_of_tx = 0;
    
    for(int i=0;i<5;i++)
      begin
        
        no_of_tx++;
        $display("No. of Txn = %0d",no_of_tx);
        
        din_temp = $urandom_range(5,20);
        regmodel.temp_reg_inst.write(status,din_temp);
        rdata_d = regmodel.temp_reg_inst.get();
        rdata_m = regmodel.temp_reg_inst.get_mirrored_value();
        `uvm_info("[SEQ]:", $sformatf("Write Tx to DUT -> Desired Value: %0d & Mirrored Value: %0d",rdata_d,rdata_m),UVM_NONE);
        
        regmodel.temp_reg_inst.read(status,dout_t);
        rdata_d = regmodel.temp_reg_inst.get();
        rdata_m = regmodel.temp_reg_inst.get_mirrored_value();
        `uvm_info("[SEQ]:", $sformatf("Read Tx to DUT -> Desired Value: %0d & Mirrored Value: %0d & Data Read: %0d",rdata_d,rdata_m,dout_t),UVM_NONE);
        
      end
   
  endtask*/
  
  
  //------>APPLYING MULTIPLE TRANSACTIONS USING RANDOMIZE METHOD\\
  
  /*task body();
    
    uvm_status_e status;
    
    bit [7:0] rdata;
    
    int no_of_txn = 0;
    
    for(int i=0;i<10;i++)
      begin
        no_of_txn++;
        $display("No. of Txn = %0d",no_of_txn);
        regmodel.temp_reg_inst.randomize();
        regmodel.temp_reg_inst.write(status,regmodel.temp_reg_inst.temp.value);
        `uvm_info("[SEQ]:",$sformatf("Random Value: %0d",regmodel.temp_reg_inst.temp.value),UVM_NONE);
      end
    
  endtask*/
  
  
endclass