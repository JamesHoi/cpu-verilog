
module ar(
   input [15:0]      alu_out,
   input [15:0]      pc,
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
            2'b01 :
               q <= pc;
            2'b11 :
               q <= alu_out;
            default :
               ;
         endcase
   
endmodule
