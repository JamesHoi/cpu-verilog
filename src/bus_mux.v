
module bus_mux(
   input [2:0]       alu_in_sel,
	input [3:0]			imm,
   input [15:0]      data,
   input [15:0]      pc,
   input [15:0]      offset,
   input [15:0]      sr,
   input [15:0]      dr,
   output reg [15:0] alu_sr,
   output reg [15:0] alu_dr
);
   
   
   always @(alu_in_sel or data or pc or offset or sr or dr)
      case (alu_in_sel)
         3'b000 :
            begin
               alu_sr <= sr;
               alu_dr <= dr;
            end
         3'b001 :
            begin
               alu_sr <= sr;
               alu_dr <= 16'b0000000000000000;
            end
         3'b010 :
            begin
               alu_sr <= 16'b0000000000000000;
               alu_dr <= dr;
            end
         3'b011 :
            begin
               alu_sr <= offset;
               alu_dr <= pc;
            end
         3'b100 :
            begin
               alu_sr <= 16'b0000000000000000;
               alu_dr <= pc;
            end
			
         3'b101 :
            begin
               alu_sr <= 16'b0000000000000000;
               alu_dr <= data;
            end
			3'b110 :
				begin
					alu_sr <= imm;
					alu_dr <= dr;
				end
			3'b111 :
				begin
					alu_sr <= data;
					alu_dr <= dr;
				end
				
         default :
            begin
               alu_sr <= 16'b0000000000000000;
               alu_dr <= 16'b0000000000000000;
            end
      endcase
   
endmodule
