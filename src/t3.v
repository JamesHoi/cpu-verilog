
module t3(
   input                wr, 
   input [15:0]         alu_out, 
   output reg [15:0]    out
   );

   //input         wr;
   //input [15:0]  alu_out;
   //output [15:0] out;
   //reg [15:0]    out;
   
   
   always @(wr or alu_out)
      case (wr)
         1'b1 :
            out <= 16'bZZZZZZZZZZZZZZZZ;
         1'b0 :
            out <= alu_out;
      endcase
   
endmodule
