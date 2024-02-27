import uvm_pkg::*;
`include "uvm_macros.svh"

`include "transaction.sv"
`include "driver.sv"
`include "agent.sv"
`include "temp_reg.sv"
`include "top_reg_block.sv"
`include "top_reg_seq.sv"        //seq for transactions
//`include "rst_seq.sv"          //seq for reset
`include "top_adapter.sv"
`include "environment.sv"
`include "test.sv"


module tb();
  
  top_if tif();
  
  top dut (tif.clk,
           tif.rst,
           tif.wr,
           tif.addr,
           tif.din,
           tif.dout);
  
  initial 
    begin
      tif.clk <= 1'b0;
    end
  
  always #10 tif.clk <= ~tif.clk;
  
  initial 
    begin
      //setting interface for all the components
      uvm_config_db #(virtual top_if)::set(null,"*","tif",tif);
      //to avoid the include coverage message from the console
      uvm_config_db #(int)::set(null,"*","include_coverage",0);
      run_test("test");
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars();
    end
  
endmodule