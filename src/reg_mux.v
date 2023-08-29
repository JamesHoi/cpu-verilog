
module reg_mux(reg_group , dest_reg, sour_reg, reg_sel, en_reg_mux, en_reg, dr, sr, reg_out);
	input [255:0]  reg_group;
   input [3:0]   dest_reg;
   input [3:0]   sour_reg;
   input [3:0]   reg_sel;
   input         en_reg_mux;
   output [15:0] en_reg;
   output [15:0] dr;
   output [15:0] sr;
   output [15:0] reg_out;
	
	assign dr = reg_group[(dest_reg+1)*16-1-:16];
	assign sr = reg_group[(sour_reg+1)*16-1-:16];
	assign reg_out = reg_group[(reg_sel+1)*16-1-:16];
	assign en_reg = (en_reg_mux == 1'b0) ? 16'b0 : (16'b0000000000000001 << dest_reg);
   
endmodule
