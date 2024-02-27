/*

------------------------------IMP_NOTES------------------------------
                    //Different Register Methods\\
Desired Variable gives us a temporary storage where we could add a value
that we want to see in an hardware register in the next transaction.
While Mirror Variable store the current known state of hardware register.

-> Write method is used to writing a value that we specified in an argument to an 
harware register. It will also update both desired as well as mirror variable.

-> Set method is used to set the value of desired variable.

-> Get method is used to retrive the value of desired variable.

-> get_mirrored_value method is used to retrive the value of mirrored variable.

-> Update method is used to performing wr_txn to dut.

-> Predict method will update desired as well as mirrored value.
it will override the current desired as well as mirrored variable.

-> Mirror method will used to read the data of the specified hardware register.
It wll also called predict method internally.
It will also perform a check b/w existing and current mirror value with the data we read from 
the hardware register. if both of them are unequal it will throw an error if UVM_CHECK is enable
and it will update the mirror value.


Reset Methods   1.has_reset   2.get_reset   3.set_reset   4.reset
These methods are used to perform a reset transaction DUT.
These reset methods are for register model or our verification environment.
This do not anyway relate to an hardware register.

->has_reset method will check whether we have the specific reset value for the register.
->get_reset method will return the reset value that we specified for that register.
->set_reset methos is used to specify or modify the reset value of the register.
->reset metohd is used to reset our model. It will update  the value of both desired 
  as well as mirror variable to the register reset value.

*/

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
  
  /*task body();
    
    uvm_status_e status;
    bit [7:0] rdata_d,rdata_m;
    
    bit [7:0] dout_t;
    
    //Write method is used to write a specified value in DUT Register.
    //Once we perform write tx, the mirror value will be updated using reg predict method.
    //after his Des and Mir variable hold the same value.
    
    regmodel.temp_reg_inst.write(status,5'h05);
    rdata_d = regmodel.temp_reg_inst.get();
    rdata_m = regmodel.temp_reg_inst.get_mirrored_value();
    `uvm_info("[SEQ]:", $sformatf("Write Tx to DUT -> Desired Value: %0d & Mirrored Value: %0d",rdata_d,rdata_m),UVM_NONE);
    
    //Read method is used to read the value of a hardware register from a DUT.
    //Once we perform read tx, it will call a predict method and update des as well as mir value.
    
    regmodel.temp_reg_inst.read(status,dout_t);
    rdata_d = regmodel.temp_reg_inst.get();
    rdata_m = regmodel.temp_reg_inst.get_mirrored_value();
    `uvm_info("[SEQ]:", $sformatf("Read Tx from DUT -> Desired Value: %0d & Mirrored Value: %0d & Data Read: %0d",rdata_d,rdata_m,dout_t),UVM_NONE);
    
  endtask*/
  
  
  
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
  
  task body();
    
    uvm_status_e status;
    
    bit [7:0] rdata;
    
    int no_of_txn = 0;
    
    
    //Whenever we call randomize method for a specific instance register, in that case 
    //the variable "value" will get the random value and its our duty to send that value 
    //in the write method.
    
    for(int i=0;i<10;i++)
      begin
        no_of_txn++;
        $display("No. of Txn = %0d",no_of_txn);
        regmodel.temp_reg_inst.randomize();
        regmodel.temp_reg_inst.write(status,regmodel.temp_reg_inst.temp.value);
        `uvm_info("[SEQ]:",$sformatf("Random Value: %0d",regmodel.temp_reg_inst.temp.value),UVM_NONE);
      end
    
  endtask
  
  
endclass