
module alu(
   input             cin,
   input [15:0]      alu_a,			//source reg or imm
   input [15:0]      alu_b,			//dest reg
   input [2:0]       alu_func,
	input 				alu_func2,
   output reg [15:0] alu_out,       //alu计算结果的输出
   output reg        c,             //进位、借位
   output reg        z,             //清零
   output reg        v,             //溢出
   output reg        s              //负数

);
   
   
   always @(alu_a or alu_b or cin or alu_func)
   begin: xhdl0
      reg [15:0]    temp1;
      reg [15:0]    temp2;
      reg [15:0]    temp3;
      temp1 = {15'b000000000000000, cin};
		
		case (alu_func2)
			1'b0 :
				case (alu_func)
					3'b000 :
						temp2 = alu_b + alu_a + temp1;            //add    ra + rb
					3'b001 :
						temp2 = alu_b - alu_a - temp1;            //sub		
					3'b010 :
						temp2 = alu_a & alu_b;                    //and
					3'b011 :
						temp2 = alu_a | alu_b;                    //or
					3'b100 :
						temp2 = alu_a ^ alu_b;                    //xor
					3'b101 :
						temp2 = alu_b << alu_a; //lshift		ra << immb
					3'b110 :
						temp2 = alu_b >> alu_a; //rshift		ra >> immb
					default :
						temp2 = 16'b0000000000000000;
				endcase
			1'b1 :
				case (alu_func)
					3'b000 :
						temp2 = ~alu_b;						// not 
					3'b001 :
						temp2 = alu_b << alu_a | alu_b >> (16-alu_a); // rol
					3'b010 :
						temp2 = alu_b >> alu_a | alu_b << (16-alu_a); // ror
					default:
						;
				endcase
			default :
					;
      endcase

      alu_out <= temp2;
      if (temp2 == 16'b0000000000000000)
         z <= 1'b1;
      else
         z <= 1'b0;
      if (temp2[15] == 1'b1)
         s <= 1'b1;
      else
         s <= 1'b0;

      case (alu_func)
         //加减过程判断是否溢出
         3'b000, 3'b001 :
            if ((alu_a[15] == 1'b1 & alu_b[15] == 1'b1 & temp2[15] == 1'b0) | (alu_a[15] == 1'b0 & alu_b[15] == 1'b0 & temp2[15] == 1'b1))
               v <= 1'b1;
            else
               v <= 1'b0;
         default :
            v <= 1'b0;
      endcase

      case (alu_func)
         //进位
         3'b000 :
            begin
               temp3 = 16'b1111111111111111 - alu_b - temp1;
               if (temp3 < alu_a)
                  c <= 1'b1;
               else
                  c <= 1'b0;
            end
         
         //借位
         3'b001 :
            if (alu_b < alu_a)
               c <= 1'b1;
            else
               c <= 1'b0;
         3'b101 :
            c <= alu_b[15];
         3'b110 :
            c <= alu_b[0];
         default :
            c <= 1'b0;
      endcase
   end
   
endmodule
