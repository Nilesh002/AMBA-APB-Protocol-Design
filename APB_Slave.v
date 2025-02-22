module apb_slave(pclk,pwdata,prdata,psel,penable,pready,pwrite,paddr);
  input [7:0] pwdata;
  input psel,penable;
  input pwrite;
  input [7:0]paddr;
  input pclk;
  
  output reg pready;
  output reg [7:0]prdata;
  
  reg [7:0] mem[255:0];
  
 parameter idle=0, write=1, read=2;
  reg [1:0] state=idle;
  reg [1:0] n_state;
  reg [4:0]count;

  
               

  always @ (posedge pclk )
    begin
      state <= n_state;
    end
  
  
  always @(*)
    begin
      case(state)
        idle: begin
          pready<=0;
          if(psel==1 && pwrite==1)
            n_state<=write;
          else
            if(psel==1 && pwrite==0)
              n_state<=read;
          else
            n_state<=idle;
        end
        
        
        write:
          begin
            if(psel==1 && penable==1)
              begin
                mem[paddr]<=pwdata;
                pready<=1;
                n_state<=idle;
              end
            else
              begin
                pready<=1;
                n_state<=idle;
              end
          end
        
        read:
          begin
            if(psel==1 && penable==1)
              begin
                prdata<=mem[paddr];
                pready<=1;
                n_state<=idle;
              end
            else
              begin
                pready<=1;
                n_state<=idle;
              end
          end
               
        
      endcase
    end
  
  
endmodule
      
