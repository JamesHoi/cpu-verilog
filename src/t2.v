
module t2(
   input [7:0]       offset_8,
   output reg [15:0] offset_16
);
   
   
   always @(offset_8)
      if (offset_8[7] == 1'b1)
         offset_16 <= {8'b11111111, offset_8};
      else
         offset_16 <= {8'b00000000, offset_8};
   
endmodule
