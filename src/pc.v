
module pc(
   input [15:0]         alu_out,
   input                en,
   input                clk,
   input                reset,
   output reg [15:0]    q
);
   
   
   always @(posedge clk or negedge reset)
      if (reset == 1'b0)
         q <= 16'b0000000000000000;
      else 
      begin
         if (en == 1'b1)
            q <= alu_out;
      end
   
endmodule
