module apb_ip(prst,clk,start,data_p,addr_p,wr);
  input clk,start,wr;
  input [7:0]data_p;
  input [7:0]addr_p;
  input prst;
  
  wire pclk,pwdata,prdata,psel,penable,pready,pwrite,paddr;

  apb_master dut1(.clk(clk), .start(start), .data_p(data_p), .addr_p(addr_p), .wr(wr), .pclk(pclk), .prst(prst), .pwdata(pwdata), .prdata(prdata), .psel(psel),.penable(penable), .pready(pready), .pwrite(pwrite), .paddr(paddr));
  
  
  apb_slave dut2(.pclk(pclk), .pwdata(pwdata), .prdata(prdata), .psel(psel), .penable(penable), .pready(pready), .pwrite(pwrite), .paddr(paddr));
  
endmodule
