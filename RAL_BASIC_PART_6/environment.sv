class environment extends uvm_env;
  
  `uvm_component_utils(environment)
  
  agent agnt;
  top_reg_block regmodel;
  top_adapter adapter_i;
  uvm_reg_predictor #(transaction) predictor_i;
  scoreboard sco; 
  
  //standard constructor
  function new(string name = "environment", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  //build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agnt = agent::type_id::create("agnt",this);
    sco = scoreboard::type_id::create("sco",this);
    
    regmodel = top_reg_block::type_id::create("regmodel",this);
    regmodel.build();
    
    predictor_i = uvm_reg_predictor #(transaction)::type_id::create("predictor_i",this); 
    adapter_i = top_adapter::type_id::create("adapter_i",this);
  endfunction
  
  /*
  connect_phase
  ->In connect_phase we need to specify the sequence around which we
  ->want to execute the reg sequence.
  ->To do this we have a default method (set_sequencer) to specify
  ->the sequencer of our verification environment which need
  ->2_Arguments first is path of sequencer 
                second is path of adapter
  This will handle all the connection b/w regmodel as well as sequencer.
  */ 
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agnt.mon.mon_ap.connect(sco.recv); //connection b/w mon and sco tlm port
    
    regmodel.default_map.set_sequencer(.sequencer(agnt.seqr),.adapter(adapter_i));
    regmodel.default_map.set_base_addr(0);
    
    predictor_i.map = regmodel.default_map;
    predictor_i.adapter = adapter_i;
    
    agnt.mon.mon_ap.connect(predictor_i.bus_in); //connection b/w mon and sco tlm port
    
    regmodel.default_map.set_auto_predict(0);
  endfunction
  
endclass