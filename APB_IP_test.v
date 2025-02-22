module test();
  reg clk,start,wr;
  reg [7:0]data_p;
  reg [7:0]addr_p;
  reg prst;
  
  apb_ip dut(prst,clk,start,data_p,addr_p,wr);
  
  initial
    begin
      clk=0;
      prst=1;
      #50 prst=0;
      
      start=1;
      data_p=8'h12;
      addr_p=8'h05;
      wr=1;
      #100 start=0;
    end
  always #5 clk=~clk;
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars();
      #500 $finish;
    end
  
endmodule
