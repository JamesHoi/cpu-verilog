
module ir(
   input [15:0]      mem_data,
   input [1:0]       rec,
   input             clk,
   input             reset,
   output reg [15:0] q
);
   
   always @(posedge clk or negedge reset)
      if (reset == 1'b0)
         q <= 16'b0000000000000000;
      else 
         case (rec)
            2'b10 :
               q <= mem_data;
            default :
               ;
         endcase
   
endmodule
