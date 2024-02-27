class driver extends uvm_driver#(transaction);
  
  `uvm_component_utils(driver)
  
  transaction tr;
  
  virtual top_if tif;
  
  function new(string name = "driver",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual top_if)::get(this,"","tif",tif))
      `uvm_error("DRV","Unable to access Interface");
  endfunction
  
  
  //reset DUT task
  task reset_dut();
    @(posedge tif.clk);
    tif.rst <= 1'b1;
    tif.wr <= 1'b0;
    tif.addr <= 1'b0;
    tif.din <= 8'h00;
    repeat(5)
      @(posedge tif.clk);
    `uvm_info("DRV",$sformatf("SYSTEM RESET wdata: %0d",tif.din),UVM_NONE);
    tif.rst <= 1'b0;
  endtask
  
   
  //drive DUT task
  task drive_dut();
    //@(posedge tif.clk);
    tif.rst <= 1'b0;
    tif.wr <= tr.wr;
    tif.addr <= tr.addr;
    if(tr.wr == 1'b1)
      begin
        tif.din <= tr.din;
        `uvm_info("DRV",$sformatf("Data Write wdata: %0d",tif.din),UVM_NONE);
        repeat(3) @(posedge tif.clk);
      end
    else 
      begin
        repeat(2) @(posedge tif.clk);
        tr.dout = tif.dout;
        `uvm_info("DRV",$sformatf("Data Read rdata: %0d",tif.dout),UVM_NONE);
        @(posedge tif.clk); 
      end
  endtask
  
  
  //main task of driver
  virtual task run_phase(uvm_phase phase);
    tr = transaction::type_id::create("tr");
    forever
      begin
        //this will send the request to a
        //sequence of our new data
        seq_item_port.get_next_item(tr);
        //drive stimuli
        drive_dut();
        //this will send an acknowledgement
        //to the sequencer
        seq_item_port.item_done();
      end
  endtask 
  
endclass