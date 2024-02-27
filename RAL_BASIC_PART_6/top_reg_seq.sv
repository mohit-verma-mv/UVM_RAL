class top_reg_seq extends uvm_sequence;
  
  `uvm_object_utils(top_reg_seq)
  
  top_reg_block regmodel;
  
  function new(string name = "top_reg_seq");
    super.new(name);
  endfunction
  
  //------>MULTIPLE WRITE AND READ TRANSACTIONS\\
  
  task body();
    
    uvm_status_e status;
    bit [7:0] rdata_d,rdata_m;
    
    bit [7:0] dout_t;
    
    bit [7:0] din_temp; 
    
    int no_of_tx = 0;
    
    for(int i=0;i<5;i++)
      begin
        
        no_of_tx++;
        $display("No. of Txn = %0d",no_of_tx);
        
        din_temp = $urandom;
        regmodel.temp_reg_inst.write(status,din_temp);
        rdata_d = regmodel.temp_reg_inst.get();
        rdata_m = regmodel.temp_reg_inst.get_mirrored_value();
        `uvm_info("[SEQ]:", $sformatf("Write Tx to DUT -> Desired Value: %0d & Mirrored Value: %0d",rdata_d,rdata_m),UVM_NONE);
        
        regmodel.temp_reg_inst.read(status,dout_t);
        rdata_d = regmodel.temp_reg_inst.get();
        rdata_m = regmodel.temp_reg_inst.get_mirrored_value();
        `uvm_info("[SEQ]:", $sformatf("Read Tx to DUT -> Desired Value: %0d & Mirrored Value: %0d & Data Read: %0d",rdata_d,rdata_m,dout_t),UVM_NONE);
        
        $display("------------------------------------------------------------------------");
        
      end
   
  endtask
  
  
  
endclass