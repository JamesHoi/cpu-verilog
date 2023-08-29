
module reg_testa(clk, reset, input_a, input_b, input_c, cin, rec, pc_en, reg_en, q);
   input         clk;
   input         reset;
   input [2:0]   input_a;
   input [2:0]   input_b;
   input [2:0]   input_c;
   input         cin;
   input [1:0]   rec;
   input         pc_en;
   input         reg_en;
   output [15:0] q;
   reg [15:0]    q;
   
   
   always @(posedge clk or negedge reset)
   begin: xhdl0
      reg [15:0]    temp;
      temp = {1'b0, input_a, 1'b0, input_b, cin, input_c, rec, pc_en, reg_en};
      if (reset == 1'b0)
         q <= 16'b0000000000000000;
      else 
         q <= temp;
   end
   
endmodule
