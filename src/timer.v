
module timer(clk, reset, ins, out);
   input            clk;
   input            reset;
   input [15:0]     ins;
   output [2:0]     out;
   reg [2:0]        out;
   
   parameter [2:0]  state_type_s0 = 0,
                    state_type_s1 = 1,
                    state_type_s2 = 2,
                    state_type_s3 = 3,
                    state_type_s4 = 4,
                    state_type_s5 = 5,
						  state_type_s6 = 6;
   reg [2:0]        state;
   
   always @(posedge clk or negedge reset)
      if (reset == 1'b0)
         state <= state_type_s0;
      else 
         case (state)
            state_type_s0 :
               state <= state_type_s1;
            state_type_s1 :
               state <= state_type_s2;
            state_type_s2 :
               if (ins[15] == 1'b0)
                  state <= state_type_s3;
               else
                  state <= state_type_s4;
            state_type_s3 :
               state <= state_type_s1;
            state_type_s4 :
               state <= state_type_s5;
            state_type_s5 :
					if(ins[15:8] == 8'b10000100)
						state <= state_type_s6;
					else
						state <= state_type_s1;
				state_type_s6 :
					state <= state_type_s1;
         endcase
   
   always @(state)
      case (state)
         state_type_s0 :
            out <= 3'b100;
         state_type_s1 :
            out <= 3'b000;
         state_type_s2 :
            out <= 3'b001;
         state_type_s3 :
            out <= 3'b011;
         state_type_s4 :
            out <= 3'b101;
         state_type_s5 :
            out <= 3'b111;
			state_type_s6 :
				out <= 3'b010;
      endcase
   
endmodule
