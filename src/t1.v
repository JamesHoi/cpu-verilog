
module t1(
   input       flag_c,
   input [1:0] sci,
   output reg  alu_cin
);
   
   
   always @(sci or flag_c)
      case (sci)
         2'b00 :
            alu_cin <= 1'b0;
         2'b01 :
            alu_cin <= 1'b1;
         2'b10 :
            alu_cin <= flag_c;
         default :
            alu_cin <= 1'b0;
      endcase
   
endmodule
