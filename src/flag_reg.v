
module flag_reg(
   input [1:0] sst,
   input       c,
   input       z,
   input       v,
   input       s,
   input       clk,
   input       reset,
   output reg  flag_c,
   output reg  flag_z,
   output reg  flag_v,
   output reg  flag_s
);
   
   
   always @(posedge clk or negedge reset)
      if (reset == 1'b0)
         {flag_c, flag_s, flag_v, flag_z} <= 4'b0000;
      else 
         case (sst)
            2'b00 :
            /*
               begin
                  flag_c <= c;
                  flag_z <= z;
                  flag_v <= v;
                  flag_s <= s;
               end
               */
               {flag_c, flag_z, flag_v, flag_s} <= {c,z,v,s};
            2'b01 :
               flag_c <= 1'b0;
            2'b10 :
               flag_c <= 1'b1;
            default:
               ;
         endcase
   
endmodule
