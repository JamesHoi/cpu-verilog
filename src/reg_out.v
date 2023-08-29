
module reg_out(
   input [15:0]      ir,
   input [15:0]      pc,
   input [15:0]      reg_in,
   input [15:0]      offset,
   input [15:0]      alu_a,
   input [15:0]      alu_b,
   input [15:0]      alu_out,
   input [15:0]      reg_testa,
   input [3:0]       reg_sel,
   input [1:0]       sel,
   output reg [15:0] reg_data
);
   
   
   always @(ir or pc or reg_in or sel or reg_sel or offset or alu_a or alu_b or alu_out or reg_testa)
   begin: xhdl0
      reg [5:0]     temp;
      temp = {sel, reg_sel};
      case (sel)
         2'b00 :
            reg_data <= reg_in;
         2'b01 :
            case (reg_sel)
               4'b0000 :
                  reg_data <= offset;
               4'b0001 :
                  reg_data <= alu_a;
               4'b0010 :
                  reg_data <= alu_b;
               4'b0011 :
                  reg_data <= alu_out;
               4'b0100 :
                  reg_data <= reg_testa;
               default :
                  reg_data <= 16'b0000000000000000;
            endcase
         2'b11 :
            case (reg_sel)
               4'b1110 :
                  reg_data <= pc;
               4'b1111 :
                  reg_data <= ir;
               default :
                  reg_data <= 16'b0000000000000000;
            endcase
         default :
            reg_data <= 16'b0000000000000000;
      endcase
   end
   
endmodule
