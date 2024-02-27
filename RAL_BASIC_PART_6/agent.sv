class agent extends uvm_agent;
  
  `uvm_component_utils(agent)
  
  function new(string name = "agent", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  driver drv;
  uvm_sequencer #(transaction) seqr;
  monitor mon;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv = driver::type_id::create("drv",this);
    mon = monitor::type_id::create("mon",this);
    seqr = uvm_sequencer#(transaction)::type_id::create("seqr",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //connect TLM ports of seqr and drv
    drv.seq_item_port.connect(seqr.seq_item_export); 
  endfunction
  
endclass