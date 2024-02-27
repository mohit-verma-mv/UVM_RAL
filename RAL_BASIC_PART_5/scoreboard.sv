class scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(scoreboard)
  
  uvm_analysis_imp#(transaction,scoreboard) recv;
  
  bit [7:0] temp_data;
  
  function new(string name = "scoreboard", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    recv = new("recv",this);
  endfunction
  
  virtual function void write(transaction tr);
    `uvm_info("SCO",$sformatf("Wr:%0d,Addr:%0d,Din:%0d,Dout:%0d",tr.wr,tr.addr,tr.din,tr.dout),UVM_NONE);
    
    if(tr.wr == 1'b1)
      begin
        if(tr.addr == 1'b0)
          begin
            temp_data = tr.din;
            `uvm_info("SCO",$sformatf("Data Stored: %0d",tr.din),UVM_NONE);
          end
        else 
          begin
            `uvm_info("SCO","NO Such Addr",UVM_NONE);
          end
      end
    else 
      begin
        if(tr.addr == 1'b0)
          begin
            if(tr.dout == temp_data)
              `uvm_info("SCO","Test Passed",UVM_NONE);
          end
        else 
          begin
            `uvm_info("SCO","No Such Addr",UVM_NONE);
          end
      end
              
  endfunction
  
endclass