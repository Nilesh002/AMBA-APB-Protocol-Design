module apb_master(clk,start,data_p,addr_p,wr,pclk,prst,pwdata,prdata,psel,penable,pready,pwrite,paddr);
  input start;
  input clk;
  input [7:0]data_p;
  input [7:0]addr_p;
  input wr;
  input pready;
  
  input prst;
  input [7:0] prdata;
  output [7:0] pwdata;
  output reg psel,penable;
  output reg pwrite;
  output [7:0]paddr;
  output reg pclk;
  
  
  reg [1:0] state, n_state;
  reg [4:0]count;
  parameter idle=0, setup=1, access=2;
  reg access_reached,setup_reached;
  
  always @(posedge clk)
    begin
      if(prst==1)
        begin
          pclk<=0;
          count<=0;
        end
      else 
        begin
          if(count<2)
            count=count+1;
          else 
            begin
              count=0;
              pclk=~pclk;
            end
        end
    end
               

  always @ (posedge pclk or posedge prst)
    begin
      if(prst)
        begin
          state<=idle;
//           pwdata<=0;
          pwrite<=0;
          penable<=0;
//           paddr<=0;
          psel<=0;
        end
      
      else
        state<=n_state;
      
    end
  
  
  always @(*)
    begin
      case(state)
        idle: begin
          access_reached<=0;
          setup_reached<=0;
          penable<=0;
//           pwdata<=0;
          pwrite<=0;
//           paddr<=0;
          if(start)
              n_state<=setup;
          else
            n_state <= idle;
        end
        
        
        setup: begin
          setup_reached<=1;
          penable<=0;
          if(wr==1)
            begin
              pwrite<=1;
              psel<=1;
//               paddr<=addr_p;
//               pwdata<=data_p;
              n_state<=access;
//               @(posedge pclk);
            end
          else if(wr==0)     // READ RELOOK
            begin
              pwrite<=0;
              psel<=1;
//               paddr<=addr_p;   //PRDATA
              n_state<=access;
//               @(posedge pclk);
            end
          else if(psel==0)	
            n_state<=setup;
        end
        
        access: begin
//           @(posedge pclk);
          access_reached<=1;
          penable<=1;
          if(pready==1)
            begin
              pwrite<=0;
//               pwdata<=0;
//               paddr<=0;
              psel<=0;
              n_state<=idle;
            end
          else
            n_state<=access;
        end
        
      endcase
    end
  
  assign pwdata = (state==access && wr==1)?data_p:0;
  assign paddr = (state==access)?addr_p:0;
  
  
endmodule
      
