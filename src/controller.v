
module controller(
   input [2:0]       timer,
   input [15:0]      instruction,
   input             c,
   input             z,
   input             v,
   input             s,
   output reg [3:0]  dest_reg,
   output reg [3:0]  sour_reg,
   output reg [7:0]  offset,
   output reg [1:0]  sst,              //更新标志位使能信号
   output reg [1:0]  sci,              //alu输入进位使能
   output reg [1:0]  rec,              //ar ir 使能信号
   output reg [2:0]  alu_func,
	output reg 			alu_func2,
   output reg [2:0]  alu_in_sel,
   output reg        en_reg,
   output reg        en_pc,
   output reg        wr,
	output reg [3:0]	imm
);
   
   always @(timer or instruction or c or z or v or s)
   begin: xhdl0
      reg [7:0]    temp1;
      reg [7:0]    temp2;
      reg [3:0]    temp3;
      reg [3:0]    temp4;
      reg [1:0]    alu_out_sel;        //普通寄存器使能，pc使能
      /*
      integer      I;
      for (I = 7; I >= 0; I = I - 1)
      begin
         temp1[I] = instruction[I + 8];
         temp2[I] = instruction[I];
      end
      */
      temp1 = instruction[15:8];
      temp2 = instruction[7:0];

      /*
      for (I = 3; I >= 0; I = I - 1)
      begin
         temp3[I] = instruction[I + 4];
         temp4[I] = instruction[I];
      end
      */
      temp3 = instruction[7:4];        //dest
      temp4 = instruction[3:0];        //source


      case (timer)
         3'b100 :
            begin
               dest_reg <= 4'b0000;
               sour_reg <= 4'b0000;
               offset <= 8'b00000000;
               sci <= 2'b00;
               sst <= 2'b11;
               alu_out_sel = 2'b00;
               alu_in_sel <= 3'b000;
               alu_func <= 3'b000;
					alu_func2 <= 1'b0;
               wr <= 1'b1;
               rec <= 2'b00;
            end
         3'b000 :
            begin
               dest_reg <= 4'b0000;
               sour_reg <= 4'b0000;
               offset <= 8'b00000000;
               sci <= 2'b01; // pc=pc+1
               sst <= 2'b11;
               alu_out_sel = 2'b10;
               alu_in_sel <= 3'b100;
               alu_func <= 3'b000;
					alu_func2 <= 1'b0;
               wr <= 1'b1;
               rec <= 2'b01;
            end
         3'b001 : //ar=pc
            begin
               dest_reg <= 4'b0000;
               sour_reg <= 4'b0000;
               offset <= 8'b00000000;
               sci <= 2'b00;
               sst <= 2'b11;
               alu_out_sel = 2'b00;
               alu_in_sel <= 3'b000;
               alu_func <= 3'b000;
					alu_func2 <= 1'b0;
               wr <= 1'b1;
               rec <= 2'b10;
            end
         3'b011 :
            begin
               wr <= 1'b1;
               rec <= 2'b00;
					alu_func2 <= 1'b0;
               case (temp1)

                  //add
                  8'b00000000 :
                     begin

                        /*
                        dest_reg <= temp3;
                        sour_reg <= temp4;
                        */

                        {dest_reg, sour_reg} <= instruction[7:0];

                        offset <= 8'b00000000;
                        sci <= 2'b00;
                        sst <= 2'b00;
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b000;
                        alu_func <= 3'b000;
                     end
                  
                  //sub
                  8'b00000001 :
                     begin

                        /*
                        dest_reg <= temp3;
                        sour_reg <= temp4;
                        */

                        {dest_reg, sour_reg} <= instruction[7:0];

                        offset <= 8'b00000000;
                        sci <= 2'b00;
                        sst <= 2'b00;
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b000;
                        alu_func <= 3'b001;
                     end

                  //and
                  8'b00000010 :
                     begin
                        /*
                        dest_reg <= temp3;
                        sour_reg <= temp4;
                        */

                        {dest_reg, sour_reg} <= instruction[7:0];

                        offset <= 8'b00000000;
                        sci <= 2'b00;
                        sst <= 2'b00;
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b000;
                        alu_func <= 3'b010;
                     end

                  //cmp
                  8'b00000011 :
                     begin

                        /*
                        dest_reg <= temp3;
                        sour_reg <= temp4;
                        */

                        {dest_reg, sour_reg} <= instruction[7:0];


                        offset <= 8'b00000000;
                        sci <= 2'b00;
                        sst <= 2'b00;
                        alu_out_sel = 2'b00;
                        alu_in_sel <= 3'b000;
                        alu_func <= 3'b001;
                     end

                  
                  8'b00000100 :
                     begin

                        /*
                        dest_reg <= temp3;
                        sour_reg <= temp4;
                        */

                        {dest_reg, sour_reg} <= instruction[7:0];

                        offset <= 8'b00000000;
                        sci <= 2'b00;
                        sst <= 2'b00;
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b000;
                        alu_func <= 3'b100;
                     end

                  //xor
                  8'b00000101 :
                     begin

                        /*
                        dest_reg <= temp3;
                        sour_reg <= temp4;
                        */

                        {dest_reg, sour_reg} <= instruction[7:0];

                        offset <= 8'b00000000;
                        sci <= 2'b00;
                        sst <= 2'b00;
                        alu_out_sel = 2'b00;
                        alu_in_sel <= 3'b000;
                        alu_func <= 3'b010;
                     end

                  
                  8'b00000110 :
                     begin

                        /*
                        dest_reg <= temp3;
                        sour_reg <= temp4;
                        */

                        {dest_reg, sour_reg} <= instruction[7:0];

                        offset <= 8'b00000000;
                        sci <= 2'b00;
                        sst <= 2'b00;
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b000;
                        alu_func <= 3'b011;
                     end
                  8'b00000111 :
                     begin

                        /*
                        dest_reg <= temp3;
                        sour_reg <= temp4;
                        */

                        {dest_reg, sour_reg} <= instruction[7:0];

                        offset <= 8'b00000000;
                        sci <= 2'b00;
                        sst <= 2'b11;
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b001;
                        alu_func <= 3'b000;
                     end
                  8'b00001000 :
                     begin

                        /*
                        dest_reg <= temp3;
                        sour_reg <= temp4;
                        */

                        {dest_reg, sour_reg} <= instruction[7:0];

                        offset <= 8'b00000000;
                        sci <= 2'b01;
                        sst <= 2'b00;
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b010;
                        alu_func <= 3'b001;
                     end
                  8'b00001001 :
                     begin

                        /*
                        dest_reg <= temp3;
                        sour_reg <= temp4;
                        */

                        {dest_reg, sour_reg} <= instruction[7:0];

                        offset <= 8'b00000000;
                        sci <= 2'b01;
                        sst <= 2'b00;
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b010;
                        alu_func <= 3'b000;
                     end
							
						//lshift
                  8'b00001010 :
                     begin
                        {dest_reg, imm} <= instruction[7:0];
                        offset <= 8'b00000000;
                        sci <= 2'b00;
                        sst <= 2'b00;
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b110;
                        alu_func <= 3'b101;
                     end
						//rshift
                  8'b00001011 :
                     begin
								{dest_reg, imm} <= instruction[7:0];
                        offset <= 8'b00000000;
                        sci <= 2'b00;
                        sst <= 2'b00;
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b110;
                        alu_func <= 3'b110;
                     end
                  8'b00001100 :
                     begin
                        dest_reg <= temp3;
                        sour_reg <= temp4;
                        offset <= 8'b00000000;
                        sci <= 2'b10;
                        sst <= 2'b00;
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b000;
                        alu_func <= 3'b000;
                     end
                  8'b00001101 :
                     begin
                        dest_reg <= temp3;
                        sour_reg <= temp4;
                        offset <= 8'b00000000;
                        sci <= 2'b10;
                        sst <= 2'b00;
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b000;
                        alu_func <= 3'b001;
                     end
                  8'b01000000 :
                     begin
                        dest_reg <= 4'b0000;
                        sour_reg <= 4'b0000;
                        offset <= temp2;
                        sci <= 2'b00;
                        sst <= 2'b11;
                        alu_out_sel = 2'b10;
                        alu_in_sel <= 3'b011;
                        alu_func <= 3'b000;
                     end
                  8'b01000100 :
                     begin
                        dest_reg <= 4'b0000;
                        sour_reg <= 4'b0000;
                        offset <= temp2;
                        sci <= 2'b00;
                        sst <= 2'b11;
                        alu_out_sel = {c, 1'b0};
                        alu_in_sel <= 3'b011;
                        alu_func <= 3'b000;
                     end
                  8'b01000101 :
                     begin
                        dest_reg <= 4'b0000;
                        sour_reg <= 4'b0000;
                        offset <= temp2;
                        sci <= 2'b00;
                        sst <= 2'b11;
                        alu_out_sel = {((~c)), 1'b0};
                        alu_in_sel <= 3'b011;
                        alu_func <= 3'b000;
                     end
                  8'b01000110 :
                     begin
                        dest_reg <= 4'b0000;
                        sour_reg <= 4'b0000;
                        offset <= temp2;
                        sci <= 2'b00;
                        sst <= 2'b11;
                        alu_out_sel = {z, 1'b0};
                        alu_in_sel <= 3'b011;
                        alu_func <= 3'b000;
                     end
                  8'b01000111 :
                     begin
                        dest_reg <= 4'b0000;
                        sour_reg <= 4'b0000;
                        offset <= temp2;
                        sci <= 2'b00;
                        sst <= 2'b11;
                        alu_out_sel = {((~z)), 1'b0};
                        alu_in_sel <= 3'b011;
                        alu_func <= 3'b000;
                     end
                  8'b01000001 :
                     begin
                        dest_reg <= 4'b0000;
                        sour_reg <= 4'b0000;
                        offset <= temp2;
                        sci <= 2'b00;
                        sst <= 2'b11;
                        alu_out_sel = {s, 1'b0};
                        alu_in_sel <= 3'b011;
                        alu_func <= 3'b000;
                     end
                  8'b01000011 :
                     begin
                        dest_reg <= 4'b0000;
                        sour_reg <= 4'b0000;
                        offset <= temp2;
                        sci <= 2'b00;
                        sst <= 2'b11;
                        alu_out_sel = {((~s)), 1'b0};
                        alu_in_sel <= 3'b011;
                        alu_func <= 3'b000;
                     end
                  8'b01111000 :
                     begin
                        dest_reg <= 4'b0000;
                        sour_reg <= 4'b0000;
                        offset <= temp2;
                        sci <= 2'b00;
                        sst <= 2'b01;
                        alu_out_sel = 2'b00;
                        alu_in_sel <= 3'b000;
                        alu_func <= 3'b000;
                     end
                  8'b01111010 :
                     begin
                        dest_reg <= 4'b0000;
                        sour_reg <= 4'b0000;
                        offset <= temp2;
                        sci <= 2'b00;
                        sst <= 2'b10;
                        alu_out_sel = 2'b00;
                        alu_in_sel <= 3'b000;
                        alu_func <= 3'b000;
                     end
						8'b01111111: // NOP
							begin
								dest_reg <= 4'b0000;
                        sour_reg <= 4'b0000;
                        offset <= 8'b00000000;
                        sci <= 2'b00;
                        sst <= 2'b11;
                        alu_out_sel = 2'b00;
                        alu_in_sel <= 3'b011;
                        alu_func <= 3'b000;
							end
						8'b01100010: // not
							begin
                        dest_reg <= temp3;
                        sour_reg <= temp4;

                        offset <= 8'b00000000;
                        sci <= 2'b00;
                        sst <= 2'b00;
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b010; // just dr
                        alu_func <= 3'b000;
								alu_func2 <= 1'b1;
							end
                  8'b01100000 : //rol
                     begin
                        {dest_reg, imm} <= instruction[7:0];
                        offset <= 8'b00000000;
                        sci <= 2'b00;
                        sst <= 2'b00;
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b110;
                        alu_func <= 3'b001;
								alu_func2 <= 1'b1;
                     end
						
                  8'b01100001 : //ror
                     begin
								{dest_reg, imm} <= instruction[7:0];
                        offset <= 8'b00000000;
                        sci <= 2'b00;
                        sst <= 2'b00;
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b110;
                        alu_func <= 3'b010;
								alu_func2 <= 1'b1;
                     end
                  default :
                     ;
               endcase
            end
         3'b101 :
            begin
               alu_func <= 3'b000;
					alu_func2 <=  1'b0;
               wr <= 1'b1;
               sst <= 2'b11;
               dest_reg <= temp3;
               sour_reg <= temp4;
               offset <= 8'b00000000;
               case (temp1)
                  8'b10000000, 8'b10000001, 8'b10100001, 8'b10100010, 8'b10100011, 8'b10100100, 8'b10100101, 8'b10100110: //mvrd, jmpa, imm operation
                     begin
                        sci <= 2'b01;
                        alu_out_sel = 2'b10;
                        alu_in_sel <= 3'b100;
                        rec <= 2'b01;
                     end
                  8'b10000010 :
                     begin
                        sci <= 2'b00;
                        alu_out_sel = 2'b00;
                        alu_in_sel <= 3'b001;
                        rec <= 2'b11;
                     end
                  8'b10000011 :
                     begin
                        sci <= 2'b00;
                        alu_out_sel = 2'b00;
                        alu_in_sel <= 3'b010;
                        rec <= 2'b11;
                     end
						8'b10000100, 8'b10000101: // push or pop ar<-sp and pop sp=sp-1
							begin
								dest_reg <= 4'b1111;
								sour_reg <= temp3; // dont care
								sci <= (temp1 == 8'b10000101) ? 2'b01 : 2'b00;
								alu_out_sel = 2'b01;
								alu_in_sel <= 3'b010; // just dr
								alu_func <= 3'b001; // sub
								rec <= 2'b11;
							end
						default :
                     ;
               endcase
            end
         3'b111 :
            begin
               dest_reg <= temp3;
               sour_reg <= temp4;
               offset <= 8'b00000000;
               sci <= 2'b00;
               sst <= 2'b11;
               alu_func <= 3'b000;
					alu_func2 <=  1'b0;
               rec <= 2'b00;
               case (temp1)
                  8'b10000010, 8'b10000001 :
                     begin
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b101;
                        wr <= 1'b1;
                     end
                  8'b10000000 :
                     begin
                        alu_out_sel = 2'b10;
                        alu_in_sel <= 3'b101;
                        wr <= 1'b1;
                     end
                  8'b10000011 :
                     begin
                        alu_out_sel = 2'b00;
                        alu_in_sel <= 3'b001;
                        wr <= 1'b0;
                     end
						8'b10000100 : // push 
							begin
								sour_reg <= temp3;
								alu_out_sel = 2'b00;
                        alu_in_sel <= 3'b001;
								wr <= 1'b0;
							end
						8'b10000101 : // pop
							begin
								dest_reg <= temp3;
								alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b101;
								wr <= 1'b1;
							end
						                  //addi
                  8'b10100001 :
                     begin
                        sci <= 2'b00;
                        sst <= 2'b00;
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b111;
                        alu_func <= 3'b000;
                     end
						8'b10100010 :		//subi
                     begin
                        sci <= 2'b00;
                        sst <= 2'b00;
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b111;
                        alu_func <= 3'b001;
                     end
						8'b10100011 :		//ori
                     begin
                        sci <= 2'b00;
                        sst <= 2'b00;
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b111;
                        alu_func <= 3'b011;
                     end
						8'b10100100 :		//andi
                     begin
                        sci <= 2'b00;
                        sst <= 2'b00;
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b111;
                        alu_func <= 3'b010;
                     end
						8'b10100101:		//xori
                     begin
                        sci <= 2'b00;
                        sst <= 2'b00;
                        alu_out_sel = 2'b01;
                        alu_in_sel <= 3'b111;
                        alu_func <= 3'b100;
                     end
						8'b10100110 :		//cmpi
                     begin
                        sci <= 2'b00;
                        sst <= 2'b00;
                        alu_out_sel = 2'b00;
                        alu_in_sel <= 3'b111;
                        alu_func <= 3'b001;
                     end
                  default :
                     ;
               endcase
            end
			3'b010 :
				begin	
					case(temp1)
						8'b10000100: // push sp=sp+1
							begin
								offset <= 8'b00000000;
								sst <= 2'b11;
								wr <= 1'b1;
								rec <= 2'b00;
								dest_reg <= 4'b1111;
								sour_reg <= temp3; // dont care
								sci <= 2'b01;
								alu_out_sel = 2'b01;
								alu_in_sel <= 3'b010;
								alu_func <=  3'b000; // add
								alu_func2 <=  1'b0;
							end
						8'b10100001, 8'b10100010, 8'b10100011, 8'b10100100, 8'b10100101, 8'b10100110:
							begin
								sci <= 2'b00;
								sst <= 2'b11;
                        alu_out_sel = 2'b00;
								alu_func <= 3'b000;
								alu_func2 <=  1'b0;
                        alu_in_sel <= 3'b010;
                        rec <= 2'b00;
								wr <= 1'b1;
							end
						default :
							begin
							
							
							end
					endcase
				end
         default :
            ;
      endcase


      /*
      en_reg <= alu_out_sel[0];
      en_pc <= alu_out_sel[1];
      */

      {en_pc,en_reg} <= alu_out_sel;


      
   end
   
endmodule
