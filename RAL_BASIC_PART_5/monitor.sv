class monitor extends uvm_monitor;
  
  `uvm_component_utils(monitor)
  
  uvm_analysis_port #(transaction) mon_ap;
  virtual top_if tif;
  transaction tr;
  
  function new(string name = "monitor", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_ap = new("mon_ap",this);
    if(!uvm_config_db #(virtual top_if)::get(this,"","tif",tif))
      `uvm_error("MON","Unable to get accecss to interface");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    tr = transaction::type_id::create("tr");
    forever
      begin
        repeat(3) @(posedge tif.clk);
        tr.wr = tif.wr;
        tr.addr = tif.addr;
        tr.din = tif.din;
        tr.dout = tif.dout;
        `uvm_info("MON",$sformatf("Wr:%0d, Addr:%0d, Din:%0d, Dout:%0d",tr.wr,tr.addr,tr.din,tr.dout),UVM_NONE);
        mon_ap.write(tr);
      end
  endtask
      
      
  
  
endclass