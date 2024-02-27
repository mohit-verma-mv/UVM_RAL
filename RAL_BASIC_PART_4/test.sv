class test extends uvm_test;
  
  `uvm_component_utils(test);
  
  environment env;
  top_reg_seq trseq;
  //rst_seq trseq;
  
  function new(string name = "test", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env",this);
    trseq = top_reg_seq::type_id::create("trseq");
    //trseq = rst_seq::type_id::create("trseq");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    trseq.regmodel = env.regmodel;
    trseq.start(env.agnt.seqr);
    
    phase.drop_objection(this);
    
    phase.phase_done.set_drain_time(this,200);
  endtask 
  
  
endclass