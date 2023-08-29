
module register(d, clk, reset, en, q);
   input [15:0]  d;
   input         clk;
   input         reset;
   input         en;
   output [15:0] q;
   reg [15:0]    q;
   
   
   always @(posedge clk or negedge reset)
      if (reset == 1'b0)
         q <= 16'b0000000000000000;
      else 
      begin
         if (en == 1'b1)
            q <= d;
      end
   
endmodule
